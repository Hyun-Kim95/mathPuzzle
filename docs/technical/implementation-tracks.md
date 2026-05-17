---
type: doc
project: mathPuzzle
doc_lane: technical
updated_at: 2026-05-17T20:00:00
tags: [docs, technical, planning]
---

# Implementation Tracks (Gate 2 prep)

**Gate 2** (parallel work) allowed after: design approval + [client-services-contract.md](client-services-contract.md) + [data-contracts.md](data-contracts.md) stable.

**Stack (2026-05-17):** Flutter — [ADR-0002](../decisions/ADR-0002-brand-stack-theme.md). Brand **mathPuzzle**. Light + dark themes required.

## Track A — App shell (frontend-agent)

| Deliverable | Depends on |
|-------------|------------|
| Navigation S01–S12 | screen-inventory |
| Progress / settings persistence | data-contracts |
| Puzzle renderer + submit validation | level schema + samples |
| Ad modal + unlock flow | integrations (test ad units) |
| Audio service | asset list TBD |
| Settings, donate UI (no contact v1) | ui-states-and-copy |

**Files:** `app/` — Flutter (`lib/`, `pubspec.yaml`). Theme: `lib/theme/app_theme.dart` from design tokens. Settings: `ThemeMode` persistence in progress blob or separate prefs key.

## Track B — Content (prd-agent / author)

| Deliverable | Depends on |
|-------------|------------|
| 100 level JSON files | level.schema.json |
| CONTENT_SHEET sign-off | difficulty curve PRD §3.1.2 |
| CI validate script | data-contracts validation rules |

**Files:** `content/levels/*.json` — low conflict with Track A

## Track C — Store & compliance (docs-agent)

| Deliverable | Depends on |
|-------------|------------|
| Privacy policy page | integrations |
| Store listings (en) | **mathPuzzle** — [store-listing-outline.md](../requirements/store-listing-outline.md) |
| Data safety form | PRD §6 |

## Integration owner

Single agent/session merges: progress flags ↔ ad callbacks ↔ clear/perfect rules.

## Conflict hotspots

| Area | Mitigation |
|------|------------|
| `perfect` vs ad unlock timing | Write unlock before clear; compute perfect at submit |
| Progress save vs kill | Save before celebrate UI |
| String keys | Only `ui-states-and-copy.md` / `strings.en.json` |

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
