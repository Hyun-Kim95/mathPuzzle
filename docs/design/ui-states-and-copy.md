---
type: doc
project: mathPuzzle
doc_lane: design
updated_at: 2026-05-17T20:00:00
tags: [docs, design, copy, i18n]
---

# UI States & English Copy Catalog (v1)

Implement as `strings.en.json` (or platform equivalent). Keys are suggestions.

## Screen states matrix

| Screen | default | loading | error | empty | success |
|--------|---------|---------|-------|-------|---------|
| S04 Level select | grid | skeleton optional | — | N/A | — |
| S05 Puzzle | input ready | ad loading | load fail E1-09 | — | correct → S06 |
| S05 Hint/Answer | button | ad modal spinner | ad fail E3-01 | — | panel visible |
| S10 Donate | tiers | processing E5-03 | fail E5-02 | IAP unavailable E5-06 | thanks E5-04 |
| S01 Splash | logo | load progress | — | — | route next |
| S02 Onboarding | pages | — | — | — | skip/continue |
| S06 Level complete | summary | — | — | — | next / levels |
| S07 All complete | message | — | — | — | back |

## Copy — gameplay

| key | en |
|-----|-----|
| `submit` | Submit |
| `tryAgain` | Try again |
| `nextLevel` | Next level |
| `backToLevels` | Back to levels |
| `hint` | Hint |
| `showAnswer` | Show answer |
| `levelTitle` | Level {n} |
| `progressSummary` | {cleared} / 100 |
| `allCompleteTitle` | You completed all levels! |
| `invalidInput` | Invalid input. |
| `numberRange` | Enter a number between {min} and {max}. |
| `levelLocked` | Complete the previous level first. |
| `levelNotFound` | Level not found. |
| `puzzleLoadError` | This puzzle couldn't load. |
| `leaveLevelTitle` | Leave this level? |
| `leaveLevelBody` | Your current answer will stay on screen when you return. |
| `leaveLevelConfirm` | Leave |
| `leaveLevelStay` | Stay |
| `onboardingSkip` | Skip |
| `onboardingContinue` | Continue |
| `cancel` | Cancel |

## Copy — ads

| key | en |
|-----|-----|
| `adModalTitle` | Watch a short video |
| `adModalHint` | Unlock hint |
| `adModalAnswer` | Unlock answer |
| `adWatch` | Watch |
| `adCancel` | Cancel |
| `adUnavailable` | Ad isn't available. Check your connection. |
| `adClosedEarly` | Ad closed before finish. |
| `adNoFill` | No ads right now. Try again later. |
| `adConsentBlocked` | Ads are disabled until you update privacy choices. |
| `retry` | Retry |

## Copy — settings & support

| key | en |
|-----|-----|
| `settings` | Settings |
| `appearance` | Appearance |
| `themeSystem` | System |
| `themeLight` | Light |
| `themeDark` | Dark |
| `masterMute` | Mute all |
| `bgm` | Music |
| `sfx` | Sound effects |
| `supportDeveloper` | Support the developer |
| `privacyPolicy` | Privacy policy |
| `termsOfUse` | Terms of use |
| `about` | About |
| `appName` | mathPuzzle |
| `resetProgress` | Reset progress |
| `resetConfirmTitle` | Reset all progress? |
| `resetConfirmBody` | This cannot be undone. |
| `resetConfirm` | Reset |
| `progressReset` | Progress reset. |
| `progressLoadFailed` | Your progress couldn't be loaded. Starting fresh. |
| `progressSaveFailed` | Couldn't save progress. Try again. |
| `offline` | You're offline. Try again when connected. |
| `purchaseCancelled` | Purchase cancelled. |
| `purchaseFailed` | Purchase failed. Try again. |
| `purchaseThanks` | Thanks for your support! |
| `linkUnavailable` | Couldn't open link. |

## Accessibility

| Requirement | PRD |
|-------------|-----|
| Success/error not color-only | §5, E7-07 |
| `accessibilityLabel` on Hint, Submit, level cells | E7-07 |
| Reduce motion: limit shake/celebration | E7-08 |

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
