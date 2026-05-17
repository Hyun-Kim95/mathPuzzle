---
type: doc
project: mathPuzzle
doc_lane: requirements
updated_at: 2026-05-17T00:00:00
tags: [docs, requirements, policy]
---

# Policy Matrix (Quick Reference)

**SSOT:** [PRD.md](../PRD.md). This table is for implementation lookup only.

| Domain | Rule (summary) | PRD |
|--------|----------------|-----|
| Auth | No login; local `deviceId` for support only | §3.2 |
| Unlock | Level 1 open; *n* cleared → *n+1*; no skip | §3.1.5 |
| Clear | Submit correct answer; ad-view ≠ clear | §3.1.5–3.1.6 |
| Perfect ★ | No hint ad & no answer ad before clear | §3.1.6 |
| Hint ad | 1 rewarded view → hint unlocked forever (device) | §3.3.1 |
| Answer ad | 1 rewarded view → answer + explanation unlocked | §3.3.1 |
| Tutorial | No hint/answer ads | §3.3.1 |
| Donate | No gameplay or ad bypass | §3.5 |
| Reset | Wipes progress, unlocks, stars; keeps sound & IAP | §3.7 |
| Offline play | Levels + audio local; ads/IAP need network | §6 |
| UI language | English only v1 | §5 |
| Fail-safe | No unlock/clear/payment on ambiguous failure | §16.0 |
| First launch | `appMeta` routing — no ads on tutorial | [first-launch-flow.md](first-launch-flow.md) |
| Reset | Progress wipe; **keeps** settings (audio, theme) | [data-contracts.md](../technical/data-contracts.md) |

## Doc SSOT order

PRD → data-contracts → level.schema → ui-states → screen-spec. Details: [document-audit.md](../qa/document-audit.md).

## Edge cases

Full catalog: PRD **§16**. QA P0 list: [edge-case-p0-checklist.md](../qa/edge-case-p0-checklist.md).

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
