# Metrics and Prioritization

> Навигация: [SKILL](../SKILL.md)

## Metric Interpretation

### Degree centrality
Показывает, у кого больше прямых связей.

### Betweenness centrality
Показывает, кто является мостом между кластерами.

### Eigenvector centrality
Показывает влияние через связи с уже влиятельными узлами.

### Communities
Показывают домены/подтусовки, где связи плотнее среднего.

## Outreach Prioritization

Приоритизируй так:
1. Высокий betweenness + релевантный домен
2. Средний betweenness + высокий trust path (есть warm intro)
3. Высокий degree внутри целевого кластера

## Outreach Item Template

```yaml
target_person: "..."
via: "..."
reason: "..."
suggested_message_angle: "..."
expected_outcome: "..."
priority: "high|medium|low"
```
