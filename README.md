# mathPuzzle

100-level logic math puzzle app (Math Riddles–style). Guest-only play, rewarded ads for hints/answers, contact & tips, BGM/SFX. Default UI language: **English**. **Light + dark** theme supported.

## Status

| Area | Document | Gate |
|------|----------|------|
| Requirements (SSOT) | [docs/PRD.md](docs/PRD.md) v1.2 | Gate 1 — PRD ✅ |
| Screens & policies | [docs/requirements/](docs/requirements/) | Gate 1 — screen spec draft ✅ |
| Design | [docs/design/design-option-b-stitch.md](docs/design/design-option-b-stitch.md) | **Option B (Stitch)** ✅ |
| Stack | [docs/decisions/ADR-0002-brand-stack-theme.md](docs/decisions/ADR-0002-brand-stack-theme.md) | **Flutter** ✅ |
| Data & integrations | [docs/technical/](docs/technical/) | Contract draft ✅ |
| Flutter app (slice L1–5) | [app/](app/) | Vertical slice done |
| Content (100 levels) | [content/levels/](content/levels/) | L1–5 done; L6–100 pending |
| QA | [docs/qa/](docs/qa/) | Pre-implementation checklist ready |

## Documentation hub

Full index: **[docs/mathPuzzle-docs-hub.md](docs/mathPuzzle-docs-hub.md)**

## Open decisions (blockers for implementation)

See [docs/decisions/open-decisions.md](docs/decisions/open-decisions.md) — **O1–O3, O6, O11** decided; **O4, O7, O10** before store.

Doc consistency: [docs/qa/document-audit.md](docs/qa/document-audit.md)

## Repo layout

```
content/levels/     # Puzzle JSON + schema
docs/               # PRD, specs, QA, decisions
app/                # Flutter app (see app/README.md)
```

## Agent / delivery

- Orchestration: [AGENTS.md](AGENTS.md)
- Gates: `.cursor/rules/60-delivery-gates.mdc`
