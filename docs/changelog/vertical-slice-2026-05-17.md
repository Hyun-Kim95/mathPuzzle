---
type: doc
project: mathPuzzle
doc_lane: changelog
updated_at: 2026-05-17T23:00:00
tags: [docs, changelog, slice]
---

# Vertical Slice — 2026-05-17

## Delivered

- **ADR-0004:** O5 chapters 5×20, O8 skippable onboarding, O9 guided L1 (tutorial deferred)
- **Flutter app** in `app/` — mathPuzzle, `com.mathpuzzle.app`
- **Screens:** S01 splash, S02 onboarding (skip/continue), S04 level map (ch1 L1–5), S05 play, S06 complete, S08 settings (theme, audio, reset)
- **Policies:** sequential unlock, submit to clear, perfect without ad unlocks, reset keeps settings
- **Content:** `content/levels/level-001.json` … `level-005.json` + `scripts/validate-levels.ps1`
- **Tests:** `flutter test` (progress + validation)

## Not in slice (Phase 2)

- Real AdMob / IAP (stubs + dialog)
- S03 tutorial overlay
- Contact (O3 — none)
- Levels 6–100
- Privacy/Terms live URLs
- iOS build

## Run locally

```powershell
cd app
flutter pub get
flutter run
```

## Next

[phase2-monetization-checklist.md](../technical/phase2-monetization-checklist.md)
