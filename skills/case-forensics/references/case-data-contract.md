# Case Data Contract

> Навигация: [SKILL](../SKILL.md)

## Required Fields

- `case_id`
- `title`
- `objective`
- `context`
- `constraints`
- `steps[]`
- `artifacts[]`
- `metrics_before_after[]`
- `failures[]`
- `replication_120m`
- `transfer_limits`
- `gaps[]`

## Reproducibility Score (0-5)

### input_completeness
- 0: вход не описан
- 3: ключевые входные условия описаны
- 5: входы и ограничения полностью воспроизводимы

### method_specificity
- 0: общие слова
- 3: есть шаги, но без параметров
- 5: шаги с параметрами и проверками

### artifact_availability
- 0: артефакты отсутствуют
- 3: есть частично
- 5: полный набор ссылок/файлов

### metric_verifiability
- 0: метрики отсутствуют
- 3: метрики есть, но непроверяемы
- 5: метрики с источником и методом расчёта
