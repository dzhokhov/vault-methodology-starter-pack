---
id: example-test-agent-vault-context
type: note
status: active
created: 2026-05-02
updated: 2026-05-02
aliases:
  - "Test agent vault context"
tags: [example, context]
source_path: "examples/first-session/01_now/projects/example-test-agent-vault/context.md"
---

# Context

## Summary

The useful state is the file structure plus the five project state files, not the original chat.

## Stable Facts

- New material starts in `00_inbox/`.
- Active project work lives under `01_now/projects/`.
- A project should have `README.md`, `plan.md`, `tasks.md`, `context.md`, and `log.md`.
- `tasks.md` is for the current execution queue.
- `log.md` is for short event history.

## Next Step

Use this context when testing whether a new session can continue from files.
