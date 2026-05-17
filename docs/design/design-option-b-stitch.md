---
type: doc
project: mathPuzzle
doc_lane: design
updated_at: 2026-05-17T18:00:00
tags: [docs, design, option-b, stitch]
status: selected-for-implementation
---

# Design Option B — Stitch안

**Implementation visual SSOT** (HUMAN selected 2026-05-17). Option A: reference only.

## Status

| Item | State |
|------|--------|
| HUMAN selection | **Selected** — [design-ab-comparison.md](design-ab-comparison.md) |
| Stitch MCP | **사용 안 함** (오류) → **CLI** (`~/.cursor/mcp.json` 키) |
| CLI SOP | [stitch-cli-sop.md](stitch-cli-sop.md) |
| projectId | `4485680357817047125` — [project.json](mock-b-stitch/project.json) |
| Screenshots | [mock-b-stitch/output/screens/](mock-b-stitch/output/screens/) |
| Local preview (참고) | [mock-b/index.html](mock-b/index.html) |

**2026-05-17:** CLI로 6화면 생성 완료. Stitch가 **Mathemagix** 등 자동 네이밍 — 구현·재생성 시 **mathPuzzle** 사용 ([ADR-0002](../decisions/ADR-0002-brand-stack-theme.md)).

## Concept

- **Tone:** Playful, game-like — gradient hero, rounded chips, chapter sections (aligns O5 recommendation).
- **Color:** Violet + cyan gradient; soft shadows.
- **Naming:** **mathPuzzle** (display name, ADR-0002).

## Deliverables

| Asset | Path |
|-------|------|
| CLI runbook | [stitch-cli-sop.md](stitch-cli-sop.md) · [mock-b-stitch/stitch-package.md](mock-b-stitch/stitch-package.md) |
| Prompts | [mock-b-stitch/prompts/](mock-b-stitch/prompts/) |
| Design system (in prompts) | [mock-b-stitch/stitch-design-system.json](mock-b-stitch/stitch-design-system.json) |
| Local preview | [mock-b/](mock-b/) |

## Stitch execution checklist (CLI)

1. `npm install -g stitch-design-cli` + `stitch auth set` / `STITCH_API_KEY`
2. `stitch project create --title "Math Pattern Puzzle" --json`
3. Save `projectId` → `mock-b-stitch/project.json` (from `project.json.example`)
4. `.\scripts\stitch\Invoke-StitchBScreens.ps1`
5. `stitch screen get ... --include-image --include-html` → save under `output/screens/`
6. Record IDs below

### Record (CLI 2026-05-17)

| Field | Value |
|-------|-------|
| projectId | `4485680357817047125` |
| designSystem | Auto (Mathemagix / Kinetic Precision — see generate JSON) |
| Screen: Level select | `41accf566b1f4ebf9558dddb5c57d321` |
| Screen: Puzzle play | `6ce2c89622e3477da7c26aff6d07c4b2` |
| Screen: Level complete | `440b6f5c6c2a4fb1bfbfc6ef42d87471` |
| Screen: Settings | `b35c39bc6fa54ddf971baf74c742d5b0` |
| Screen: Ad modal | `8b0a13fdbd9c4845953c34633e29afe8` |
| Screen: Splash | `27e45043fed9474d8013510c6a73c689` |

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
