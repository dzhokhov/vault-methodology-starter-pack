---
id: vault-methodology-onboarding-en
type: guide
status: active
created: 2026-05-02
updated: 2026-05-02
aliases:
  - "Vault onboarding"
  - "How to start using the vault"
tags: [guide, onboarding, vault, methodology, agents, english]
source_path: "ONBOARDING.en.md"
freshness: evergreen
knowledge_criticality: high
verification_status: unverified
curation_mode: manual_edit
---

# Vault Methodology Onboarding

English version of [ONBOARDING.md](./ONBOARDING.md).

## Summary

This guide helps you start using the vault: open the folder in an agent, run one safe task, store the result in the right place, check links, and slowly turn repeated work into rules and skills.

## How To Read This

Do not try to learn everything before using the vault. Start with a small test.

1. Read sections 1-3 and run the first-hour route.
2. Return to sections 4-7 when you need to understand where files live.
3. Use sections 8-10 when you start real work.
4. Use sections 11-12 when work becomes long or repeated.
5. Use the final checklist before trusting the result.

If a term is unclear, ask the agent to explain it using this folder as the example.

## 1. Main Idea

The vault is not just a folder of notes. It is a working environment.

The human sets direction and reviews results. The agent reads files, creates documents, updates links, writes logs, and keeps the workspace recoverable.

A normal chat tends to lose work:

- context has to be repeated;
- uploaded files disappear inside a long conversation;
- results must be copied by hand;
- decisions, tasks, and reusable knowledge drift apart.

A file-aware agent can work differently:

- read rules from `AGENTS.en.md` or `AGENTS.md`;
- find documents through `README.md` files and links;
- create and update files in the vault;
- record important events in `log.md`;
- continue in a new chat when state is saved in files.

Do not ask only "write me a text." Ask the agent to work in the vault: find sources, create a project, save the result, update navigation, and check links.

## 2. Before The First Launch

1. Put the vault in a stable folder, not in Downloads.
2. If you want sync, put it in a synced folder.
3. Open the vault root in your AI agent.
4. Open the same folder in Obsidian or another Markdown editor.
5. Make the full path easy to copy.

First prompt:

```text
Open this folder as my working vault. First read AGENTS.en.md, START_HERE.en.md, and ONBOARDING.en.md. Explain the folder structure and the main rules in plain language. Then suggest one safe first test.
```

If the agent starts editing before reading the rules, stop it:

```text
First read AGENTS.en.md and reconsider your actions according to the vault rules.
```

## 3. First-Hour Route

Start with a learning cycle, not a large real task.

1. Open the vault in the agent.
2. Send the first prompt from section 2.
3. Ask for a plain-language explanation of the folder structure.
4. Put one small test document into `00_inbox/`.
5. Ask the agent to create a learning project and process the document.
6. Check which files the agent created and which links it updated.
7. Ask why the result lives there.
8. If the learning project is no longer needed, remove it only after checking links and logs.

Minimal prompt:

```text
I am new to this vault. Walk me through a learning cycle: read the rules, explain the structure, create a test project for one file from 00_inbox/, save the result in the project, and show which indexes and logs were updated.
```

Goal of the first hour: see the workflow from inbox material to project state, links, log, and verification.

## 4. What Lives At The Root

- `README.md` - public overview and navigation.
- `AGENTS.en.md` / `AGENTS.md` - rules for the agent.
- `START_HERE.en.md` / `START_HERE.md` - short first entry.
- `ONBOARDING.en.md` / `ONBOARDING.md` - full onboarding route.
- `QUICKSTART.md` - short public test path.
- `00_inbox/` - new material before routing.
- `01_now/` - active work.
- `02_domains/` - long-lived domains.
- `03_knowledge/` - reusable knowledge.
- `04_logs/` - logs, reviews, and timeline.
- `90_archive/` - completed or obsolete material.
- `meta/` - rules, templates, and indexes.
- `skills/` - reusable task instructions.
- `scripts/` - validation scripts.

## 5. Navigation Rule

A document is not useful if the agent cannot find it.

The vault has three navigation layers:

- `README.md` files explain folders;
- links connect documents;
- `log.md`, `plan.md`, `tasks.md`, and `context.md` preserve project state.

After creating an important file, the agent should:

- add a link from a relevant `README.md`;
- add backlinks from related documents when useful;
- write a short project log entry if the file changes project state;
- verify that the file can be found through navigation.

Check:

```text
If I open a new chat tomorrow and ask about this file, can the agent find it through README files and links?
```

If the answer is no, the work is not finished.

## 6. Where Things Go

Basic routing:

- new and unsorted material -> `00_inbox/`;
- active task with a bounded result -> `01_now/projects/`;
- long-lived work area -> `02_domains/` or the appropriate long-running area;
- reusable knowledge -> `03_knowledge/`;
- decision history -> `04_logs/` or project `log.md`;
- completed work -> `90_archive/`;
- agent rule -> `meta/rules/` or `AGENTS.md`;
- repeatable method -> `skills/<name>/SKILL.md`.

Useful question:

```text
Is this a project, a long-lived area, or reusable knowledge? Explain the routing choice before creating or moving files.
```

## 7. Project State Files

Every active project should be understandable from files alone.

Minimum files:

- `README.md` - what this project is and where to start;
- `plan.md` - goal, non-goals, milestones, blockers, and direction;
- `tasks.md` - current execution queue only;
- `context.md` - stable facts a future session needs;
- `log.md` - short history of events and decisions.

Do not use `tasks.md` as a history file. Do not use `log.md` as a dumping ground for long content.

## 8. Safe First Real Task

Good first real tasks:

- process one meeting note;
- summarize one source document;
- create one small project;
- route a few inbox files;
- create one reusable note from clear source material.

Avoid starting with:

- a full vault reorganization;
- private or sensitive material;
- many files at once;
- automatic deletion;
- complex scripting.

## 9. How To Ask For Work

Weak prompt:

```text
Summarize this.
```

Better prompt:

```text
Process this file inside the vault. First explain where it belongs. Then create or update the right project files, update links, and write a short log entry. Do not delete the source.
```

## 10. Verification

After meaningful changes, ask:

```text
Verify the changed files: check links, explain what was updated, and tell me what a future session should read first.
```

For package validation, run:

```bash
python3 scripts/check_links.py
python3 scripts/check_forbidden_markers.py
python3 scripts/inventory.py
```

## 11. When Work Gets Long

If the chat becomes long or you need to pause, ask the agent to save a return point.

Useful prompt:

```text
Save the current state in the project files: update log.md, context.md if needed, and tasks.md with the next concrete step.
```

The test is simple: a new session should be able to continue from files, not from memory of the old chat.

## 12. Turning Repeated Work Into Skills

When the same workflow repeats, consider a skill.

Good skill candidates:

- meeting processing;
- research capture;
- inbox triage;
- project parking and resume;
- release checks;
- text editing.

Do not create a skill after one accidental task. Create it when the workflow is stable enough to repeat.

## Final Checklist

Before trusting a result, check:

- Did the agent read the right rules?
- Did new material start in the right place?
- Are important files linked from indexes?
- Is project state split between `plan.md`, `tasks.md`, `context.md`, and `log.md` correctly?
- Are temporary files explained?
- Can a new session continue from files?

## Next Step

Run the first-hour route with one safe file in `00_inbox/`, then compare your result with [examples/first-session/](./examples/first-session/README.md).
