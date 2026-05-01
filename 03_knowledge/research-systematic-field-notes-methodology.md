---
id: research-systematic-field-notes-methodology
type: note
status: active
created: 2026-04-20
updated: 2026-04-20
aliases:
  - "Методология систематического сбора полевых заметок из встреч с клиентами"
tags: [knowledge, research, methodology, field-notes, customer-insight, meetings]
source_path: "03_knowledge/research-systematic-field-notes-methodology.md"
freshness: seasonal
expires: 2026-10-20
research_type: knowledge
confidence: low
---

# Методология систематического сбора полевых заметок из встреч с клиентами

## Суть
Исследование: как системно фиксировать инсайты из встреч с агентствами / клиентами, чтобы данные не терялись, а накапливались во всех контурах, где могут пригодиться. Важное ограничение: наблюдения из одной встречи не должны записываться как канон — нужен механизм маркировки уровня подтверждённости и постепенного повышения confidence при появлении подтверждений из других источников.

## Детали

### TL;DR

- ✅ Базовая единица хранения — **атомарное наблюдение (nugget)**: одно утверждение + источник + теги + уровень подтверждённости. Не отчёт, не summary, а факт из конкретной встречи.
- ✅ Четырёхуровневая иерархия (адаптация Atomic Research Pidcock/Sharon): **Эксперимент → Факт → Инсайт → Рекомендация**. Каждый уровень ссылается на предыдущий, а не существует сам по себе.
- ✅ **Confidence ladder** — механизм повышения подтверждённости: `single-source` → `emerging` (2-3 источника) → `confirmed` (4+ или разнотипных) → `canonical`. Наблюдение из одной встречи НИКОГДА не записывается как канон.
- ✅ **Grounded Theory saturation** — критерий остановки: когда новые встречи перестают давать новые категории, а только подтверждают уже выявленные.
- ⚠️ Практические инструменты (Dovetail, Condens, Notion) вторичны — важна структура данных и протокол, а не софт.
- ❓ Оптимальное количество встреч до насыщения: литература говорит 10-15 для customer discovery; для отраслевых наблюдений может быть больше — зависит от разнообразия типажей.

### 1. Теоретический фундамент: Atomic Research

Daniel Pidcock и Tomer Sharon независимо предложили подход Atomic Research (по аналогии с Atomic Design Брэда Фроста): исследовательское знание разбивается на минимальные самостоятельные единицы — **nuggets**.

**Иерархия Pidcock (четыре уровня):**

| Уровень | Формулировка | Пример (Климчуковы) |
|---------|-------------|---------------------|
| **Experiment** | «Мы сделали это…» | Вводная встреча с партнёром, 2026-04-16 |
| **Fact** | Наблюдение без интерпретации | «Ксения пробовала AMO CRM — вела месяц, бросила. Она единственный продажник.» |
| **Insight** | Интерпретация одного или нескольких фактов | «Для агентств масштаба 1-3 человека CRM — overhead без value, если координировать некого.» |
| **Recommendation** | Действие на основе инсайта | «INF-15 не работает для этого сегмента. Нужна альтернативная точка входа контекста клиента.» |

**Ключевой принцип:** факт не содержит мнения исследователя — только то, что было обнаружено или высказано участником. Интерпретация живёт на отдельном уровне и явно ссылается на факты.

**Иерархия Sharon (три уровня):** observation + evidence + tags — проще, но не разделяет факт и интерпретацию.

Для нашего vault адаптация Pidcock предпочтительнее: она явно отделяет «что сказали» от «что мы думаем, что это значит» — что критично при `confidence: single-source`.

### 2. Confidence Ladder: от наблюдения к канону

Центральная проблема: наблюдение из одной встречи — не истина, но и не мусор. Нужна шкала.

**Предлагаемые уровни:**

| Уровень | Критерий | Как маркировать | Что можно делать |
|---------|----------|-----------------|-----------------|
| `single-source` | Одна встреча / один человек | `confidence: single-source` в frontmatter | Фиксировать как field note. Не ссылаться как на факт в решениях. |
| `emerging` | 2-3 независимых источника подтвердили | `confidence: emerging` + ссылки на sources | Формулировать гипотезу. Можно ссылаться с оговоркой «emerging pattern». |
| `confirmed` | 4+ источника ИЛИ разнотипные подтверждения (встреча + данные + внешний ресёрч) | `confidence: confirmed` | Использовать как рабочий инвариант в context.md. |
| `canonical` | Подтверждено, проверено adversarial, не опровергнуто за ≥3 месяца | `confidence: canonical` | Переносить в domain knowledge, строить на этом продуктовые решения. |

**Механизм повышения:**
При появлении нового подтверждения — обновить `confidence` в frontmatter, добавить ссылку на источник подтверждения, записать дату и контекст повышения. Понижение тоже возможно (контрпример обнаружен).

**Аналогия из Grounded Theory:** теоретическое насыщение (theoretical saturation) — момент, когда новые данные перестают генерировать новые категории и только подтверждают существующие. Glaser & Strauss: «no additional data are being found whereby the sociologist can develop properties of the category». Для customer discovery это обычно 10-15 интервью; для отраслевой таксономии — больше, зависит от разнообразия сегментов.

### 3. Структура хранения: куда что маршрутизировать

Наблюдения из встречи касаются разных контуров. Текущий vault уже имеет нужную структуру; задача — определить маршрут для каждого типа данных.

**Маршрутизация по типу наблюдения:**

| Тип данных | Куда | Формат | Пример |
|-----------|------|--------|--------|
| Полевые заметки (пачка наблюдений из одной встречи) | `03_knowledge/field-notes-{тема}-{дата}.md` | Markdown с frontmatter `confidence: single-source` | `field-notes-agency-operations-klimchukovy-2026-04.md` |
| Факт о конкретном человеке / организации | Карточка в `03_knowledge/contacts-network/persons/` или `orgs/` | Секция «Профиль» или «Заметки» | «Партнёр сравнил два подхода к запуску» → карточка партнёра |
| Проектно-специфичные следствия | `01_now/projects/<project>/context.md` | Ссылка на field note + краткое следствие | «INF-15 не работает для агентств без CRM» → context.md AI Hub |
| Кросс-встречный паттерн (когда ≥2 встречи подтвердили) | `03_knowledge/patterns-{домен}.md` или отдельный файл | Markdown с `confidence: emerging` | «CRM-антипаттерн у маленьких агентств» → отдельный паттерн при подтверждении Федосеевой |
| Открытый вопрос для следующих встреч | `01_now/projects/<project>/plan.md` §Open Questions | Строка с ссылкой на field note | «Обесценивание глубокой семантики — подтвердят ли другие?» |
| Задача (нужно что-то сделать) | `tasks.md` соответствующего проекта | Строка задачи | «Подготовить preread для live-демо Климчуковых» |

### 4. Протокол обработки встречи (операционный чеклист)

**Шаг 1. Саммари встречи** (в день встречи или следующий)
- Транскрипт → meeting-processing skill → саммари в проектной папке
- Обновить карточки участников, interactions.csv, contacts-index

**Шаг 2. Извлечение атомарных наблюдений** (в тот же сеанс)
- Перечитать транскрипт целиком с фокусом «что нового я узнал о рынке / клиенте / продукте»
- Для каждого наблюдения зафиксировать: (a) цитата или парафраз, (b) кто сказал, (c) контекст, (d) следствие для проекта
- Разделить факты и интерпретации (уровни Pidcock)

**Шаг 3. Маршрутизация** (в тот же сеанс)
- Каждое наблюдение отправить в нужный контур по таблице из §3
- Field notes — в `03_knowledge/`, следствия — в `context.md`, задачи — в `tasks.md`
- Поставить `confidence: single-source` на все новые наблюдения

**Шаг 4. Перекрёстная проверка** (при следующей встрече или ресёрче)
- Перед каждой новой встречей пробежать open questions из предыдущих field notes
- Если новая встреча подтверждает / опровергает — обновить confidence + добавить ссылку
- При достижении `emerging` — вынести в отдельный паттерн-файл

**Шаг 5. Периодический синтез** (раз в месяц или при 5+ field notes)
- Просканировать все field notes за период
- Выявить повторяющиеся темы → оформить как patterns
- Обновить confidence у подтверждённых наблюдений
- Закрыть опровергнутые гипотезы

### 5. Адаптация к текущему vault

Что уже работает:
- `meeting-processing` skill покрывает Шаг 1 (саммари, карточки, interactions)
- YAML frontmatter с `confidence: single-source` уже используется в field notes Климчуковых
- Маршрутизация по контурам описана в AGENTS.md и task-routing

Что нужно добавить:
- **Шаг 2 формализовать как часть meeting-processing** — после саммари автоматически переходить к извлечению атомарных наблюдений
- **Таблица маршрутизации** (§3) — добавить в meeting-processing skill или в AGENTS.md как подсекцию
- **Confidence ladder** — добавить в write-protocol.md как правило маркировки
- **Периодический синтез** (Шаг 5) — добавить в vault-review протокол или как отдельный scheduled task

### Альтернативные точки зрения

- **Минимализм:** некоторые практики (NN/g, Teresa Torres) считают, что достаточно вести «opportunity solution tree» — дерево, где наблюдения привязаны к возможностям. Отдельный репозиторий nuggets — overhead для маленьких команд.
- **Tooling-first:** Dovetail, Condens, Marvin — SaaS-инструменты для insight repositories. Их преимущество: AI-assisted tagging, автоматическая кластеризация. Недостаток: vendor lock-in, данные не в vault.
- **«Не фиксировать, а действовать»:** lean-подход — если наблюдение не ведёт к немедленному действию, оно не стоит фиксации. Контраргумент: в нашем случае одно наблюдение не ведёт к действию, но пять похожих — ведут. Без накопления паттерн не проявится.

### Blind spots и ограничения

- Исследование основано на литературе по UX Research и Customer Discovery. Прямых аналогов «field notes from B2B sales meetings → product development» в литературе мало — это скорее адаптация.
- Confidence ladder (§2) — авторская конструкция, не валидированная на практике. Пороги (2-3 для emerging, 4+ для confirmed) — стартовые, подлежат калибровке.
- Не рассмотрен вопрос ownership: кто отвечает за периодический синтез, когда встреч станет много.
- Grounded Theory в чистом виде предполагает кодирование (open → axial → selective coding). В vault этому соответствует теги → паттерны → доменное знание, но формальный coding protocol не описан.

## Источники

### Академические
- [Glaser & Strauss — Grounded Theory, теоретическое насыщение](http://www.scielo.br/j/reben/a/h6skK6tnvW4phBYzvxpWJ3Q/?lang=en) — методология достижения насыщения в qualitative research
- [Data Saturation in Grounded Theory](https://nsuworks.nova.edu/cgi/viewcontent.cgi?article=2994&context=tqr) — «the mysterious step» — когда считать данные достаточными
- [A Guide to Field Notes for Qualitative Research](https://www.researchgate.net/publication/315944152_A_Guide_to_Field_Notes_for_Qualitative_Research_Context_and_Conversation) — контекстные и разговорные полевые заметки

### Практические
- [Daniel Pidcock — What is Atomic UX Research?](https://blog.prototypr.io/what-is-atomic-research-e5d9fbc1285c) — оригинальная статья: experiments → facts → insights → recommendations
- [User Interviews — Atomic Research Nuggets](https://www.userinterviews.com/ux-research-field-guide-chapter/atomic-research-nuggets) — практическое руководство по nugget-based repositories
- [Maze — What is Atomic Research?](https://maze.co/collections/user-research/atomic-research/) — обзор применения в UX-командах
- [Dovetail — Atomic Research: From reports to consumable insights](https://dovetail.com/blog/atomic-research/) — адаптация для продуктовых команд
- [Teresa Torres — Customer Interviews](https://www.producttalk.org/2022/12/customer-interviews/) — интервью + opportunity solution tree

### Коммерческие (учитывать bias)
- [Neil Turner — Building a Customer Insights Repository](https://medium.com/ingeniouslysimple/building-a-customer-insights-repository-347d382e2ed7) — структура insight repository (автор — UX-консультант, не продаёт софт)
- [Insight7 — How to Build an Insights Repository](https://insight7.io/how-to-build-an-insights-repository-in-2024/) — обзор, но продвигает собственный продукт

## Следующий шаг

1. Добавить confidence ladder в `meta/rules/write-protocol.md` как формальное правило маркировки
2. Расширить meeting-processing skill Шагом 2 (извлечение атомарных наблюдений)
3. Добавить monthly review field notes в vault-review протокол
4. После 3-5 встреч с агентствами — провести первый синтез и проверить, работает ли confidence ladder на практике
