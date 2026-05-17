# mathPuzzle — Flutter app

**Stack:** Flutter (ADR-0002)  
**Package:** `com.mathpuzzle.app`  
**Display name:** mathPuzzle

## Run

```powershell
cd app
flutter pub get
flutter run          # device/emulator
flutter test
flutter build apk --debug
```

## Vertical slice (v1)

| Screen | Route |
|--------|-------|
| Splash | `/` |
| Onboarding | `/onboarding` |
| Level map | `/levels` |
| Puzzle | `/play/:id` |
| Complete | `/play/:id/complete` |
| Settings | `/settings` |

Levels **1–5** in `assets/levels/` (synced from `content/levels/`).

## Stubs (Phase 2)

- [AdRewardService](lib/domain/ad_reward_service.dart) — dialog stub
- [PurchaseService](lib/domain/purchase_service.dart) — donate placeholder
- [Phase2Placeholders](lib/domain/monetization/phase2_placeholders.dart) — AdMob test id, IAP SKUs

See [docs/technical/phase2-monetization-checklist.md](../docs/technical/phase2-monetization-checklist.md).

## Specs

- [client-services-contract.md](../docs/technical/client-services-contract.md)
- [data-contracts.md](../docs/technical/data-contracts.md)
- [ui-states-and-copy.md](../docs/design/ui-states-and-copy.md)
