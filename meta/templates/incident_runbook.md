---
id: <yyyy-mm-dd>-incident-runbook
type: process
status: active
created: <YYYY-MM-DD>
updated: 2026-03-18
aliases:
  - "Шаблон INCIDENT_RUNBOOK"
tags: [template, incident, rollback, operations]
source_path: "meta/templates/incident_runbook.md"
knowledge_criticality: high
verification_status: unverified
verified_by_me: false
curation_mode: none
---

# INCIDENT_RUNBOOK

Связанный индекс: [Индекс шаблонов](./README.md).

## Trigger
- Какой сигнал/симптом запускает runbook:

## First 10 Minutes
1. Freeze new deploys.
2. Identify last known good tag.
3. Select rollback path.

## Rollback Procedure
- Команда/пайплайн:

## Verification
- Smoke checks:
- Recovery metrics:

## Postmortem Inputs
- Root cause:
- Почему gate пропустил:
- Какой новый тест/гейт добавляем:
