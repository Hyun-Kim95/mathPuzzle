---
type: doc
project: mathPuzzle
doc_lane: design
updated_at: 2026-05-17T18:00:00
tags: [docs, design, tokens]
status: approved-option-b
---

# Design Tokens v0

**Source:** Option B — [stitch-design-system.json](mock-b-stitch/stitch-design-system.json), [prompts/_design-system.txt](mock-b-stitch/prompts/_design-system.txt). Selected in [design-ab-comparison.md](design-ab-comparison.md).

**Theme policy (ADR-0002):** v1 **must** ship light and dark. Default `ThemeMode.system`; Settings: System / Light / Dark. Stitch reference PNGs are mostly light — implement dark in Flutter from the dark column below.

## Semantic colors (light / dark)

| Token | Light | Dark | Use |
|-------|-------|------|-----|
| `color.bg` | `#FFF8F0` | `#0F172A` | Screen background |
| `color.surface` | `#FFFFFF` | `#1E293B` | Cards, inputs |
| `color.primary` | `#7C3AED` | `#8B5CF6` | Primary CTA, links |
| `color.accent` | `#06B6D4` | `#22D3EE` | Highlights, gradient end |
| `color.success` | `#22C55E` | `#4ADE80` | Cleared level chip |
| `color.perfect` | `#EAB308` | `#FACC15` | Perfect (★) chip |
| `color.error` | `#EF4444` | `#F87171` | Wrong feedback |
| `color.text` | `#1F2937` | `#F1F5F9` | Body |
| `color.textMuted` | `#6B7280` | `#94A3B8` | Hints, captions |
| `color.locked` | `#9CA3AF` | `#64748B` | Locked level chip |

## Typography

| Token | Family | Size (draft) | Weight |
|-------|--------|--------------|--------|
| `font.headline` | Space Grotesk | 24–28sp | 600–700 |
| `font.title` | Space Grotesk | 20–22sp | 600 |
| `font.prompt` | Inter | 18sp | 500 |
| `font.body` | Inter | 16sp | 400 |
| `font.caption` | Inter | 13sp | 400 |

## Spacing & radius

| Token | Value |
|-------|-------|
| `space.screen` | 16 |
| `space.stack` | 12 |
| `radius.card` | 16–20 |
| `radius.button` | full (pill) |
| `touch.min` | 44 |

## Visual reference

Screenshots/HTML: [mock-b-stitch/output/screens/](mock-b-stitch/output/screens/)

## Brand

- Display name: **mathPuzzle** (O6 / ADR-0002). Stitch exports may still say Mathemagix — use mathPuzzle in Flutter UI.

## Follow-up

- Optional: `stitch screen edit` to refresh reference PNGs with mathPuzzle branding.
- UI copy remains [ui-states-and-copy.md](ui-states-and-copy.md) (English, PRD).

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
