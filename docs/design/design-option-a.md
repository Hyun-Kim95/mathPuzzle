---
type: doc
project: mathPuzzle
doc_lane: design
updated_at: 2026-05-17T12:00:00
tags: [docs, design, option-a]
---

# Design Option A — 자체안 (Minimal Logic)

> **Archive:** Not selected. HUMAN chose **Option B (Stitch)** on 2026-05-17 — see [design-ab-comparison.md](design-ab-comparison.md).

## Concept

- **Tone:** Calm, focused, “textbook logic” — low distraction for 100-level grind.
- **Layout:** Flat cards, 5-column level grid, clear hierarchy.
- **Color:** Indigo primary on neutral gray (`design-tokens-v0` light/dark).

## Deliverables

| Asset | Path |
|-------|------|
| Interactive mock | [mock-a/index.html](mock-a/index.html) (browser) |
| Styles | [mock-a/styles.css](mock-a/styles.css) |
| Text spec | [screen-spec-v1.md](screen-spec-v1.md) |

## Screens in mock

| ID | Included |
|----|----------|
| S01 Splash | Yes |
| S04 Level select | Yes (20 cells sample) |
| S05 Puzzle | Yes + hint panel |
| S06 Complete | Yes |
| S08 Settings | Yes |
| Ad modal | Yes (toolbar trigger) |
| S02–S03, S07, S09–S12 | Text spec only |

## States demonstrated

- Light / dark toggle
- Level: locked, current, done, perfect (★)
- Hint panel unlocked
- Ad modal default + cancel

## Implementation notes

- Chapter layout (O5-B) **not** used — uses grid per screen-spec draft.
- Maps 1:1 to Expo/RN `StyleSheet` from tokens v0.

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
