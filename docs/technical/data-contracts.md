---
type: doc
project: mathPuzzle
doc_lane: technical
updated_at: 2026-05-17T12:00:00
tags: [docs, technical, schema]
---

# Data Contracts

**SSOT for product rules:** [PRD.md](../PRD.md).  
**Level authoring:** [content/levels/level.schema.json](../../content/levels/level.schema.json).

## 1. Level (bundle JSON)

One file per level or single `levels.json` array — implementation choice.

### Required fields

| Field | Type | Notes |
|-------|------|-------|
| `id` | integer 1–100 | Unique |
| `title` | string | e.g. `"Level 1"` |
| `type` | enum | `number_grid` \| `shape_number` \| `operator_pattern` \| `missing_term` \| `visual_equation` |
| `prompt` | string | English |
| `input` | object | See below |
| `answer` | number \| string | Match `input.mode` |
| `hint` | string | Shown after rewarded ad |
| `explanation` | string | Shown with answer unlock |
| `difficulty` | enum | `easy` \| `medium` \| `hard` \| `expert` |

### `input` object

| Field | Type | Required when |
|-------|------|----------------|
| `mode` | `"numeric"` \| `"choice"` | always |
| `min` | integer | `numeric` |
| `max` | integer | `numeric` |
| `choices` | array | `choice` — see below |

**Choice item:**

```json
{ "id": "a", "label": "12" }
```

Answer for choice mode: `answer` = `choiceId` string (e.g. `"a"`).

### Optional

| Field | Type |
|-------|------|
| `assets.image` | string \| null — bundle path |
| `assets.layout` | string — renderer hint |
| `tags` | string[] |

### Validation (CI)

- `id` unique 1–100, no gaps in release bundle
- `answer` within `min`/`max` for numeric
- `choices` length ≥ 2 when `mode === "choice"`
- All strings non-empty

## 2. Progress blob (local storage)

**Storage key (suggested):** `@mathPuzzle/progress_v1`  
**Schema version:** `1`

```json
{
  "schemaVersion": 1,
  "deviceId": "uuid-v4",
  "highestUnlocked": 1,
  "levels": {
    "1": {
      "completed": false,
      "perfect": false,
      "hintUnlocked": false,
      "answerUnlocked": false
    }
  }
}
```

### Field rules

| Field | Rule |
|-------|------|
| `highestUnlocked` | Max level id player may enter; starts `1` |
| `completed` | `true` only after successful Submit |
| `perfect` | `true` only if completed without ever setting hint/answer unlock |
| `hintUnlocked` / `answerUnlocked` | Set on ad reward; persist across sessions |
| Inconsistency E2-08 | If `completed` false, treat as not cleared regardless of unlock flags |

### Sparse `levels` map

- Only store keys for levels with **any** flag set (`completed`, `perfect`, `hintUnlocked`, `answerUnlocked`).
- **Entry permission:** `levelId <= highestUnlocked` (SSOT for unlock).
- Missing key ⇒ all flags false for that level.

### Perfect (★) on clear level *n*

At successful Submit:

```
perfect = !(levels[n].hintUnlocked || levels[n].answerUnlocked)
```

(Set `completed = true` in same transaction. If either unlock was ever true, ★ is false even if user knew the answer.)

### On clear level *n*

1. Apply Perfect rule above; set `completed = true`  
2. `highestUnlocked = max(highestUnlocked, n + 1)` capped at 100  
3. Persist **before** showing level-complete UI (E1-13)

### `deviceId`

- **v1:** not stored or used (O3 — no contact).

### On reset

Replace progress with factory default (`highestUnlocked: 1`, empty `levels`).  
**Also reset:** `appMeta` optional — see below (re-show onboarding: product choice; default **keep** `onboardingSeen` to avoid repeat).  
**Do not reset:** settings.  
Sound settings **not** in this blob.

## 2b. App meta blob

**Storage key:** `@mathPuzzle/app_meta_v1` (may be embedded in progress blob instead — pick one store in implementation)

```json
{
  "schemaVersion": 1,
  "onboardingSeen": false,
  "tutorialSeen": false
}
```

Routing: [first-launch-flow.md](../requirements/first-launch-flow.md).

| Reset progress | Default policy |
|----------------|----------------|
| `onboardingSeen` | **Keep `true`** if already seen (avoid forced replay) |
| `tutorialSeen` | Keep |

## 3. Settings blob

**Storage key:** `@mathPuzzle/settings_v1`

```json
{
  "schemaVersion": 1,
  "themeMode": "system",
  "adsConsentGranted": false,
  "masterMute": false,
  "bgmEnabled": true,
  "sfxEnabled": true
}
```

`themeMode`: `"system"` | `"light"` | `"dark"` — maps to Flutter `ThemeMode` (ADR-0002).

## 4. Contact rate limit

**v1:** N/A (O3 — no contact feature).

## 5. Migration

| From | To | Action |
|------|-----|--------|
| missing | v1 | Factory defaults |
| corrupt JSON | v1 | Backup `*.corrupt.bak`, factory + toast E2-02 |
| v1 | v2 | TBD; failure → E2-02 |

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
