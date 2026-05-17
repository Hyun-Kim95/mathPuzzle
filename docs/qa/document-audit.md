---
type: doc
project: mathPuzzle
doc_lane: qa
updated_at: 2026-05-17T12:00:00
tags: [docs, audit, consistency]
---

# Documentation Cross-Audit (2026-05-17)

PRD v1.2 ↔ 초기 문서 세트 정합 점검. **해소됨** / **보완됨** / **의도적 차이** / **미해결(HUMAN)**.

## 1. 충돌 — 해소

| # | 충돌 | 해소 |
|---|------|------|
| D1 | PRD §3.1.3 필수 필드에 `title`·`type` 없음 vs schema/contract 필수 | PRD §3.1.3 보완; SSOT 우선순위: [data-contracts.md](../technical/data-contracts.md) |
| D2 | Gate 1 “API 계약” vs v1 백엔드 없음 | [client-services-contract.md](../technical/client-services-contract.md) — 서버 N/A, 클라이언트 계약으로 대체 |
| D3 | S01 진입: “S02 or S03” vs 재방문 시 스플래시 | [first-launch-flow.md](../requirements/first-launch-flow.md) — `appMeta` 플래그로 분기 |
| D4 | O9(가이드 Level 1) vs S03 `/tutorial` 별도 화면 | first-launch-flow: **권장** S03 = Level 1 오버레이; O9 확정 전 provisional |
| D5 | `perfect` 저장 시점 모호 | data-contracts에 Submit 시점 계산식 명시 |
| D6 | `levels` 맵 sparse vs `highestUnlocked` | data-contracts: 해금은 `highestUnlocked` SSOT |
| D7 | sample level `max:99` vs PRD 예시 `max:999` | sample은 L1용 좁은 범위; 스키마는 레벨별 허용 |

## 2. 누락 — 보완

| # | 누락 | 산출물 |
|---|------|--------|
| G1 | Gate 1 API 계약 문서 | client-services-contract.md |
| G2 | 첫 실행·온보딩 상태 저장 | data-contracts `appMeta` |
| G3 | S01–S03, S06–S07, S09–S12 화면 스펙 | screen-spec-v1 §보완 |
| G4 | T1–T5 ↔ JSON `type` 매핑 | content-type-mapping.md |
| G5 | CMP/동의 플로우 | consent-and-privacy-flow.md |
| G6 | 스토어·FAQ 초안 | store-listing-outline.md |
| G7 | 디자인 토큰 placeholder (65-gate) | design-tokens-v0.md |
| G8 | 모바일 스택 미결 (PRD §7) | open-decisions O11 |
| G9 | 문서↔PRD 추적표 | 본 파일 + hub 갱신 |
| G10 | Leave level / Cancel / Skip copy | ui-states-and-copy.md |
| G11 | Reset 시 contact rate limit | **N/A v1** (O3 문의 없음) |

## 3. 의도적 차이 (유지)

| 항목 | 설명 |
|------|------|
| PRD §16.8 P0 ⊂ 전체 §16 | P0 체크리스트는 출시 차단만; P1은 release 전 권장 |
| PRD 섹션 번호 12→15→16→13→14 | 번호 역순은 PRD 편집 잔여; 내용 SSOT는 유효 |
| Text screen spec vs visual mock | Gate 1 텍스트 충족; **시각 목업**은 별도 HUMAN 승인 |

## 4. 미해결 (HUMAN)

| ID | 항목 |
|----|------|
| O4, O7, O10 | [open-decisions.md](../decisions/open-decisions.md) |
| ~~O6, O11~~ | **Decided** — mathPuzzle, Flutter — [ADR-0002](../decisions/ADR-0002-brand-stack-theme.md) |
| Visual design | Option B (Stitch); brand **mathPuzzle** in app; reference PNGs may lag |

## 5. 문서 SSOT 우선순위 (충돌 시)

1. [PRD.md](../PRD.md) — 제품·정책  
2. [data-contracts.md](../technical/data-contracts.md) — 스키마·저장  
3. [level.schema.json](../../content/levels/level.schema.json) — JSON 검증  
4. [ui-states-and-copy.md](../design/ui-states-and-copy.md) — UI 문구  
5. [screen-spec-v1.md](../design/screen-spec-v1.md) — 레이아웃(시각 승인 후 확정)

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
