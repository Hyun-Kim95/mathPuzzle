---
type: doc
project: mathPuzzle
doc_lane: requirements
updated_at: 2026-05-18T00:00:00
tags: [docs, requirements, privacy, gdpr]
---

# Consent & Privacy Flow (v1)

PRD §6, §16 E3-08. [ADR-0005](../decisions/ADR-0005-admob-everyone-coppa.md): AdMob, Everyone, child-directed ads.

## When consent runs

| Trigger | Action |
|---------|--------|
| First tap **Hint** or **Show Answer** (before ad load) | UMP / in-app consent (child-directed profile) |
| Tutorial / guided Level 1 | Ads **disabled** (E3-11) |

## User choices

| Choice | App behavior |
|--------|----------------|
| Accept ads | Load rewarded ads (test or production units) |
| Reject / incomplete | E3-08 — **no unlock** |
| ATT (iOS, later) | Per platform when iOS ships |

## Data collected (v1)

| Data | Purpose | Stored |
|------|---------|--------|
| Local progress & settings | Gameplay | Device only |
| Ad SDK | Rewarded ads | Per Google policy |
| Contact / deviceId | **Not collected** (O3, v1) |

## In-app surfaces

- Settings → Privacy policy / Terms (draft until live URL)
- Reset progress clears local game data only

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
