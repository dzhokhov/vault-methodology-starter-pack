---
id: <contour-slug>-delegations-<person-slug>
type: delegations
status: active
created: <YYYY-MM-DD>
updated: <YYYY-MM-DD>
aliases:
  - "Делегирования <Имя Фамилия> (<контур>)"
tags: [delegations, ops, <contour-slug>, person-<person-slug>]
source_path: "01_now/ops/<contour-slug>/delegations/<person-slug>.md"
contour: <contour-slug>
person_slug: <person-slug>
tracker_sot: <external-tracker|none>
knowledge_criticality: medium
verification_status: active
---

# Делегирования: <Имя Фамилия> (<контур>)

## Суть

**Lean index** делегирований одного человека в одном контуре. Одна строка на задачу + ссылка на внешний трекер. Файл — не источник статуса задачи, а навигационный индекс. Текущий статус берётся из трекера (см. [live-first-audit.md](../../../../meta/rules/live-first-audit.md)).

Методология: [task-routing.md §delegations](../../../../meta/rules/task-routing.md). Правило владения: [AGENTS.md Правило 11](../../../../AGENTS.md).

## Правила

- Один файл = одна пара `(контур, делегат)`. Если делегат работает в двух контурах — два файла, потому что SoT-трекер у контура свой.
- Источник правды задачи — всегда во внешнем трекере, указанном в `tracker_sot` в служебной разметке.
- Формат строки:
  ```
  - [ ] 2026-04-12 → суть задачи [TRACKER-123](url) • due: 2026-04-20 • [встреча](rel-link)
  ```
  - Дата постановки — обязательно.
  - Ссылка на трекер — обязательно, это SoT.
  - `due:` — если есть; служит основанием для grep-фильтра (`due:` → поле waiting/overdue).
  - Ссылка на встречу/контекст — опционально, помогает восстановить почему.
- **Секции:** только `Active`, `Done (7d)`, `Archive`. `Waiting` и `Overdue` — через поле `due:` и grep.
- **Passive recall:** при упоминании имени делегата в свежем контексте агент показывает открытые строки из этого файла. Weekly review не выполняется.
- **Cleanup:** строки в `Done (7d)` старше 7 дней — переносить в `Archive`. Раз в месяц — forced rewrite файла.

## Active

- [ ] <YYYY-MM-DD> → <суть задачи> [TRACKER-123](url) • due: <YYYY-MM-DD>
- [ ] <YYYY-MM-DD> → <суть> [TRACKER-124](url)

## Done (7d)

- [x] <YYYY-MM-DD> → <суть> [TRACKER-120](url) ✓ <YYYY-MM-DD>

## Archive

Исторические строки старше 7 дней после закрытия. Форма та же, но без `[ ]`/`[x]` — просто компактная запись.

- <YYYY-MM-DD> → <суть> [TRACKER-100](url) ✓ <YYYY-MM-DD>

## Следующий шаг

Ничего — файл поддерживается ambient-образом. При первой активности по делегату в свежем контексте: заглянуть в `Active` через passive recall.
