---
type: doc
project: mathPuzzle
doc_lane: decisions
updated_at: 2026-05-18T00:00:00
tags: [docs, adr]
---

# ADR-0005: AdMob, Age Rating, COPPA (O4, O7, O10)

## Status

Accepted (2026-05-18) — implementation default; **reconfirm before store submission**

## Decisions

| ID | Choice |
|----|--------|
| **O4** | **Google AdMob** — Rewarded Video for hint/answer |
| **O7** | **Everyone** (ESRB / Play content rating target) |
| **O10** | **Child-directed treatment** — UMP before first ad; non-personalized when required; no behavioral ads for children |

## Implementation notes

- Debug builds: Google test app ID + test rewarded unit ([phase2_placeholders.dart](../../app/lib/domain/monetization/phase2_placeholders.dart))
- Production ad unit IDs: environment / Play Console — **not committed**
- Tutorial / Level 1 guide: Hint & Answer disabled (E3-11)
- Reconfirm with legal counsel before publishing Privacy Policy

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
