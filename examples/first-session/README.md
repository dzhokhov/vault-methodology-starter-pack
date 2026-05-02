---
id: example-first-session-readme
type: guide
status: active
created: 2026-05-02
updated: 2026-05-02
aliases:
  - "First session example"
tags: [example, onboarding, vault]
source_path: "examples/first-session/README.md"
---

# First Session Example

## Summary

This example shows the smallest useful vault cycle: an unsorted inbox note becomes a project with state files that a future AI session can read.

## Scenario

A user wants to test whether agent work can survive outside chat history.

The user adds one file:

- [Inbox note](./00_inbox/test-note.md)

Then the agent routes it into:

- [Project README](./01_now/projects/example-test-agent-vault/README.md)
- [Plan](./01_now/projects/example-test-agent-vault/plan.md)
- [Tasks](./01_now/projects/example-test-agent-vault/tasks.md)
- [Context](./01_now/projects/example-test-agent-vault/context.md)
- [Log](./01_now/projects/example-test-agent-vault/log.md)

## What To Notice

- The inbox file is not treated as permanent knowledge.
- The project has a stable entry point.
- `plan.md` explains the goal and boundaries.
- `tasks.md` holds only the current execution queue.
- `context.md` stores stable facts.
- `log.md` records what happened.
- A new session can resume by reading the project files.

## Try It

Copy this pattern into the real vault root, or use it as a reference while following [Quickstart](../../QUICKSTART.md).
