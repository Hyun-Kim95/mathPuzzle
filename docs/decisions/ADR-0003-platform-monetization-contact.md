---
type: doc
project: mathPuzzle
doc_lane: decisions
updated_at: 2026-05-17T21:00:00
tags: [docs, adr]
---

# ADR-0003: Platform, Donation, Contact (O1–O3)

## Status

Accepted (2026-05-17) — HUMAN

## Decisions

| ID | Decision |
|----|----------|
| **O1** | **Android first** — ship and stabilize on Google Play; iOS follows in a later release |
| **O2** | **IAP only** — consumable tips ($0.99 / $2.99 / $4.99); no external tip links in v1 |
| **O3** | **No in-app contact** — Contact Us / S09 **out of scope for v1**; may revisit in v1.1+ |

## Consequences

- v1 build targets Android; iOS project/config deferred until post-Android validation.
- Settings: Donate (IAP), Legal, About, audio, appearance, reset — **no Contact row**.
- No `ContactService`, mailto, support form, or `contact_log` storage in v1.
- Privacy policy: no contact-form PII collection in v1; ads/IAP SDK disclosures still required.
- PRD §3.4 and §16.4 E4-* marked N/A for v1; edge cases for legal links (E4-09) remain under settings/legal.

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
