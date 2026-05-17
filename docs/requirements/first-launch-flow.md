---
type: doc
project: mathPuzzle
doc_lane: requirements
updated_at: 2026-05-17T12:00:00
tags: [docs, requirements, onboarding]
---

# First Launch & Navigation Flow

Resolves **S01 routing** and **O8/O9** until HUMAN decides.

## App meta (persisted)

See [data-contracts.md](../technical/data-contracts.md) `appMeta`. Keys:

| Key | Default | Meaning |
|-----|---------|---------|
| `onboardingSeen` | `false` | User finished or skipped S02 |
| `tutorialSeen` | `false` | User finished S03 or guided L1 |

## Splash (S01) routing

```
S01 Splash
  ├─ onboardingSeen == false  → S02 Onboarding
  ├─ onboardingSeen && !tutorialSeen && O8≠skip-only → S03 Tutorial (provisional)
  └─ else → S04 Level Select
```

| Case | Route |
|------|-------|
| First install | S02 → (Skip) S04 OR (Continue) S03 → S04 |
| Returning player | S04 directly |
| O8 = skippable | S02 shows **Skip** always → sets `onboardingSeen` |

## O9 provisional (recommended)

| Option | Implementation |
|--------|----------------|
| **A — Guided Level 1** (recommended) | S03 = S05 with `levelId=1` + coach marks; **no** hint/answer ads |
| B — Level 0 content | Extra JSON `id:0` not in 100 count — **not recommended** |

Until O9 decided, implement **Option A** in specs.

## Tutorial ad policy

On S03 / guided Level 1: **Hint and Show Answer hidden or disabled** — PRD §3.3.1, E3-11.

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
