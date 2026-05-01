---
name: network-analytics
description: >
  Построение и обновление графа отраслевых связей Person-Org-Event-Topic для навигации
  по AI-тусовке и приоритизации outreach. Используй этот скилл, когда нужно понять,
  кто является мостом между кластерами, какие домены формируются, кто ключевые узлы,
  и к кому идти в первую очередь для доступа к нужным людям.
---

# Network Analytics


> Навигация: [Индекс скиллов](../README.md)
## Overview

Преобразуй хаотичные упоминания и взаимодействия в рабочую карту сети влияния.

Скилл отвечает за фазу `normalize entities -> update graph -> compute metrics -> outreach plan`.

## Workflow

### 1) Normalize Entities

Используй схему из
[graph-schema](./references/graph-schema.md).

Сущности:
- `Person`
- `Organization`
- `Event`
- `Topic`

### 2) Update Edges

Поддерживай типизированные связи:
- `co-speaker`
- `co-organizer`
- `mentioned_with`
- `works_at`
- `introduced_by`
- `attended`

Для каждого ребра фиксируй:
- `source`
- `date`
- `confidence`

### 3) Compute Metrics

Если есть инструменты граф-аналитики, считай:
- `degree centrality`
- `betweenness centrality`
- `eigenvector centrality`
- `communities` (Louvain/эквивалент)

Если инструменты недоступны, используй эвристики и явно помечай
`method=heuristic`.

### 4) Interpret

Используй правила из
[metrics-and-prioritization](./references/metrics-and-prioritization.md):
- мосты между кластерами,
- ядро каждого домена,
- новые растущие кластеры.

### 5) Build Outreach Plan

Выдай:
- 5 ключевых мостов
- 3 кластера/домена
- 10 приоритетных outreach шагов (к кому, через кого, зачем)

## Output

1. Graph update summary
2. Top bridges (betweenness)
3. Community map
4. Outreach backlog (10 items)

Каждый outreach item:
- `target_person`
- `via`
- `reason`
- `suggested_message_angle`
- `expected_outcome`

## Quality Gates

- Нет ребра без источника или даты.
- Нет центральностных выводов без указания метода расчёта.
- Outreach рекомендации привязаны к конкретной цели, а не общему "познакомиться".

## Anti-Patterns

- Не смешивать однофамильцев без подтверждения identity.
- Не путать частые упоминания с реальным влиянием.
- Не делать выводы о кластере на основе 1-2 связей.

## References

- [graph-schema](./references/graph-schema.md)
- [metrics-and-prioritization](./references/metrics-and-prioritization.md)
