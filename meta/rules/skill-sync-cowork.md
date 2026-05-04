---
id: skill-sync-cowork
type: rules
status: active
created: 2026-04-22
updated: 2026-05-04
aliases:
  - "Синхронизация скиллов Cowork"
  - "Правило синхронизации скиллов"
tags: [rules, skills, cowork, sync]
source_path: "meta/rules/skill-sync-cowork.md"
globs: "skills/**"
---

# Правило: синхронизация скиллов vault → Cowork

## Когда срабатывает

При **любом** изменении файлов в `skills/` — создание нового скилла, редактирование SKILL.md, удаление скилла.

## Суть

Vault (`skills/`) — единственный source of truth для кастомных скиллов. Cowork может держать две копии: персональные скиллы в `~/.claude/skills/` и активный кэш Claude Desktop `~/Library/Application Support/Claude/local-agent-mode-sessions/skills-plugin/.../skills/`. После редактирования скилла в vault нужно убедиться, что `~/.claude/skills/` указывает на vault через symlinks, а `skills-plugin` содержит свежие физические копии через `rsync`. Скрипт синхронизации входит в комплект поставки: [sync-cowork-skills.sh](../../skills/sync-cowork-skills.sh).

## Что делать агенту

### После редактирования существующего скилла

1. Если скилл входит в Cowork include-list (см. ниже) — **обязательно запусти `./skills/sync-cowork-skills.sh` после правки**. `skills-plugin` — физическая `rsync`-копия, не live-link; без запуска скрипта Cowork останется на старой версии.
2. После запуска проверь `./skills/sync-cowork-skills.sh --status`: `~/.claude/skills/` должен показывать `symlink ✓`, а `skills-plugin` — `copy ✓`. Абсолютные symlinks хоста в `skills-plugin` запрещены: внутри Cowork VM они broken.
3. Сообщи владельцу: «Скилл `<name>` обновлён и синхронизирован. Cowork подхватит изменения при следующей сессии (или после `/reload-plugins`).»

### После создания нового скилла

1. Спроси владельца: «Нужен ли этот скилл в Cowork? Если да — добавлю в include-list и создам symlink.»
2. Если да:
   - Добавь имя скилла в массив `INCLUDE_SKILLS` в `skills/sync-cowork-skills.sh`
   - Выполни: `./skills/sync-cowork-skills.sh` (или попроси владельца запустить, если нет доступа к терминалу хоста). Скрипт создаёт symlink в `~/.claude/skills/` и копирует скилл в активный `skills-plugin` кэш Cowork через `rsync`.
3. Если нет — скилл остаётся vault-only (доступен в Claude Code CLI, но не в Cowork).

### После удаления скилла

1. Если скилл был в include-list — убери его из `INCLUDE_SKILLS` в `skills/sync-cowork-skills.sh`
2. Запусти `./skills/sync-cowork-skills.sh` — скрипт удалит осиротевший symlink

## Include-list (актуальный)

Скиллы, синхронизируемые в Cowork через `rsync`-копии в `skills-plugin`:

По умолчанию скрипт берёт все скиллы из `skills/*/SKILL.md`. Для ограничения списка используй переменную окружения:

```bash
COWORK_SKILLS="research parking resume" ./skills/sync-cowork-skills.sh
```

В публичном комплекте не должно быть ссылок на приватные скиллы, которых нет в текущей папке `skills/`.

## Чего НЕ делать

- Не редактировать скиллы в `~/.claude/skills/` или `skills-plugin` напрямую — все правки через vault
- Не копировать скиллы вручную — только `rsync` через скрипт
- Не добавлять в include-list скиллы, требующие инструментов только для терминала (`git`, `make`) — в Cowork они бесполезны
