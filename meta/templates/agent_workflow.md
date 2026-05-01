---
id: <yyyy-mm-dd>-agent-workflow
type: process
status: active
created: <YYYY-MM-DD>
updated: 2026-03-22
aliases:
  - "Шаблон AGENT_WORKFLOW"
tags: [template, process, agent, development]
source_path: "meta/templates/agent_workflow.md"
knowledge_criticality: high
verification_status: unverified
verified_by_me: false
curation_mode: none
---

# AGENT_WORKFLOW

Связанный индекс: [Индекс шаблонов](./README.md).

## 1. Task Contract
- Goal:
- Scope:
- Out of scope:
- Risk class: `low` | `medium` | `high`
- Required validations:

## 2. Autonomy Rules
- Agent MAY:
- Agent MUST ASK:
- Agent MUST NOT:

## 3. Execution Loop
1. Plan (<=7 шагов).
2. Implement (малые логические изменения).
3. Validate (lint/type/tests/smoke).
4. Adversarial self-check (что могло сломаться).
5. Prepare release packet.

## 3.1 Observability Contract
- Runtime logs required: `yes` | `no`
- If `yes`, log schema / format:
- `run_id`:
- `step_id`:
- `file_or_module`:
- `function_id` / `block_id`:
- `belief_state`:
- `observed_result`:
- `next_action`:
- Retry / anti-loop policy:
- Forced-context policy on repeated failure:

## 4. Mandatory Gates
- [ ] Code gate green
- [ ] Test gate green
- [ ] Release gate green
- [ ] Rollback gate ready
- [ ] Observability gate green (if task is agentic / autonomous)

## 5. Owner Output Format
- Status: `GREEN` | `YELLOW` | `RED`
- Что изменилось:
- Что проверено:
- Действие владельца: `Release` | `Hold` | `Rollback`
