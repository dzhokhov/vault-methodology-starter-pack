---
name: test-gates
description: >
  Прогон и верификация quality gates для задач разработки (скрипты/программы).
  Используй, когда нужно проверить изменение перед статусом «готово» или релизом:
  lint/type/static checks, unit/integration, smoke, flaky-policy и итоговый статус GREEN/YELLOW/RED.
  Триггеры: «прогони проверки», «проверь качество», «валидация», «smoke», «quality gates».
---

# Test Gates

## Назначение
Проверяй изменение машинно-верифицируемыми проверками. Не доверяй текстовому объяснению без выполненных команд.

Связанный контекст: [LLM Rules](.../meta/LLM_RULES.md).

## Вход
- Целевой репозиторий/папка.
- Список изменённых файлов.
- Риск-класс изменения.
- Локальные команды из `TEST_PLAN.md` и `README.md`.

## Workflow
1. Собери команды проверок из:
- `TEST_PLAN.md`
- `AGENT_WORKFLOW.md`
- `README.md`
2. Сначала выполни code gate:
- lint
- type/static/security checks (если настроены)
3. Выполни test gate:
- unit tests
- integration tests
4. Выполни release/smoke gate:
- smoke-команды из проекта
5. Обработай flaky:
- пометь нестабильные проверки
- не засчитывай flaky-pass как полноценный green без политики проекта
6. Сформируй единый gate report.

## Жёсткие правила
- Не объявляй `GREEN`, если обязательная команда не запускалась.
- Если команда недоступна в среде, отмечай как `INCOMPLETE`, а не `PASS`.
- Если проверка падает, добавляй краткий корень проблемы и ближайший корректирующий шаг.

## Выход (gate report)
- `Code gate: PASS|FAIL|INCOMPLETE`
- `Test gate: PASS|FAIL|INCOMPLETE`
- `Smoke gate: PASS|FAIL|INCOMPLETE`
- `Flaky notes:` если есть
- `Overall status: GREEN|YELLOW|RED`

## Критерии статуса
- `GREEN`: все обязательные gates = PASS.
- `YELLOW`: нет FAIL, но есть INCOMPLETE/остаточный риск.
- `RED`: есть FAIL в обязательных gates.
