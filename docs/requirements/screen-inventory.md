---
type: doc
project: mathPuzzle
doc_lane: requirements
updated_at: 2026-05-17T00:00:00
tags: [docs, requirements, screens]
links:
  - "[[mathPuzzle/docs/PRD]]"
  - "[[mathPuzzle/docs/design/screen-spec-v1]]"
---

# Screen Inventory

Derived from [PRD.md](../PRD.md) §4. Route names are implementation placeholders.

## Screen list

| ID | Screen | Route (suggested) | Entry | Primary actions |
|----|--------|-------------------|-------|-----------------|
| S01 | Splash | `/` | App launch | See [first-launch-flow.md](first-launch-flow.md) |
| S02 | Onboarding | `/onboarding` | First launch (optional) | Skip → S04; Continue → S03 |
| S03 | Tutorial puzzle | `/tutorial` | Onboarding or first-time flag | Guided solve (no ads) → S04 |
| S04 | Level select | `/levels` | Splash / back from play | Tap level → S05; Settings → S08 |
| S05 | Puzzle play | `/play/:levelId` | Level select | Submit, Hint, Show Answer |
| S06 | Level complete | `/play/:levelId/complete` | Correct submit | Next level → S05; Levels → S04 |
| S07 | All complete | `/complete` | Level 100 cleared | Back to levels → S04 |
| S08 | Settings | `/settings` | Level select header | Appearance, Sound, Donate, Legal, Reset |
| S09 | Contact | — | — | **v1 removed** (O3) |
| S10 | Donate | `/settings/donate` | Settings | IAP consumable tips only (O2) |
| S11 | Legal (webview) | `/settings/legal/:doc` | Settings | privacy \| terms |
| S12 | About | `/settings/about` | Settings | Version, credits |
| — | Ad unlock modal | overlay | Hint / Answer on S05 | Watch ad, Cancel |
| — | Reset confirm | modal on S08 | Reset progress | Confirm / Cancel |

## Navigation rules

| Rule | PRD ref |
|------|---------|
| Locked level tap | Toast: “Complete the previous level first.” — §16 E1-11 |
| Invalid `levelId` | Fallback S04 — §16 E1-12 |
| Android back on S05 | Confirm leave or save draft input — §16 E7-03 |
| Android back on S08 | → S04 | §16 E7-04 |

## Level select presentation (O5)

| Option | Notes |
|--------|-------|
| A — 10×10 grid | Dense; scroll entire grid |
| B — Chapters 5×20 | Sections “Chapter 1” … with 20 levels each |

**Status:** **Decided** — 5 chapters × 20 ([ADR-0004](../decisions/ADR-0004-ux-layout-onboarding.md)).

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
