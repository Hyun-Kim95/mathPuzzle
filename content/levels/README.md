# Level content (100 puzzles)

## Files

| File | Purpose |
|------|---------|
| [level.schema.json](level.schema.json) | JSON Schema for CI validation |
| [samples/level-001.sample.json](samples/level-001.sample.json) | Reference level |
| [CONTENT_SHEET.md](CONTENT_SHEET.md) | Authoring tracker for all 100 levels |

## Authoring workflow

1. Draft puzzle in `CONTENT_SHEET.md` (rule, answer, hint, explanation).
2. Peer review difficulty band (PRD §3.1.2).
3. Export to `level-NNN.json` (or append to `levels.json` once tooling exists).
4. Run validator (to be added): schema + answer in range + unique ids.

## Difficulty bands

| Levels | Difficulty |
|--------|------------|
| 1–20 | easy |
| 21–50 | medium |
| 51–80 | hard |
| 81–100 | expert |

## Contract

See [docs/technical/data-contracts.md](../../docs/technical/data-contracts.md).
