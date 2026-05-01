---
id: skill-orchestration-owner-only
type: process
status: active
created: 2026-03-19
updated: 2026-03-19
aliases:
  - "Оркестрация owner-only скиллов"
  - "Протокол запуска owner-only-dev-orchestrator / test-gates / release-rollback"
tags: [process, skills, orchestration, owner-only, development]
source_path: "meta/skill-orchestration-owner-only.md"
---

# Протокол оркестрации owner-only скиллов

## Суть
Единый регламент запуска и связки трёх скиллов для задач разработки с минимальным участием владельца: `owner-only-dev-orchestrator`, `test-gates`, `release-rollback`.

Связанный индекс: [README meta](./README.md).

## Детали

## Какие скиллы и за что отвечают
- `owner-only-dev-orchestrator` — основной оркестратор полного цикла (контракт -> реализация -> self-check -> решение владельца).
- `test-gates` — независимая валидация качества (code/test/smoke gates).
- `release-rollback` — релизная готовность, rollback-ready, действия при инциденте.

## Как запускать
- Явный запуск пользователем (предпочтительно):
  - `$owner-only-dev-orchestrator`
  - `$test-gates`
  - `$release-rollback`
- Авто-запуск по намерению:
  - Запросы «под ключ», «минимум моего участия», «сам проверь и выпусти» -> `owner-only-dev-orchestrator`.
  - Запросы «прогони проверки», «валидация», «smoke» -> `test-gates`.
  - Запросы «релиз», «tag», «rollback», «инцидент» -> `release-rollback`.

## Обязательная последовательность оркестрации
1. Запустить `owner-only-dev-orchestrator`.
2. Оркестратор проверяет наличие process-артефактов в целевом проекте:
- `AGENT_WORKFLOW.md`
- `TEST_PLAN.md`
- `RELEASE_CHECKLIST.md`
- `CHANGELOG.md`
- `INCIDENT_RUNBOOK.md`
3. Если артефактов нет, создать из `meta/templates/`.
4. После реализации обязательно запустить `test-gates`.
5. Если изменение релизное, high-risk или затрагивает откат/инциденты — запустить `release-rollback`.
6. Вернуть владельцу только итоговый decision packet (`GREEN/YELLOW/RED` + 1 действие владельца).

## Правила принятия статуса
- `GREEN`:
  - Все обязательные quality gates `PASS`.
  - Rollback path подтверждён.
  - Нет блокирующих рисков.
- `YELLOW`:
  - Нет `FAIL`, но есть `INCOMPLETE` проверки или управляемый residual risk.
- `RED`:
  - Есть `FAIL` в обязательных gates.
  - Релизный риск неприемлем.
  - Rollback path отсутствует.

## Когда нельзя идти дальше
- `test-gates = RED` -> релиз запрещён, сначала remediation.
- `release-rollback = NOT_READY` -> релиз запрещён до восстановления rollback-ready состояния.

## Обязательные ограничения автономии
- Без явного подтверждения владельца нельзя:
  - destructive/history rewrite действия;
  - менять секреты/доступы/prod-permissions;
  - выпускать high-risk изменения;
  - запускать миграции без проверенного rollback.

## Единый формат ответа владельцу
- `STATUS: GREEN | YELLOW | RED`
- `Что изменилось:`
- `Что проверено:`
- `Нужно от владельца: Release | Hold | Rollback`

## Связанные документы
- [AGENTS.md](../AGENTS.md)
- [Протокол создания и применения скриптов](./script-protocol.md)
- [Owner-only стандарт разработки с LLM-агентом](../03_knowledge/ai/owner-only-agent-dev-standard-2026-03.md)
- [Шпаргалка запуска owner-only скиллов](./owner-only-skills-cheatsheet.md)

## Следующий шаг
Поддерживать этот протокол синхронно со скиллами `skills/owner-only-dev-orchestrator`, `skills/test-gates`, `skills/release-rollback`.
