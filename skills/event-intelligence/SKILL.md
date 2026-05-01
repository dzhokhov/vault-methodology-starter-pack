---
name: event-intelligence
description: >
  Мониторинг и приоритизация AI-мероприятий и CFP для двух воронок: Attend и Speak.
  Используй этот скилл, когда нужно отобрать события по ценности, посчитать скоринг,
  отслеживать дедлайны заявок для спикеров, и сформировать практический календарь
  действий на 30/60/90 дней.
---

# Event Intelligence


> Навигация: [Индекс скиллов](../README.md)
## Overview

Преобразуй список событий в управляемую воронку участия и выступлений.

Скилл отвечает за фазу `collect events -> normalize -> score -> rank -> calendar actions`.

## Workflow

### 1) Normalize Events

Приведи все события к схеме из
[event-schema-and-scoring](./references/event-schema-and-scoring.md).

Обязательные поля:
- `event_name`
- `date_start`
- `location`
- `format`
- `cfp_deadline` (если есть)

### 2) Dedupe and Validate Dates

- Склей дубликаты одной конференции из разных источников.
- Проверь абсолютные даты (`YYYY-MM-DD`).
- Укажи timezone, если данные с временем.

### 3) Score Attend / Speak

Посчитай:
- `AttendScore = 0.4*theme_fit + 0.4*network_value + 0.2*cost_efficiency`
- `SpeakScore = 0.4*theme_fit + 0.3*acceptance_probability + 0.3*strategic_value`

### 4) Rank

Верни:
- `Top-5 Attend`
- `Top-5 Speak`
- `Watchlist`

### 5) Build Calendar

Собери дедлайны в горизонтах:
- 30 дней
- 60 дней
- 90 дней

Для `Speak` приложи черновик питча по шаблону из
[cfp-pack-template](./references/cfp-pack-template.md).

## Output

Минимальный выход:
1. Таблица Attend (score + why)
2. Таблица Speak (score + deadline + pitch angle)
3. Календарь CFP 30/60/90
4. 3-5 next actions

## Quality Gates

- Нет событий без абсолютной даты.
- Нет ранжирования без score breakdown.
- Для каждого top-события есть обоснование в 1-2 предложениях.
- Для Speak указана реалистичная тема выступления.

## Anti-Patterns

- Не выбирать события только по бренду организатора.
- Не игнорировать стоимость времени (деньги + дорога + подготовка).
- Не подавать в CFP без соответствия теме и формату конференции.

## References

- [event-schema-and-scoring](./references/event-schema-and-scoring.md)
- [cfp-pack-template](./references/cfp-pack-template.md)
