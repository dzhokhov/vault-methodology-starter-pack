---
id: agents-rules-en
type: note
status: active
created: 2026-05-02
updated: 2026-05-02
aliases:
  - "Agent rules"
  - "AGENTS English"
tags: [rules, llm, workflow, vault, english]
source_path: "AGENTS.en.md"
---

# AGENTS.md - Agent Rules For A File-Based Vault

English version of [AGENTS.md](./AGENTS.md).

## Core Principle

This vault works only when important documents are reachable through indexes, links, and routing rules.

When an agent creates or changes a file, it must update the relevant indexes and record important decisions in the right log.

## Folder Map

| Folder | Purpose |
|---|---|
| `00_inbox/` | New, unsorted material |
| `01_now/` | Active work: projects, current areas, personal tasks |
| `02_domains/` | Long-lived areas of life or work |
| `03_knowledge/` | Reusable knowledge, methods, and references |
| `04_logs/` | Timeline, reviews, and decision logs |
| `90_archive/` | Completed or obsolete material |
| `meta/` | Rules, templates, and system indexes |
| `skills/` | Skills: reusable instructions for recurring task types |

## Loading Context

Before answering, the agent identifies the task type and reads the smallest useful context.

| Task type | Read first |
|---|---|
| Active project | `01_now/projects/<project>/README.md`, then `context.md`, and when needed `plan.md`, `tasks.md`, `log.md` |
| Long-lived area | `02_domains/README.md`, then the relevant section |
| Reference or method | `03_knowledge/README.md`, then the relevant file |
| Creating or editing a file | `meta/rules/write-protocol.md` |
| Routing tasks | `meta/rules/task-routing.md` |
| Processing inbox material | `meta/rules/inbox-processing.md` |
| Reviewing or cleaning the vault | `meta/rules/vault-review.md` |
| Creating temporary files | `meta/rules/cleanup-by-design.md` |

If the project or area is ambiguous, ask one short clarifying question and do not read multiple unrelated work areas to guess.

## Creating A Project

New active projects live in `01_now/projects/<year>-<slug>/`.

Each project should have:

- `README.md` - entry point, purpose, and navigation;
- `plan.md` - goal, boundaries, milestones, and blockers;
- `tasks.md` - current execution queue;
- `context.md` - stable project knowledge;
- `log.md` - short event and decision history.

`plan.md` keeps direction. `tasks.md` keeps only the current execution queue. History lives in `log.md`, not in `tasks.md`.

## After Writing Files

After creating or substantially changing a file, the agent checks:

1. Does the Markdown file have suitable front matter when the vault expects it?
2. Is the folder `README.md` updated?
3. Should project `plan.md`, `context.md`, `log.md`, or `tasks.md` be updated?
4. Do relative links work?
5. Can a future agent find the file through navigation?
6. Is there a lifecycle plan for temporary files?

## Skills

Skills live in `skills/<name>/SKILL.md`. The agent reads a skill only when the task matches that skill.

Core skills include:

- `meeting-processing` - process meeting notes and transcripts;
- `research` - research and store reusable findings;
- `ilyakhov-editor` - edit Russian text;
- `parking` - save a return point;
- `resume` - return to a parked task;
- `new-dialog-handoff` - safely move work to a new chat;
- `owner-only-dev-orchestrator` - run development work with minimal owner involvement;
- `test-gates` - verify changes;
- `release-rollback` - release and rollback workflow.

## Response Language

The agent answers in the user's language. If it uses a technical term, it explains it in plain language the first time.

## Do Not

- Do not create files without a clear place and purpose.
- Do not leave important files without links from indexes.
- Do not store long-lived knowledge inside a temporary project.
- Do not mix personal obligations, delegated work, and project goals in one list.
- Do not delete logs or inbox material without an explicit owner request.
- Do not read personal mail, messengers, or external services without an explicit owner request.

## First Step

On first launch, read `START_HERE.en.md`, this file, and `meta/rules/write-protocol.md`, then briefly explain how the vault is organized.
