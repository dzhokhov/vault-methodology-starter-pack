---
id: scripts-readme
type: index
status: active
created: 2026-04-30
updated: 2026-04-30
aliases:
  - "Скрипты проверки"
tags: [index, scripts, validation]
source_path: "scripts/README.md"
---

# scripts

## Суть

Минимальный исполняемый слой для проверки переносимого хранилища.

## Детали

Скрипты не зависят от внешних сервисов и не содержат путей владельца.

### Состав

- [check_links.py](./check_links.py) — проверяет относительные ссылки на `.md` файлы.
- [check_forbidden_markers.py](./check_forbidden_markers.py) — ищет запрещённые маркеры: локальные пути, рабочие контуры, токены и другие строки, которые не должны попадать в отчуждаемый пакет.
- [inventory.py](./inventory.py) — показывает количество файлов, размер и состав верхнего уровня.

### Как запускать

Из корня пакета:

```bash
python3 scripts/inventory.py
python3 scripts/check_links.py
python3 scripts/check_forbidden_markers.py
```

Или указать путь явно:

```bash
python3 scripts/check_links.py /path/to/vault
```

## Следующий шаг

После любых изменений пакета прогоняйте все три скрипта.
