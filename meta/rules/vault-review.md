---
id: vault-review
type: rules
status: active
created: 2026-03-30
updated: 2026-03-30
aliases:
  - "Ревью vault"
  - "Vault hygiene"
tags: [rules, vault-hygiene, review]
source_path: "meta/rules/vault-review.md"
---

# Протокол ревью vault

## Суть
Регулярная уборка хранилища. Выполняется по запросу («ревью vault», «vault hygiene») или 1-го числа каждого месяца.

## Шаги

1. **Inbox:** прочитать `00_inbox/PROCESSING_LOG.md` → предложить удалить ✅ processed → разобрать остальное ([протокол](./inbox-processing.md))
2. **Expires:** найти файлы с `expires < today` — обновить, архивировать или удалить
3. **Завершённые проекты:** проверить `01_now/projects/` — предложить архивировать завершённые
4. **Экстракция знаний:** предложить перенести переиспользуемые данные из проектов в `03_knowledge/`
5. **README:** проверить актуальность README всех разделов
6. **Field notes synthesis:** просканировать все `03_knowledge/field-notes-*.md`:
   - Найти повторяющиеся наблюдения из разных источников → повысить `confidence` до `emerging` или `confirmed` (см. [write-protocol.md §1.1](./write-protocol.md))
   - Закрыть или пометить опровергнутые гипотезы (контрпример найден)
   - Если 3+ field notes по одной теме — предложить синтез в отдельный паттерн-файл `03_knowledge/patterns-{домен}.md`
   - Проверить открытые вопросы из field notes — какие ещё актуальны, какие закрыты последующими встречами
   - Обновить профили организаций по таксономии (`contacts-network/companies/`) данными из новых встреч
