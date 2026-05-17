---
type: doc
project: mathPuzzle
doc_lane: technical
updated_at: 2026-05-17T12:00:00
tags: [docs, technical, api, gate1]
---

# Client Services Contract (Gate 1)

**Gate 1 API 계약 대체 문서.** v1에는 **자체 백엔드 REST API 없음** (O3: 문의 기능 없음).

## 1. Server API

| Scope | v1 |
|-------|-----|
| Auth | None |
| Game progress API | None — local only |
| Puzzle content API | None — app bundle |
| Contact API | **None v1** (O3) |

## 2. In-app service interfaces (implementation contract)

| Service | Responsibility | Errors |
|---------|----------------|--------|
| `LevelRepository` | Load levels 1–100 from bundle; validate schema | `LEVEL_LOAD_ERROR` → E1-09 |
| `ProgressStore` | Read/write progress + appMeta; migrate | `PROGRESS_CORRUPT` → E2-02 |
| `SettingsStore` | Audio toggles | fallback defaults |
| `AdRewardService` | Load/show rewarded; emit reward once | `AD_UNAVAILABLE`, `AD_CLOSED` — §16.3 |
| `PurchaseService` | IAP tips (O2) | `PURCHASE_CANCELLED`, `PURCHASE_FAILED` |
| `ConsentService` | UMP/CMP before ads/analytics | `CONSENT_REQUIRED` → E3-08 |
| `AudioService` | BGM/SFX; respect master mute | fail silent E6-01 |

## 3. Domain events (analytics / internal)

| Event | When | Payload |
|-------|------|---------|
| `level_submit` | Submit tapped | `levelId`, `correct: boolean` |
| `level_complete` | Correct + saved | `levelId`, `perfect: boolean` |
| `hint_unlocked` | Ad reward hint | `levelId` |
| `answer_unlocked` | Ad reward answer | `levelId` |
| `progress_reset` | Reset confirmed | — |

## 4. Auth & permissions

None. No tokens. `deviceRef` = one-way hash of local UUID for support only.

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
