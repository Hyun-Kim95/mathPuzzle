---
type: doc
project: mathPuzzle
doc_lane: qa
updated_at: 2026-05-17T00:00:00
tags: [docs, qa, edge-cases]
---

# Edge Case P0 Checklist

**SSOT:** [PRD.md](../PRD.md) §16. Mark Pass / Fail / N/A per build.

## E1 — Puzzle / submit

| ID | Scenario | Pass |
|----|----------|------|
| E1-01 | Submit disabled when empty | ☐ |
| E1-02 | Out of range blocked + message | ☐ |
| E1-03 | Invalid chars blocked | ☐ |
| E1-04 | Leading zeros normalize (`001` = `1`) | ☐ |
| E1-06 | Answer unlocked via ad → submit still clears (no ★) | ☐ |
| E1-07 | Answer unlocked, no submit → next locked | ☐ |
| E1-09 | Broken level JSON → error + back to list | ☐ |
| E1-11 | Locked level cannot open | ☐ |
| E1-12 | Bad level id → fallback list | ☐ |
| E1-13 | Kill after submit before save → no false clear on relaunch | ☐ |
| E1-14 | Level 100 → all complete screen | ☐ |

## E2 — Progress

| ID | Scenario | Pass |
|----|----------|------|
| E2-01 | Fresh install → only level 1 | ☐ |
| E2-02 | Corrupt storage → fresh + message | ☐ |
| E2-03 | Save failure → retry toast | ☐ |
| E2-05 | Reset cancel → no change | ☐ |
| E2-06 | Reset confirm → only L1, toast | ☐ |

## E3 — Ads

| ID | Scenario | Pass |
|----|----------|------|
| E3-01 | Offline / timeout → no unlock, retry | ☐ |
| E3-02 | Close early → no unlock | ☐ |
| E3-03 | Kill before reward → no unlock | ☐ |
| E3-04 | Kill after reward → unlock on relaunch | ☐ |
| E3-05 | Duplicate callback → single unlock | ☐ |
| E3-06 | Re-open hint/answer → no second ad | ☐ |
| E3-07 | Interrupt mid-ad → no unlock if no reward | ☐ |
| E3-08 | No consent → blocked message | ☐ |
| E3-09 | No fill → retry message | ☐ |
| E3-11 | Tutorial → hint/answer disabled | ☐ |

## E4 — Contact

**v1 N/A** (O3). Test **E4-09** under Settings → Privacy/Terms link failure instead.

## E5 — IAP

| ID | Scenario | Pass |
|----|----------|------|
| E5-01 | Cancel → no state change | ☐ |
| E5-02 | Fail → no state change | ☐ |
| E5-04 | Success → thanks only, no perks | ☐ |

## E6 — Audio

| ID | Scenario | Pass |
|----|----------|------|
| E6-03 | Background pauses BGM | ☐ |
| E6-05 | Master mute silences SFX on correct | ☐ |

## E7 — System

| ID | Scenario | Pass |
|----|----------|------|
| E7-04 | Back from settings → level list | ☐ |

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
