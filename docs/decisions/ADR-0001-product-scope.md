---
type: doc
project: mathPuzzle
doc_lane: decisions
updated_at: 2026-05-17T00:00:00
tags: [docs, adr]
---

# ADR-0001: v1 Product Scope

## Status

Accepted (2026-05-17) — aligned with PRD v1.2

## Context

Build a Math Riddles–style offline puzzle app with ad-gated hints/answers and no accounts.

## Decision

Ship **v1.0** with:

- 100 sequential logic puzzles (local JSON)
- Guest-only; local progress
- Rewarded video per hint and per answer (max 2 ads/level lifetime)
- IAP tip monetization only (O2); **no in-app contact** (O3, superseded by ADR-0003)
- BGM + SFX with master/individual mute
- English UI only
- No web, no cloud sync, no leaderboard

## Consequences

- Progress loss on uninstall is acceptable; document in FAQ/store
- No backend for v1
- Content pipeline (100 puzzles) is on critical path parallel to app shell

## References

- [PRD.md](../PRD.md)
- [ADR tracked open items](open-decisions.md)

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
