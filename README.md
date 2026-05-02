# Vault Methodology Starter Pack

Stop starting every AI session from zero.

This repository is an open-source starter kit for an agent-ready Markdown vault. It gives you a folder structure, `AGENTS.md`, project templates, routing rules, skills, logs, and small validation scripts so work with an AI agent can live in files instead of only in chat history.

Use it when you want an agent to open a folder, understand the current state, place new material in the right home, update links, and continue the same project in a later session.

## Languages

The public overview is in English. Core first-run documents are available in both English and Russian:

| English | Russian |
|---|---|
| [`AGENTS.en.md`](./AGENTS.en.md) | [`AGENTS.md`](./AGENTS.md) |
| [`START_HERE.en.md`](./START_HERE.en.md) | [`START_HERE.md`](./START_HERE.md) |
| [`ONBOARDING.en.md`](./ONBOARDING.en.md) | [`ONBOARDING.md`](./ONBOARDING.md) |

## What Problem It Solves

Most AI work starts clean and ends messy:

- context stays in the chat, not in the workspace;
- files are uploaded, summarized, and then forgotten;
- the next session needs the same explanation again;
- project state, decisions, tasks, and reusable knowledge drift apart.

This starter pack makes the file system the durable state layer:

- `AGENTS.md` tells the agent how to behave in this vault;
- `00_inbox/` holds new material before it is routed;
- `01_now/` holds active projects and current work;
- `03_knowledge/` holds reusable knowledge;
- `log.md`, `plan.md`, `tasks.md`, and `context.md` let a future agent resume work without guessing.

## Who This Is For

This is useful if you:

- use coding or research agents with local files;
- keep notes in Markdown or Obsidian;
- want project state to survive between AI sessions;
- need a repeatable way to route files, decisions, tasks, and reusable knowledge;
- prefer plain files over a hosted memory product.

This is probably not for you if you want:

- a hosted app;
- an Obsidian plugin;
- automatic semantic memory;
- a task tracker replacement;
- a finished product with broad compatibility guarantees.

## First 10 Minutes

1. Use this repository as a template or clone it into a safe test folder.
2. Open the folder in your AI coding agent or local assistant.
3. Ask the agent:

   ```text
   Open this folder as my working vault. First read AGENTS.en.md, START_HERE.en.md, QUICKSTART.md, and ONBOARDING.en.md. Explain the folder structure, then walk me through one safe test project using a small file in 00_inbox/.
   ```

4. Put a small test note into `00_inbox/`.
5. Ask the agent to route it into a project, update links, and write a short log entry.
6. Open `examples/first-session/` to see what a finished first cycle looks like.

For a practical walkthrough, see [QUICKSTART.md](./QUICKSTART.md).

## What Is Inside

| Path | Role |
|---|---|
| [`AGENTS.en.md`](./AGENTS.en.md) / [`AGENTS.md`](./AGENTS.md) | Operating rules for agents working inside the vault |
| [`START_HERE.en.md`](./START_HERE.en.md) / [`START_HERE.md`](./START_HERE.md) | Short entry point for the first session |
| [`ONBOARDING.en.md`](./ONBOARDING.en.md) / [`ONBOARDING.md`](./ONBOARDING.md) | Full onboarding guide |
| [`QUICKSTART.md`](./QUICKSTART.md) | 5-10 minute practical start |
| [`00_inbox/`](./00_inbox/README.md) | New, unsorted material |
| [`01_now/`](./01_now/README.md) | Active projects and current work |
| [`02_domains/`](./02_domains/README.md) | Long-lived areas of life or work |
| [`03_knowledge/`](./03_knowledge/README.md) | Reusable knowledge and methods |
| [`04_logs/`](./04_logs/README.md) | Timeline, reviews, and decision logs |
| [`90_archive/`](./90_archive/README.md) | Completed or obsolete material |
| [`meta/`](./meta/README.md) | Rules, indexes, and templates |
| [`skills/`](./skills/README.md) | Reusable instructions for recurring task types |
| [`scripts/`](./scripts/README.md) | Local validation scripts |
| [`examples/first-session/`](./examples/first-session/README.md) | Minimal example of one routed file becoming a project |

## How It Differs

| Alternative | What it gives you | How this differs |
|---|---|---|
| A single `AGENTS.md` | Behavior rules for the agent | This adds a full file architecture: inbox, active projects, knowledge, logs, templates, skills, and routing rules |
| Basic Memory style tools | A memory layer for notes and recall | This is a plain-file operating method for project state, decisions, tasks, and source material |
| Cline Memory Bank | Project memory files for coding work | This generalizes the idea to a whole Markdown vault, including non-code projects, inbox routing, knowledge extraction, and logs |
| Obsidian plugins | UI features, backlinks, or automation inside Obsidian | This does not require a plugin. It is a folder convention and agent workflow that can be opened by any file-aware assistant |
| A normal Obsidian vault | Notes and links for a human | This adds explicit agent rules, project state files, lifecycle rules, skills, and checks so an AI session can work safely with the vault |

## Maturity

Current status: early public starter pack.

What is ready:

- portable folder structure;
- agent rules;
- project templates;
- routing rules;
- onboarding guide;
- reusable skills;
- local validation scripts;
- first minimal example.

What is not ready yet:

- broad tool-specific setup guides;
- external user examples;
- compatibility claims for every agent tool;
- polished automation around releases and checks.

## Repository Topics

Recommended GitHub topics:

```text
ai-agents
second-brain
obsidian
markdown
knowledge-management
agent-skills
agentsmd
starter-kit
pkm
```

Do not add tool-specific topics such as `claude-code`, `cursor`, `codex`, or `mcp` until this repository includes tested setup notes for those tools.

## Validate The Pack

From the repository root:

```bash
python3 scripts/inventory.py
python3 scripts/check_links.py
python3 scripts/check_forbidden_markers.py
```

These checks are intentionally small. They help catch broken Markdown links and private markers before a release.

## Contributing

Contributions are welcome, especially:

- clearer first-run instructions;
- minimal examples from real workflows;
- compatibility notes for specific tools;
- safer routing rules;
- template improvements.

Start with [CONTRIBUTING.md](./CONTRIBUTING.md), [SUPPORT.md](./SUPPORT.md), and [ROADMAP.md](./ROADMAP.md).

## License

MIT. See [LICENSE](./LICENSE).
