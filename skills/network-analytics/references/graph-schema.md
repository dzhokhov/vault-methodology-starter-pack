# Graph Schema

> Навигация: [SKILL](../SKILL.md)

## Nodes

```yaml
node_id: "person:ext-001"
node_type: "Person|Organization|Event|Topic"
label: "..."
attributes:
  role: "..."
  company: "..."
  region: "..."
```

## Edges

```yaml
edge_id: "edge-..."
from_node: "person:..."
to_node: "event:..."
edge_type: "co-speaker|co-organizer|mentioned_with|works_at|introduced_by|attended"
weight: 0..1
confidence: 0..1
date: "YYYY-MM-DD"
source_url: "https://..."
```

## Identity Rules

- Канонизируй человека по устойчивому `person_id`.
- Не объединяй профили при ambiguity.
- При сомнении создавай `review_needed` флаг.
