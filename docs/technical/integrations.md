---
type: doc
project: mathPuzzle
doc_lane: technical
updated_at: 2026-05-17T00:00:00
tags: [docs, technical, integrations]
---

# Integrations Outline (v1)

O2: IAP only. O3: no contact v1. O6: mathPuzzle.

## Rewarded ads (hint / answer)

| Item | Spec |
|------|------|
| SDK (planned) | Google AdMob Rewarded — O4 |
| Unit IDs | `.env` / build flavors — **never commit production IDs to public repo** |
| Reward | `onUserEarnedReward` → set hint or answer unlock, persist, then show panel |
| Timeout | 10s load — E3-01 |
| Consent | UMP/CMP before first request — E3-08 |
| COPPA | Child-directed treatment if Everyone — O10 |
| iOS ATT | If required; non-personalized fallback — PRD §6 |

## In-app purchases (tips)

| SKU (planned) | Type | Price |
|---------------|------|-------|
| `tip_small` | Consumable | $0.99 |
| `tip_medium` | Consumable | $2.99 |
| `tip_large` | Consumable | $4.99 |

No entitlement flags in progress blob. Thank-you toast only.

## Contact

**v1:** None (O3 / ADR-0003). No mailto, form, or support screen.

## Analytics (optional v1)

| Event | Params |
|-------|--------|
| `level_complete` | `level_id`, `perfect` |
| `ad_reward_hint` | `level_id` |
| `ad_reward_answer` | `level_id` |
| `donate_click` | `sku` or `external` |

Disable until privacy consent if required in EU.

## Legal URLs (required for store)

| URL | Status |
|-----|--------|
| Privacy policy | **TBD** — must cover ads, optional analytics, contact PII |
| Terms of use | **TBD** |

## Platform (O1)

v1 release target: **Android** (Google Play). iOS build after Android stabilization.

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
