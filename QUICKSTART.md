# Quickstart

Use this guide to test the vault method in 5-10 minutes.

## 1. Make A Safe Copy

Use this repository as a GitHub template or clone it into a test folder.

Do not start with your real knowledge base. First learn the workflow on a small copy.

## 2. Open The Folder In An Agent

Open the repository root in your file-aware AI assistant.

Send this prompt:

```text
Open this folder as my working vault. First read AGENTS.md, START_HERE.md, and QUICKSTART.md. Explain the folder structure in plain language. Then help me run one safe test: route a small note from 00_inbox/ into a new project, update links, and write a log entry.
```

The agent should read the rules before editing files.

## 3. Add One Test Input

Create a small Markdown file in `00_inbox/`, for example:

```markdown
# Test note

I want to test whether an AI agent can turn an unsorted note into a small project with state files.
```

Then ask:

```text
Route the test note from 00_inbox/ into a new learning project. Before editing, tell me which files you will create or update. After editing, show me the project README, plan, tasks, context, and log files.
```

## 4. Check The Result

A good first result usually creates or updates:

- a project folder under `01_now/projects/`;
- `README.md` for navigation;
- `plan.md` for goal, boundaries, milestones, and blockers;
- `tasks.md` for the current execution queue;
- `context.md` for stable project knowledge;
- `log.md` for short event history;
- relevant folder indexes.

Compare your result with [examples/first-session/](./examples/first-session/README.md).

## 5. Validate Links

From the repository root:

```bash
python3 scripts/check_links.py
python3 scripts/inventory.py
```

If you changed public package files, also run:

```bash
python3 scripts/check_forbidden_markers.py
```

## 6. Continue In A New Session

Open a new chat and ask:

```text
Continue the project from the vault files. First read AGENTS.md and then find the active project through 01_now/README.md. Explain the current state before doing any edits.
```

The test succeeds when the agent can resume from files instead of needing the old chat history.
