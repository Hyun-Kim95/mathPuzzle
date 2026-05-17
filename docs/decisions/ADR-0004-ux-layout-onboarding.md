---
type: doc
project: mathPuzzle
doc_lane: decisions
updated_at: 2026-05-17T22:00:00
tags: [docs, adr]
---

# ADR-0004: Level Map Layout & Onboarding (O5, O8, O9)

## Status

Accepted (2026-05-17) — per vertical-slice plan (PRD recommendations)

## Decisions

| ID | Choice |
|----|--------|
| **O5** | **5 chapters × 20 levels** — Chapter sections on level select (aligns Stitch Option B) |
| **O8** | **Skippable** onboarding — Skip sets `onboardingSeen` → level select |
| **O9** | **Guided Level 1** — no separate Level 0 content id; tutorial overlay deferred post–vertical-slice |

## Vertical-slice scope

- Level select shows **Chapter 1** with levels 1–5 playable; chapters 2–5 visible as locked sections.
- S02 minimal: single skip onboarding page.
- S03 not in slice; `tutorialSeen` defaults false until Phase 3.

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
