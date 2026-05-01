---
id: <yyyy-mm-dd>-test-plan
type: process
status: active
created: <YYYY-MM-DD>
updated: 2026-03-22
aliases:
  - "Шаблон TEST_PLAN"
tags: [template, testing, quality, release]
source_path: "meta/templates/test_plan.md"
knowledge_criticality: high
verification_status: unverified
verified_by_me: false
curation_mode: none
---

# TEST_PLAN

Связанный индекс: [Индекс шаблонов](./README.md).

## 1. Critical User Flows
1.
2.
3.

## 2. Automated Tests
- Unit:
- Integration:
- E2E-lite:
- Observability checks (if agentic task):
  - log contains `belief_state`
  - log and code share stable identifiers (`function_id` / `block_id`)
  - repeated failures trigger anti-loop behavior
  - repeated failures inject or load forced context

## 3. Release Smoke Suite
- Команда(ы):
- Expected result:
- Rollback trigger:

## 4. Non-functional Checks
- Permission handling:
- Performance budget:
- Crash-free start:
- Log readability for agent:
- Retry / anti-loop behavior:

## 5. Flaky Policy
- Threshold:
- Owner:
- Fix deadline:
