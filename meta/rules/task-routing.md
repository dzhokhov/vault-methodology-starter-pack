---
id: task-routing
type: rule
status: active
created: 2026-04-15
updated: 2026-04-15
aliases:
  - "Task Routing — тактический чеклист"
  - "Куда положить задачу"
tags: [rules, tasks, routing, delegations, personal]
source_path: "meta/rules/task-routing.md"
knowledge_criticality: high
verification_status: active
---

# Task Routing — тактический чеклист

## Суть

Перед тем как записать любую task-level строку, агент отвечает на **один вопрос**: «переживёт ли эта строка текущий проект?» и проходит decision tree. Полное обоснование — в [task-routing-methodology-2026-04.md](../../03_knowledge/task-routing-methodology-2026-04.md). Здесь — рабочий чеклист.

## Decision tree (обязательно перед каждой строкой)

```
Переживёт ли строка этот проект?
├── НЕТ
│   ├── Шаг агента в текущем milestone? → <project>/tasks.md, Next
│   └── Эпизодический факт со встречи? → <meeting>.md, ## Упомянуто вскользь, #canonical-tag
└── ДА
    ├── Исполнитель — владелец vault?
    │   ├── Часть цели проекта? → <project>/plan.md, Milestones
    │   └── Внешнее обязательство, не по проекту? → 01_now/personal/tasks.md, Hard
    ├── Исполнитель — сотрудник контура? → 01_now/ops/<contour>/delegations/<person-slug>.md, Active
    └── Устойчивый инвариант (термин, метрика, SoT)? → <project>/context.md
```

Если ответ неоднозначен — остановиться и спросить владельца (Правило 6).

## Таблица маршрутизации

| Слой из контекста | Куда идёт | Правило-хранитель |
|---|---|---|
| Execution step агента | `<project>/tasks.md`, Active/Next | Правило 10 |
| Milestone, Goal, Non-goal, Acceptance, Drift, Contingency | `<project>/plan.md` | Правило 12 |
| **Блокер milestone'а (first-class)** | **`<project>/plan.md §Blockers`, карточка Bx** | **Правило 12 blocker protocol** |
| Устойчивый инвариант | `<project>/context.md` | Правило 14 |
| Решение, изменение состояния, открытие/закрытие блокера | `<project>/log.md`, 1 строка | Правило 5 + Правило 8 |
| Делегирование сотруднику контура | `01_now/ops/<contour>/delegations/<person-slug>.md`, Active | Правило 11 |
| Личное внешнее обязательство владельца | `01_now/personal/tasks.md`, Hard | Правило 13 |
| Эпизодический факт со встречи | `<meeting>.md`, ## Упомянуто вскользь, #tag | Правило 14 |
| Факт о людях, участии | `03_knowledge/contacts-network/interactions.csv` | Правило people-linking |

## Правила для каждого места назначения

### `<project>/plan.md`
- Обязателен для каждого активного проекта.
- Содержит: `Goal`, `Non-goals`, `Appetite`, `Source of truth`, `Milestones` (каждый с `Acceptance` и статусом `not-started | in-progress | done | blocked on Bx`), **`Blockers`**, **`Blockers — Resolved`**, `Drift Guard`, `Contingency`.
- Медленный файл. Меняется, когда меняется цель, appetite, порядок milestones или состояние блокеров.
- Drift protocol: сначала правка `plan.md`, затем одна строка в `log.md`, только потом действовать.
- Blocker protocol: новый блокер → карточка `Bx` в `§Blockers` + статус milestone `blocked on Bx` + строка `⏸️ NEW BLOCKER Bx` в log.md. Разрешение → обратный порядок, ritual §5.4.2 методологии. `tasks.md` при открытии/закрытии блокера не трогается.

