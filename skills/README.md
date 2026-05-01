---
id: skills-index
type: note
status: active
created: 2026-03-20
updated: 2026-05-01
aliases:
  - "Индекс скиллов"
  - "Кастомные скиллы vault"
tags: [skills, index, workflows]
source_path: "skills/README.md"
---

# Skills

## Суть
Индекс кастомных скиллов vault. Используется как точка входа для выбора доменного workflow перед выполнением задачи.

## Детали

### Операционные скиллы
- [vault-onboarding-guide](./vault-onboarding-guide/SKILL.md) — интерактивный проводник по первому запуску хранилища: учебные циклы, практика на файлах, удержание маршрута.
- [skill-creator](./skill-creator/SKILL.md) — создание, доработка, проверка и оптимизация скиллов для агентов.
- [owner-only-dev-orchestrator](./owner-only-dev-orchestrator/SKILL.md) — оркестрация полного цикла разработки в режиме owner-only.
- [test-gates](./test-gates/SKILL.md) — запуск quality gates и итоговый статус `GREEN/YELLOW/RED`.
- [release-rollback](./release-rollback/SKILL.md) — релизная готовность и безопасный rollback.
- [meeting-processing](./meeting-processing/SKILL.md) — обработка встреч, извлечение решений/действий, маршрутизация в контур.
- [research](./research/SKILL.md) — source-first ресёрч с компенсацией искажений и обязательной фиксацией результата.
- [ilyakhov-editor](./ilyakhov-editor/SKILL.md) — редактура в инфостиле.
- [landing-copywriter](./landing-copywriter/SKILL.md) — создание Hero-блоков и первого экрана лендинга.
- [personal-brand-content](./personal-brand-content/SKILL.md) — экспертный контент для личного бренда или авторского канала.
- [slide-copywriter](./slide-copywriter/SKILL.md) — контент для слайдов и презентаций.
- [jtbd-to-interface](./jtbd-to-interface/SKILL.md) — перевод JTBD-материалов в интерфейсные решения.

### Контекст-переключение
- [parking](./parking/SKILL.md) — стоп-кадр и фиксация точки возврата.
- [resume](./resume/SKILL.md) — восстановление припаркованного контекста.
- [new-dialog-handoff](./new-dialog-handoff/SKILL.md) — безопасный переход в свежий чат: reuse `parking`/`resume`, фиксация durable source of truth и короткий restart-packet.

### Контент и аналитика
- [translation-editorial](./translation-editorial/SKILL.md) — перевод технических сигналов в прикладные карточки/блоговые блоки.
- [case-forensics](./case-forensics/SKILL.md) — извлечение воспроизводимых кейсов из тредов и чатов.
- [event-intelligence](./event-intelligence/SKILL.md) — мониторинг и ранжирование AI-мероприятий (`Attend/Speak`).
- [network-analytics](./network-analytics/SKILL.md) — обновление графа связей и приоритизация outreach.

## Следующий шаг
Подключать соответствующие скиллы явно в prompt автоматизаций через формат `[$skill-name](./abs-path-to-SKILL.md)` для детерминированного исполнения pipeline.
