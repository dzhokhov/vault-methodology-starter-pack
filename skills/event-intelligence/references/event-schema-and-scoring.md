# Event Schema and Scoring

> Навигация: [SKILL](../SKILL.md)

## Event Schema

```yaml
event_id: "evt-..."
event_name: "..."
date_start: "YYYY-MM-DD"
date_end: "YYYY-MM-DD"
location: "city|online"
format: "conference|meetup|workshop|webinar"
source_url: "https://..."
cfp_open: true|false
cfp_deadline: "YYYY-MM-DD"
theme_fit: 0..5
network_value: 0..5
cost_efficiency: 0..5
acceptance_probability: 0..5
strategic_value: 0..5
```

## Scoring

- AttendScore = `0.4*theme_fit + 0.4*network_value + 0.2*cost_efficiency`
- SpeakScore  = `0.4*theme_fit + 0.3*acceptance_probability + 0.3*strategic_value`

## Recommended Thresholds

- High priority: `>= 4.0`
- Medium: `3.0 - 3.9`
- Low: `< 3.0`
