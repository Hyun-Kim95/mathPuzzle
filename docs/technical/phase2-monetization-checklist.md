---
type: doc
project: mathPuzzle
doc_lane: technical
updated_at: 2026-05-17T23:00:00
tags: [docs, technical, phase2]
---

# Phase 2 — Monetization, Content Scale, Compliance

After **vertical slice** (L1–5, Flutter app in `app/`).

## Prerequisites (HUMAN — store only)

| ID | Action |
|----|--------|
| O4–O10 | **Decided** in code — [ADR-0005](../decisions/ADR-0005-admob-everyone-coppa.md); reconfirm before publish |
| Production ad units & IAP SKUs | Play Console / AdMob consoles |
| Legal URLs live | Host [docs/legal/](../legal/) drafts |

## Implementation checklist

### Ads (O4)

- [x] `google_mobile_ads` in app
- [x] [AdRewardService](../../app/lib/domain/ad_reward_service.dart) rewarded + test unit
- [x] [ConsentService](../../app/lib/domain/consent_service.dart) + UMP hook
- [ ] §16.3 full P0 manual QA on device

### IAP (O2)

- [x] `in_app_purchase` + [DonateScreen](../../app/lib/features/settings/donate_screen.dart)
- [ ] Play Console SKU registration (HUMAN)

### Onboarding (O9)

- [x] Level 1 tutorial overlay; ads disabled during tutorial

### Content

- [x] Levels 1–100 + manifest + CI validate
- [x] `sync-level-assets.ps1`

### Legal & store

- [x] Draft: [privacy-policy-en.md](../legal/privacy-policy-en.md), [terms-of-use-en.md](../legal/terms-of-use-en.md)
- [ ] Public URLs + [release-check](../qa/release-checklist-v1.md) on device

## Code hooks

- [phase2_placeholders.dart](../../app/lib/domain/monetization/phase2_placeholders.dart) — test ad unit + SKU list + legal placeholder

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
