---
id: vault-methodology-start-here-en
type: guide
status: active
created: 2026-05-02
updated: 2026-05-02
aliases:
  - "Start here"
  - "First vault entry"
tags: [guide, onboarding, vault, methodology, english]
source_path: "START_HERE.en.md"
---

# Start Here

English version of [START_HERE.md](./START_HERE.md).

## Summary

This is not a file archive. It is a working environment for a human and an AI agent.

## The Idea

The agent should not only answer in chat. It should help keep order in files.

For that, the vault needs:

- a clear folder structure;
- writing and routing rules;
- indexes and links;
- templates;
- skills for recurring tasks;
- logs that preserve decisions.

If you are new to this method, read [ONBOARDING.en.md](./ONBOARDING.en.md). This file is the short entry point; onboarding explains the first full workflow.

## Folder Map

- `00_inbox/` - new, unsorted material.
- `01_now/` - active projects and current work.
- `02_domains/` - long-lived areas of life or work.
- `03_knowledge/` - reusable knowledge.
- `04_logs/` - decision history, reviews, and timeline.
- `90_archive/` - completed or obsolete material.
- `meta/` - rules, templates, and system indexes.
- `skills/` - reusable instructions for recurring task types.

## First Prompt To Your Agent

Send:

```text
Open this folder as my working vault. First read AGENTS.en.md, START_HERE.en.md, and ONBOARDING.en.md. Explain the folder structure, the main rules, and suggest one safe first test.
```

If you want to use the Russian originals, send:

```text
Открой эту папку как рабочее хранилище. Сначала прочитай AGENTS.md, START_HERE.md и ONBOARDING.md. Объясни структуру папок и предложи первый безопасный учебный шаг.
```

## Adding Material

Put new documents into `00_inbox/` and ask the agent to route them.

Do not manually organize files if you are unsure. The agent should move or copy material only after explaining where it belongs and why, then update indexes and logs.

## Starting A Project

A new active project lives in `01_now/projects/<year>-<slug>/`.

It should contain:

- `README.md` - entry point and navigation;
- `plan.md` - goal, boundaries, milestones, and blockers;
- `tasks.md` - current execution queue;
- `context.md` - stable project knowledge;
- `log.md` - short decision and event history.

## Next Step

Follow [ONBOARDING.en.md](./ONBOARDING.en.md), or ask the agent to run a safe first test with a small file in `00_inbox/`.
