---
type: doc
project: mathPuzzle
doc_lane: decisions
updated_at: 2026-05-17T20:00:00
tags: [docs, adr]
---

# ADR-0002: Brand, Mobile Stack, Theme

## Status

Accepted (2026-05-17) — HUMAN

## Context

Option B (Stitch) selected for visuals. Implementation blockers included O6 (brand) and O11 (stack). Stitch exports used placeholder names (Mathemagix, ELITE).

## Decision

| Topic | Choice |
|-------|--------|
| **Display name** | **mathPuzzle** (store title, splash, About, in-app headers) |
| **Bundle ID (recommended)** | `com.mathpuzzle.app` — confirm at store registration |
| **Mobile stack** | **Flutter** (Dart 3.x) |
| **Theme** | **Light + dark supported** — default follows OS (`ThemeMode.system`); Settings offers System / Light / Dark |
| **Design tokens** | [design-tokens-v0.md](../design/design-tokens-v0.md) (Option B palette; dark column required at implement time) |
| **Visual reference** | Stitch Option B screens; replace on-screen brand strings with **mathPuzzle** |

## Consequences

- `app/` scaffold uses Flutter (`MaterialApp` + `ThemeData` light/dark).
- CI/build: Flutter toolchain (Android/iOS); not Expo/EAS.
- Stitch HTML/PNG remain reference until `stitch screen edit` or Flutter UI matches tokens.
- English UI copy unchanged; brand string **mathPuzzle** is proper noun casing.

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
