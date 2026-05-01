---
id: <yyyy-mm-dd>-<project-slug>-tasks
type: project
status: active
created: <YYYY-MM-DD>
updated: 2026-04-15
aliases:
  - "Шаблон задач проекта"
tags: [project, tasks]
source_path: "<path-before-migration-or-current>"
knowledge_criticality: low
verification_status: unverified
verified_by_me: false
curation_mode: none
---

# Tasks

## Суть

**Execution-очередь** проекта. Только шаги, которые агент собирается делать в текущем milestone. `tasks.md` не хранит историю (для этого есть `log.md`), не хранит план (для этого есть `plan.md`), не хранит делегирования (для этого есть `ops/<contour>/delegations/<slug>.md`), не хранит личные обязательства владельца (для этого есть `01_now/personal/tasks.md`).

Полная методология: [task-routing-methodology-2026-04.md](../../03_knowledge/task-routing-methodology-2026-04.md). Правила владения: [AGENTS.md Правила 10–12](../../AGENTS.md).

## Запреты

- **Нельзя:** `Goal`, `Milestones`, `Contingency`, `Appetite` — всё это в `plan.md`.
- **Нельзя:** секция `Blocked` — блокеры живут в `plan.md §Blockers` как first-class сущности с карточками `Bx` (см. §5.4 методологии).
- **Нельзя:** строки вида «понять, что делать с X», «разобраться с Y» — это размышление, его место в `plan.md` под соответствующий milestone как открытый вопрос.
- **Нельзя:** делегирование сотруднику («Дима сделает X») — это в `ops/<contour>/delegations/<person-slug>.md`.
- **Нельзя:** личное обязательство владельца — это в `01_now/personal/tasks.md`.

## Task Mode

Выбери один режим (он повторяет `task_mode` из `plan.md`) и удали второй шаблон ниже:
- `operational` — обычные задачи без изменения исполняемой системы
- `development` — код, скрипты, тесты, schema/data contracts, runtime, CI, build/release

Держи только один `Active` / `Active Step` в каждый момент времени.

---

## Шаблон `operational`

### Active
- [ ] <один текущий шаг>

### Next
- [ ] <2-5 ближайших шагов в рамках текущего milestone из plan.md>

### Waiting
- [ ] <внешние зависимости / ответы>

### Backlog
- [ ] <не сейчас, но не потерять>

### Done
- [x] <последние 3-5 завершённых шагов, не больше — старое уходит в log.md>

---

## Шаблон `development`

### Current Milestone
Ссылка на милстоун из `plan.md`: `M<N> — <название>`. Не дублируй сюда цель и acceptance — они там.

### Active Step
- [ ] <один текущий шаг>

### Зачем
<почему этот шаг сейчас в контексте milestone>

### Exit Criteria
- <наблюдаемое условие завершения 1>
- <наблюдаемое условие завершения 2>

### Drift Guard (short)
- <куда нельзя уходить без перепланирования в этом шаге>

### Next
- [ ] <2-5 следующих шагов>

### Backlog
- [ ] <позже>

### Done
- [x] <последние 3-5 шагов>

## Drift protocol

Если собираешься работать вне `Active`/`Next`, или понимаешь, что текущий milestone больше не ведёт к цели:
1. Сначала правка `plan.md` (milestones, acceptance, drift guard, contingency).
2. Одна строка в `log.md`: «дрейф: было X, стало Y».
3. Только потом обновление `tasks.md` и возобновление работы.

## Следующий шаг
Выбрать `Task Mode`, удалить лишний шаблон и оставить один `Active` шаг.