### `<project>/plan.md §Blockers`
- First-class сущности плана. Каждая карточка — отдельная запись `Bx` с полями: Открыт, Тип, Ждём, Блокирует (список milestone'ов), Моё действие, Условие возврата, Fallback, Stale check.
- Типы: `cross-project dependency | delegated-work | external-event | need-info`.
- Двусторонние ссылки: milestone знает, что он `blocked on Bx`; блокер знает, что он `Блокирует: M2, M3`.
- Для `delegated-work` — parallel-строка в `delegations/<slug>.md` с обратной ссылкой `[plan](...#bx)`.
- Cross-project dependency — одностороннее: waiter пишет блокер у себя, parent ничего не знает. Каскады обнаруживаются через grep по `cross-project` во всех `plan.md`.
- Stale check при bootstrap-scan: >30d warn, >60d stale, >90d requires decision (снять через fallback, перевести в Contingency или закрыть milestone). Индивидуальный порог — поле `Stale check` карточки.

### `<project>/tasks.md`
- Содержимое: только **исполнение**, не размышление.
- Строка вида «понять, что делать с X» — не сюда, это в `plan.md` под соответствующий milestone.
- Запрет: `Goal`, `Milestones`, `Contingency`, **`Blocked` секции (блокеры — в `plan.md §Blockers` как first-class)**.
- Один `ACTIVE` шаг в каждый момент.

### `01_now/ops/<contour>/delegations/<person-slug>.md`
- Один файл на пару (контур, делегат). Если один делегат в двух контурах — два файла.
- Секции: `Active`, `Done (7d)`, `Archive`. `Waiting` и `Overdue` — через поле `due:` и grep.
- Формат строки:
  ```
  - [ ] 2026-04-12 → суть задачи [TRACKER-123](url) • due: 2026-04-20 • [встреча](rel-link)
  ```
- Внешний трекер — source of truth задачи. Файл — lean index.
- Passive recall: при упоминании имени делегата в свежем контексте агент показывает его открытые строки.

### Если у командного контура уже есть живой внешний трекер
- Общий `tasks.md` не превращается во второй рабочий список; он держит только шаги по самой оболочке контура.
- Назначения, сроки, блокировки и статусы читаются из внешнего трекера.
- `delegations/` либо остаются кратким индексом со ссылками в трекер, либо переводятся в архивный переходный слой.
- Личный обзор владельца хранится только вне общего репозитория как производная сводка, а не как второй источник правды.

### `01_now/personal/tasks.md`
- Единственный файл для личных обязательств владельца.
- Две секции: `Hard` (внешние обязательства миру) и `Maybe` (короткие напоминания).
- Желания, curiosity, проектная работа — **не сюда**.
- Frontmatter: `last_rewrite: YYYY-MM-DD`, плюс такая же строка в теле.
- Forced rewrite раз в месяц. Без weekly review.
- Ambient capture: строка добавляется без MR-diff.
- Не читается на ежедневной основе.

### `<project>/context.md`
- Только устойчивые инварианты.
- Эпизодика со встреч **не попадает** — она в саммари встречи под хэштегом.
- Триггер переноса из эпизодики: сформулирован опинион («мы знаем про X, что Y»).

### `<meeting>.md`, секция `## Упомянуто вскользь`
- Теги — только из canonical registry [meta/TAGS.md](../TAGS.md#task-routing-tags).
- Новый тег — сначала добавить в registry, потом использовать.
- Формат: `- #canonical-tag: что было упомянуто одной фразой`.

## Миграция legacy `tasks.md` при первом касании проекта

Когда агент открывает проект без `plan.md`:
1. Читает `tasks.md`.
2. Прогоняет decision tree по каждой строке.
3. Показывает владельцу MR-diff: что → `plan.md`, что → `delegations/<person>.md`, что → `personal/tasks.md`, что остаётся в `tasks.md`.
4. После подтверждения создаёт `plan.md` из [шаблона](../templates/project_plan.md), переносит строки, сокращает `tasks.md`.
5. Пишет одну строку в `log.md`: «миграция в task-routing-methodology-2026-04».

Массовая миграция без явного запроса владельца **запрещена**.

## Антипаттерны (так нельзя)

- Класть `Goal` в `tasks.md` — он в `plan.md`.
- Складывать делегирование в `tasks.md` проекта под видом «моя задача — проверить, что Дима сделал X».
- Писать личное обязательство («продлить визу») в project `tasks.md` только потому, что упомянуто на встрече проекта.
- Писать эпизодический факт со встречи в `context.md` проекта — это инвариант с будущей полурасспадой.
- Делать `delegations/<person>.md` единым на все контуры.
- Применять `tasks.md` как журнал событий — это `log.md`.
- Автоматически переносить тему из эпизодики в `context.md` по счётчику, без формулировки опиниона.
- **Держать блокеры в `tasks.md §Blocked`** — секции больше нет, блокеры живут в `plan.md §Blockers` как first-class сущности с cascade через `Блокирует: Mx`.
- **Писать блокер без связи с milestone'ами** — поле `Блокирует` обязательно, иначе блокер теряет адресность.
- **Закрывать блокер сначала в `tasks.md`** — ritual разрешения идёт сверху вниз: plan.md → log.md → delegations/, не наоборот.
- **Записывать одну и ту же delegated-work задачу в plan.md §Blockers и в delegations/ без двусторонней ссылки** — ссылки обязательны, иначе файлы расходятся.

## Связанные правила

- [Правило 5: log.md — хронология, не хранилище](../../AGENTS.md) — соседний паттерн разделения слоёв.
- [Правило 6: уточнять, не угадывать](../../AGENTS.md) — при неоднозначной маршрутизации.
- [Правило 8: mid-flight sync](../../AGENTS.md) — когда писать в log.md и context.md.
- [Правила 10–14](../../AGENTS.md) — источник этого чеклиста.
- [write-protocol.md](./write-protocol.md) — протокол записи файла в vault.
- [live-first-audit.md](./live-first-audit.md) — статус делегирования только по трекеру.

## Следующий шаг

Поддерживать этот файл синхронно с [task-routing-methodology-2026-04.md](../../03_knowledge/task-routing-methodology-2026-04.md). При изменении методологии — сначала правка методологии, потом этого чеклиста, потом AGENTS.md.
