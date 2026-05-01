---
name: release-rollback
description: >
  Релизная проверка, выпуск и откат для безопасных изменений в коде/скриптах.
  Используй, когда пользователь просит: «выпусти релиз», «подготовь релиз», «сделай rollback»,
  «что делать при инциденте», «проверь release checklist». Скилл проверяет готовность релиза,
  безопасную точку отката и формирует решение GREEN/YELLOW/RED для владельца.
---

# Release Rollback

## Назначение
Сделай релиз управляемым и обратимым: validate -> release decision -> rollback readiness.

Связанный контекст: [LLM Rules](.../meta/LLM_RULES.md).

## Вход
- `RELEASE_CHECKLIST.md`
- `CHANGELOG.md`
- текущий commit/branch/tag
- результаты `$test-gates`

## Mode A: Release Readiness
1. Проверь `RELEASE_CHECKLIST.md` по пунктам.
2. Убедись, что есть релизная версия (`vMAJOR.MINOR.PATCH`) и запись в `CHANGELOG.md`.
3. Подтверди safe rollback point (последний стабильный tag/commit).
4. Подготовь краткий release decision packet для владельца.

## Mode B: Incident Rollback
1. Freeze новые выкаты.
2. Определи last known good version.
3. Выбери путь отката (по убыванию стоимости):
- feature flag/config toggle off
- `git revert` проблемного изменения
- откат на предыдущий стабильный tag
4. Выполни post-rollback smoke.
5. Зафиксируй, какой новый gate/тест нужен, чтобы не повторилось.

## Жёсткие правила
- Не выпускать high-risk изменение без явного owner-решения.
- Не считать релиз готовым без rollback-пути.
- При конфликте между скоростью и безопасностью выбирай обратимость.

## Выход
- `Release status: GREEN|YELLOW|RED`
- `Rollback readiness: READY|NOT_READY`
- `Owner action:` `Release | Hold | Rollback`
- `Next safest step:` 1 конкретный шаг
