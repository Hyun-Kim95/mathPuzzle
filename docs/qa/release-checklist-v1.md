---
type: doc
project: mathPuzzle
doc_lane: qa
updated_at: 2026-05-17T00:00:00
tags: [docs, qa, release]
---

# Release Checklist — v1.0

From [PRD.md](../PRD.md) §9 DoD + store requirements.

## Product

- [ ] 100 levels playable; unlock chain 1→100
- [ ] Local progress survives app restart
- [ ] Hint: one rewarded ad → permanent hint per level
- [ ] Answer: one rewarded ad → answer + explanation per level
- [ ] Submit required to clear; ad-only view does not unlock next level
- [ ] Perfect star only without hint/answer ads
- [ ] Tutorial/onboarding: no rewarded ads on hint/answer
- [ ] Reset progress: full wipe per §3.7; sound settings kept
- [ ] English UI complete ([ui-states-and-copy.md](../design/ui-states-and-copy.md))

## Monetization

- [ ] Rewarded ads on test + production units
- [ ] IAP tips ($0.99 / $2.99 / $4.99) on Android (O2)
- [ ] Donation does not alter gameplay or ads
- [ ] No Contact screen in settings (O3)

## Audio

- [ ] BGM loops on main/play; respects master mute & BGM toggle
- [ ] SFX on tap, correct, wrong; respects master mute & SFX toggle
- [ ] Background pause/resume (E6-03)

## Compliance

- [ ] Privacy policy URL live and linked in app
- [ ] Terms of use URL live
- [ ] GDPR/CMP if shipping EU ([consent-and-privacy-flow.md](../requirements/consent-and-privacy-flow.md))
- [ ] Ad / IAP declarations in store consoles
- [ ] Age rating aligned with ad SDK config (O7, O10)

## QA depth

- [ ] [edge-case-p0-checklist.md](edge-case-p0-checklist.md) — all P0 pass
- [ ] Smoke on min-spec Android device (O1: Android first; iOS later)

## Store assets

- [ ] Screenshots (en)
- [ ] Short description + keywords
- [ ] App icon & feature graphic

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
