---
type: doc
project: mathPuzzle
doc_lane: hub
updated_at: 2026-05-17T18:00:00
tags: [docs, hub, mathPuzzle]
---

# mathPuzzle — Documentation Hub

## SSOT

| Topic | Document |
|-------|----------|
| Product requirements | [PRD.md](PRD.md) (v1.2) |
| Agent orchestration | [../AGENTS.md](../AGENTS.md) |
| Delivery gates | [../.cursor/rules/60-delivery-gates.mdc](../.cursor/rules/60-delivery-gates.mdc) |

## Requirements

| Doc | Purpose |
|-----|---------|
| [requirements/screen-inventory.md](requirements/screen-inventory.md) | Screens, routes, entry points |
| [requirements/policy-matrix.md](requirements/policy-matrix.md) | Policy quick reference → PRD sections |
| [requirements/first-launch-flow.md](requirements/first-launch-flow.md) | Splash / onboarding / tutorial routing |
| [requirements/content-type-mapping.md](requirements/content-type-mapping.md) | T1–T5 → JSON `type` |
| [requirements/consent-and-privacy-flow.md](requirements/consent-and-privacy-flow.md) | CMP, ATT, privacy surfaces |
| [requirements/store-listing-outline.md](requirements/store-listing-outline.md) | Store copy draft (en) |

## Design (Option B — Stitch, selected)

| Doc | Purpose |
|-----|---------|
| [design/design-option-b-stitch.md](design/design-option-b-stitch.md) | **Visual SSOT** — Stitch project & screen IDs |
| [design/mock-b-stitch/output/screens/](design/mock-b-stitch/output/screens/) | PNG/HTML reference screens |
| [design/design-ab-comparison.md](design/design-ab-comparison.md) | A/B comparison + selection record |
| [design/design-option-a.md](design/design-option-a.md) | Option A — archive reference |
| [design/mock-a/index.html](design/mock-a/index.html) | Interactive mock A |
| [design/mock-b/index.html](design/mock-b/index.html) | Stitch-direction preview B |
| [design/stitch-cli-sop.md](design/stitch-cli-sop.md) | **Stitch CLI** runbook (MCP 대체) |
| [design/mock-b-stitch/stitch-package.md](design/mock-b-stitch/stitch-package.md) | B 패키지·프롬프트·output |
| [scripts/stitch/README.md](../scripts/stitch/README.md) | 일괄 생성 스크립트 |
| [design/screen-spec-v1.md](design/screen-spec-v1.md) | Layout, components, flows |
| [design/ui-states-and-copy.md](design/ui-states-and-copy.md) | States + English UI strings |
| [design/design-tokens-v0.md](design/design-tokens-v0.md) | Tokens (from Option B design system) |

## Technical

| Doc | Purpose |
|-----|---------|
| [technical/client-services-contract.md](technical/client-services-contract.md) | Gate 1: no REST v1; in-app services |
| [technical/data-contracts.md](technical/data-contracts.md) | Level JSON, progress blob, settings |
| [technical/integrations.md](technical/integrations.md) | Ads, IAP, contact, analytics, legal URLs |
| [technical/implementation-tracks.md](technical/implementation-tracks.md) | Parallel workstreams & file ownership |

## Content

| Path | Purpose |
|------|---------|
| [../content/levels/README.md](../content/levels/README.md) | 100-level authoring guide |
| [../content/levels/level.schema.json](../content/levels/level.schema.json) | JSON Schema |
| [../content/levels/CONTENT_SHEET.md](../content/levels/CONTENT_SHEET.md) | Spreadsheet-style tracker |

## QA

| Doc | Purpose |
|-----|---------|
| [qa/release-checklist-v1.md](qa/release-checklist-v1.md) | v1.0 DoD / release |
| [qa/edge-case-p0-checklist.md](qa/edge-case-p0-checklist.md) | PRD §16.8 P0 tests |
| [qa/document-audit.md](qa/document-audit.md) | Cross-doc consistency audit |

## Decisions & changelog

| Doc | Purpose |
|-----|---------|
| [decisions/open-decisions.md](decisions/open-decisions.md) | O1–O11 tracker |
| [decisions/ADR-0002-brand-stack-theme.md](decisions/ADR-0002-brand-stack-theme.md) | Brand, Flutter, theme |
| [decisions/ADR-0003-platform-monetization-contact.md](decisions/ADR-0003-platform-monetization-contact.md) | O1–O3 platform, IAP, no contact |
| [decisions/ADR-0004-ux-layout-onboarding.md](decisions/ADR-0004-ux-layout-onboarding.md) | O5, O8, O9 |
| [technical/phase2-monetization-checklist.md](technical/phase2-monetization-checklist.md) | Post–slice: ads, IAP, L6–100 |
| [decisions/ADR-0001-product-scope.md](decisions/ADR-0001-product-scope.md) | v1 scope lock |
| [changelog/2026-05.md](changelog/2026-05.md) | May 2026 log |

## Gate checklist (current)

- [x] PRD + policies + edge cases
- [x] Screen inventory & screen spec (text)
- [x] Data contracts & integration outline
- [x] Client services contract (Gate 1 API 대체)
- [x] Doc cross-audit ([document-audit.md](qa/document-audit.md))
- [x] **HUMAN**: O6 **mathPuzzle**, O11 **Flutter**, dark mode — [ADR-0002](decisions/ADR-0002-brand-stack-theme.md)
- [x] **HUMAN**: O1 Android first, O2 IAP only, O3 no contact — [ADR-0003](decisions/ADR-0003-platform-monetization-contact.md)
- [ ] **HUMAN**: O10 (and O4, O7 before store)
- [x] Design mock A/B prepared ([design-ab-comparison.md](design/design-ab-comparison.md))
- [x] Stitch CLI screens generated (project `4485680357817047125`)
- [x] **HUMAN**: Design **Option B (Stitch)** — [design-ab-comparison.md](design/design-ab-comparison.md)
- [ ] Stitch/UI: replace Mathemagix placeholders with **mathPuzzle** (optional `stitch screen edit`)
- [x] Vertical slice — [vertical-slice-2026-05-17.md](changelog/vertical-slice-2026-05-17.md)
- [x] Phase 2 — 100 levels, AdMob/IAP/tutorial — [phase2-2026-05-18.md](changelog/phase2-2026-05-18.md)
- [ ] Device QA §16 P0 + Play Store upload (HUMAN)
