---
type: doc
project: mathPuzzle
doc_lane: design
updated_at: 2026-05-17T18:00:00
tags: [docs, design, screen-spec]
status: draft
---

# Screen Spec v1 (Text)

**Status:** Text spec + **visual Option B (Stitch)** — [design-ab-comparison.md](design-ab-comparison.md). Layout/components follow [mock-b-stitch/output/screens/](mock-b-stitch/output/screens/) where they extend this doc.

**Related:** [screen-inventory.md](../requirements/screen-inventory.md), [ui-states-and-copy.md](ui-states-and-copy.md), [design-option-b-stitch.md](design-option-b-stitch.md)

## Global

| Item | Spec |
|------|------|
| Orientation | Portrait primary (§16 E7-05) |
| Touch target | Min 44×44 pt |
| Theme | **Light + dark required** — default OS (`ThemeMode.system`); Settings: System / Light / Dark — [ADR-0002](../decisions/ADR-0002-brand-stack-theme.md), [design-tokens-v0.md](design-tokens-v0.md) |
| Brand (display) | **mathPuzzle** on splash, headers, About |
| Typography | [design-tokens-v0.md](design-tokens-v0.md) (Option B) |

## S01 — Splash

| Element | Behavior |
|---------|----------|
| Brand | **mathPuzzle** + tagline e.g. “Find the rule. Fill the blank.” |
| Duration | Min display ~1s; navigate when progress loaded |
| Next | [first-launch-flow.md](../requirements/first-launch-flow.md) |

## S02 — Onboarding (optional)

| Element | Behavior |
|---------|----------|
| Pages | 1–3 swipe (value prop); O8 skippable |
| Skip | → S04; sets `onboardingSeen` |
| Continue | → S03 (provisional) or S04 if O9 waived |

## S03 — Tutorial (provisional)

Guided **Level 1** play — hint/answer **hidden**; see O9 in [open-decisions.md](../decisions/open-decisions.md).

## S04 — Level select

```
┌─────────────────────────┐
│  Levels          [⚙]    │
├─────────────────────────┤
│  Progress: 12 / 100     │
│  ┌──┬──┬──┬──┬──┐       │
│  │✓1│✓2│★3│ 4│🔒5│ ...  │  ← grid or chapter list
│  └──┴──┴──┴──┴──┘       │
│  (optional banner ad)   │
└─────────────────────────┘
```

| Element | Behavior |
|---------|----------|
| Cell states | locked / unlocked / completed (✓) / perfect (★) |
| Locked tap | Toast — policy matrix |
| Settings | → S08 |

## S05 — Puzzle play

```
┌─────────────────────────┐
│  ← Level 12             │
├─────────────────────────┤
│  [prompt text / visual] │
│                         │
│  [ numeric input ]      │
├─────────────────────────┤
│  [ Submit ]             │
│  [ Hint ] [ Answer ]    │
└─────────────────────────┘
```

| Element | Behavior |
|---------|----------|
| Submit | Disabled if empty / invalid / in-flight |
| Hint / Answer | Opens ad modal unless already unlocked |
| Hint panel | Below prompt when unlocked |
| Answer panel | Shows answer + explanation when unlocked |
| Correct | → S06 |
| Wrong | Shake optional; “Try again” — no answer leak |
| Back (← / Android back) | Confirm dialog — E7-03 |

## S06 — Level complete

| Element | Behavior |
|---------|----------|
| Message | Success + ★ if perfect |
| CTA | Next level (if &lt;100) → S05; Back to levels → S04 |

## S07 — All complete

| Element | Behavior |
|---------|----------|
| Copy | `allCompleteTitle` |
| CTA | Back to levels → S04 |

## S09 — Contact

Form: email (optional), subject, message; Send disabled while sending.

## S10 — Donate

Tip tiers per O2; thank-you state only.

## S11 — Legal

WebView or external browser; offline → E4-09 class message.

## S12 — About

App name, version, credits.

## Ad unlock modal (overlay)

| Element | Copy (en) |
|---------|-----------|
| Title | Watch a short video |
| Body | Unlock hint / Unlock answer (contextual) |
| Primary | Watch |
| Secondary | Cancel |

States: loading (spinner), error + Retry — §16.3

## S08 — Settings

| Row | Type |
|-----|------|
| Appearance | Segmented or list: System / Light / Dark → `ThemeMode` |
| Master mute | Toggle |
| BGM | Toggle |
| SFX | Toggle |
| Support developer | Navigation |
| Privacy policy | Link |
| Terms of use | Link |
| About | Navigation |
| Reset progress | Destructive → 2-step confirm |

## Approval log

| Date | Mock A | Mock B | Selected | Approver |
|------|--------|--------|----------|----------|
| 2026-05-17 | [mock-a/index.html](mock-a/index.html) | [mock-b-stitch/output/screens/](mock-b-stitch/output/screens/) · project `4485680357817047125` | **B (Stitch)** | HUMAN |

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
