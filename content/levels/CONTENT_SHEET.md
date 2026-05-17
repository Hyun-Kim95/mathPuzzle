# Content sheet — 100 levels

**Status:** 100 / 100 JSON generated (`scripts/generate-levels.py`) · **Reviewer:** HUMAN spot-check recommended (levels 1, 20, 50, 80, 100)

| Band | Levels | Difficulty |
|------|--------|------------|
| 1 | 1–20 | easy |
| 2 | 21–50 | medium |
| 3 | 51–80 | hard |
| 4 | 81–100 | expert |

## Files

- `level-001.json` … `level-100.json`
- [levels.manifest.json](levels.manifest.json) — app SSOT index
- [level.schema.json](level.schema.json)

## Regenerate

```bash
python scripts/generate-levels.py
powershell scripts/validate-levels.ps1
powershell scripts/sync-level-assets.ps1
```

Full per-level spreadsheet rows omitted (see JSON). Type rotates: number_grid, operator_pattern, missing_term, shape_number, visual_equation.
