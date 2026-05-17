---
type: doc
project: mathPuzzle
doc_lane: requirements
updated_at: 2026-05-17T12:00:00
tags: [docs, requirements, content]
---

# Content Type Mapping (PRD T1–T5 → JSON)

| PRD ID | Name | JSON `type` | Renderer hint (`assets.layout`) |
|--------|------|-------------|----------------------------------|
| T1 | Number grid | `number_grid` | `grid_3x3`, `grid_4x4` |
| T2 | Shape + number | `shape_number` | `equation_shapes` |
| T3 | Operator pattern | `operator_pattern` | `sequence_horizontal` |
| T4 | Missing term | `missing_term` | `sequence_horizontal` |
| T5 | Visual equation | `visual_equation` | `equation_visual`, `image` if `assets.image` set |

**SSOT for enum:** [level.schema.json](../../content/levels/level.schema.json)

## Authoring notes

- One PRD category may use multiple layouts; set `assets.layout` per level.
- Choice input (`input.mode: "choice"`) allowed for any type.
- [CONTENT_SHEET.md](../../content/levels/CONTENT_SHEET.md) type column must use JSON `type` values above.

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
