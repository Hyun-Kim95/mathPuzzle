---
type: doc
project: mathPuzzle
doc_lane: design
updated_at: 2026-05-17T18:00:00
tags: [docs, design, comparison]
status: approved-option-b
---

# Design A/B Comparison

**Requirement:** `65-design-gate` — both options presented; HUMAN selects before implementation.

**Decision (2026-05-17):** **Option B — Stitch안** selected for implementation. Visual SSOT: [mock-b-stitch/output/screens/](mock-b-stitch/output/screens/) + [design-option-b-stitch.md](design-option-b-stitch.md).

| | **Option A — 자체안** | **Option B — Stitch안** |
|---|----------------------|-------------------------|
| **Doc** | [design-option-a.md](design-option-a.md) | [design-option-b-stitch.md](design-option-b-stitch.md) |
| **Preview** | [mock-a/index.html](mock-a/index.html) | [output/screens/](mock-b-stitch/output/screens/) + [project.json](mock-b-stitch/project.json) |
| **Visual** | Minimal, flat, indigo | Gradient, playful, violet/cyan |
| **Level map** | 5×4 grid (sample 20) | Chapter sections + chips (O5-B) |
| **Brand** | (archive) | **mathPuzzle** (selected) |

## Comparison matrix

| Criterion | A — Minimal Logic | B — Playful Gradient |
|-----------|-------------------|----------------------|
| **Clarity / readability** | Strong — low visual noise | Good — hero uses space |
| **100-level scalability** | Grid can feel dense at 10×10 | Chapters reduce scroll fatigue |
| **Implementation effort** | Lower — simple components | Medium — gradients, chips |
| **Dark mode** | Token swap | Needs second Stitch pass |
| **State UI (load/error)** | Text spec + mock partial | Prompts include; verify in Stitch |
| **Ad modal clarity** | Standard dialog | Friendlier copy + icon |
| **Accessibility** | High contrast option | Verify gradient text contrast |
| **Brand / store appeal** | Serious, educational | More “game”, broader appeal |
| **Risk** | May feel plain vs competitors | Gradient fatigue; rename if O6 differs |

## Recommendation (for discussion)

**Lean B for consumer mobile** if brand targets casual game feel and O5 = chapters.  
**Lean A** if priority is fastest MVP and clearest level grid.

## Selection (recorded)

| Field | Value |
|-------|-------|
| Selected option | **B — Stitch안** |
| Date | 2026-05-17 |
| Approver | HUMAN |
| Hybrid notes | — (none) |
| Excluded | A — retained as reference only ([mock-a/](mock-a/)) |

## Stitch delivery note

**CLI 완료 (2026-05-17)** — projectId `4485680357817047125`, 스크린샷 `mock-b-stitch/output/screens/`.  
Stitch PNG에 **Mathemagix** 잔존 가능 → Flutter UI는 **mathPuzzle**; 필요 시 `stitch screen edit`.

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
