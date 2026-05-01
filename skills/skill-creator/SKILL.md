---
name: skill-creator
description: Create new skills, modify and improve existing skills, and measure skill performance. Use when the user wants to capture a workflow as a reusable skill, draft a new skill, edit or optimize an existing one, run evals against a skill, or tune a skill's description for triggering accuracy.
---

# Skill Creator

A skill for designing, writing, testing, and iterating on skills. The job here is craft — a skill is a small piece of evergreen instruction that will run thousands of times across thousands of conversations, so it has to be lean, well-aimed, and not surprising.

This skill is written to be **agent-agnostic**. It assumes only the minimum that any LLM agent has: the ability to read text, write text, and converse with a user. Everything else (subagents, file system, browser, bundled scripts, CLI tools) is treated as optional capability that may or may not be present. Each stage describes what to do at the methodology level, then notes how to accelerate it if specific capabilities are available.

## The mental model in one paragraph

A skill is metadata plus a body. The metadata (name + description) is a router — it decides whether the skill enters context at all. The body is a working agreement with the model that fires once routed. Bundled resources (`scripts/`, `references/`, `assets/`) are deferred load: they cost nothing until the skill explicitly reaches for them. Your job as skill author is to put the *minimum* into the always-loaded layers and push everything else down. Most bad skills fail because they violate that — they leak operational detail into the body, or stuff trigger logic into prose instead of the description.

---

## Capability profile

Before starting, take stock of what your runtime offers. Each stage uses the strongest available capability and falls back gracefully.

| Capability | If present | If absent |
|---|---|---|
| File system | Save artifacts (SKILL.md, evals, results) to disk | Hold drafts in conversation; ask the user to copy out |
| Subagents / parallel tasks | Run with-skill and baseline tests in parallel | Run them in series, one at a time |
| Browser / display | Open eval viewer for the user to review | Present test outputs inline in the conversation |
| Bundled scripts (Python) | Use them as accelerators where mentioned | Do the equivalent work directly: write small ad-hoc scripts, or do it manually |
| `claude` CLI / programmatic agent invocation | Run automated description-optimization loops | Optimize description by hand using a small set of manual trials |
| Packaging tooling (`present_files`, `.skill` archive) | Hand the user a single file | Hand the user the directory path; they can zip it themselves |

Skills produced by this process must themselves obey the same rule: a created skill should work in any agent that has at least file-read and text-output. If it depends on a specific tool, the description must say so and the body must degrade gracefully.

---

## Stage 1 — Capture intent

Two flavors of intent show up. Identify which one you're in before drafting.

### 1a. Capturing an existing workflow (most common)

The user already does this thing. They want to teach you to do it the same way. The conversation history (or the file they uploaded) is the source of truth, not your imagination.

Extract from history first: what tools were used, in what order, where the user corrected you, what input/output shapes they accepted without comment, what edge cases triggered manual intervention. Then ask only about the gaps. "You handled malformed CSVs by skipping rows last time — should the skill do that or fail loudly?" is a real question. "What's the input format?" when the input format is right there in the transcript is friction the user will resent.

### 1b. New skill from scratch

The user has an idea but no worked example. Interview narrowly — five questions:

1. What should this skill enable the agent to do, in one sentence?
2. When should it trigger? List 3-5 phrasings the user would actually type.
3. What does success look like in concrete terms — a file, a message, a code change?
4. What should it *refuse* to do, and what should the user fall back to?
5. Is this a one-shot, or part of a multi-step process? (Drives Stage 2.)

If the user says "vibe with me" and rejects test cases, don't force it. Subjective skills (writing style, art) genuinely don't benefit from assertion-based evals. Note that decision and move on.

---

## Stage 2 — Choose skill topology

Before writing a single line, decide the shape. Three options:

**Leaf skill** — does one thing, end-to-end, in one body. Most skills should be this. Body is self-contained instruction; references hold dialect-specific or rarely-needed material.

**Router / orchestrator** — routes to other skills or sub-modules based on state. Use when the workflow has clear phases with different decision logic per phase. Routers stay short — they should not contain the actual work, only the routing rules.

**Composite with reference modules** — single SKILL.md, but body delegates to `references/<variant>.md` based on a selector. Use when there's one workflow but multiple substitutable backends (cloud providers, SQL dialects, tool versions). The body holds workflow + selector; references hold per-variant bodies.

Choosing wrong is the most expensive mistake in skill design. A monolithic leaf skill that should have been a router becomes a 1500-line wall that triggers everywhere and follows none of its rules.

Heuristic: **if the workflow has more than one branch where the next instruction depends on the result of the previous one, you're probably in router territory.**

---

## Stage 3 — Survey the ecosystem before writing

Skills don't live alone. In any non-trivial setup the user has dozens to hundreds of skills already installed. Before writing a new one, survey:

- **Direct duplicates**: skills whose descriptions overlap yours by >70%. If found, extend instead of forking.
- **Adjacent skills**: skills that share concepts. Decide explicit boundaries — your description should later say "NOT for X, use `<adjacent-skill>`".
- **Plugin coverage**: if an installed plugin (e.g., a marketing or support pack) covers the domain, place the new skill inside that plugin's namespace and naming convention.

How to do this depends on capability:
- If a skill registry is exposed in your context, list it and grep.
- If it isn't, ask the user to paste the names+descriptions of skills they suspect overlap.

Surface the result before drafting: "I see you already have `<adjacent-skill>`. The skill you're describing overlaps with it on ~60% of intents. Options: (a) extend that one, (b) write a narrower companion that delegates to it, (c) write a separate skill with a clear boundary clause. Which?"

This single step prevents most over-triggering pain at registry scale.

---

## Stage 4 — Write the description (first, as a first-class artifact)

The description is the only thing the model sees when deciding whether to consult the skill. It's not a marketing blurb — it's a routing rule.

A good description has four parts:

1. **What it does** — one clean sentence, action-first.
2. **Concrete trigger surface** — phrases or task shapes that should fire it. Aim for variety: formal/casual, explicit/implicit.
3. **Boundary clauses** — what it is NOT for, and which adjacent skill to use instead.
4. **Optional context cues** — file types, situations, domains.

Example for a hypothetical `incident-postmortem` skill:

> Generate post-incident reviews from incident timelines, Slack threads, and PagerDuty exports. Use when the user says "write a postmortem", "blameless review", "RCA writeup", "what happened with the outage", uploads incident-related transcripts, or asks for a 5-whys / contributing-factors document. NOT for forward-looking risk assessment (use `risk-assessment`) or for customer-facing status updates (use `response-drafting`).

### The pushy-vs-precise trade-off

A description tuned for high recall ("use this whenever the user mentions X, even if they don't explicitly ask") catches more cases but also poaches from neighbors. A description tuned for high precision ("use this only when X and Y") under-fires.

Default position: **be moderately pushy on intent variety, but precise on boundary clauses.** Recall comes from listing many phrasings of the same intent. Precision comes from explicit "NOT for" carve-outs. If the registry is dense, lean precise. If sparse, lean pushy.

### Why this comes before the body

The description determines whether the body ever runs. Writing the body first and the description retroactively almost always produces a description that under-describes the actual capability — by the time you write it, you've forgotten the half of cases the body handles implicitly.

---

## Stage 5 — Write the body

### Anatomy

```
skill-name/
├── SKILL.md (required)
│   ├── YAML frontmatter (name, description)
│   └── Markdown body
└── (optional)
    ├── scripts/    — deterministic / repetitive code
    ├── references/ — docs loaded on demand
    └── assets/     — templates, fonts, images used in output
```

`scripts/` and `references/` are optional and capability-dependent. A skill that bundles scripts must still be usable by an agent that can't execute them — the body should describe what the script does in enough detail that the agent can do it manually.

### Progressive disclosure

Three loading layers:

1. **Metadata** — always in context, ~100 words.
2. **SKILL.md body** — in context when the skill triggers. Target ≤400 lines, hard ceiling ~500.
3. **Bundled resources** — only loaded when the body explicitly reaches for them.

Enforcement rule: **if the body crosses 400 lines, stop and ask whether the next chunk belongs in `references/`.** Operational detail (CLI commands, JSON schemas, viewer mechanics, troubleshooting) does not need to be in the body — it needs to be reachable from it.

For multi-variant skills, use composite topology:

```
cloud-deploy/
├── SKILL.md          — workflow + selector
└── references/
    ├── aws.md
    ├── gcp.md
    └── azure.md
```

The body says "if AWS, read `references/aws.md`". The model loads only what it needs.

### Writing patterns

**Imperative form.** "Read the file, extract the first column" beats "you should read the file and then you can extract".

**Explain why, not just what.** Today's models have good theory of mind. A rule with a reason ("we strip trailing whitespace because downstream parsers treat tabs as field separators") sticks; a bare rule gets ignored under pressure.

**Use ALWAYS / NEVER sparingly and with reason.** Caps-lock is a signal that the author couldn't articulate why. If you find yourself reaching for it, try once to write the reason instead. Reserve absolutes for things that are genuinely categorical (security, data integrity, irreversible actions).

**Show, don't enumerate.** Two worked examples of input → output beats a 12-bullet specification of the format.

**Prefer flat structure.** Deep nested headings signal the body is doing too much. Flatten or extract.

**Capability awareness.** If the body needs a tool that may be absent, say so explicitly: "If `<tool>` is available, use it. Otherwise, do this equivalent manually." Do not write instructions that silently break in restricted environments.

### What goes where

| In body | In `references/` | In `scripts/` |
|---|---|---|
| Workflow steps | Domain-specific cheat sheets | Repeatable transformations |
| Decision rules | JSON schemas, API specs | File generation (docx, pptx, pdf) |
| Anti-patterns / pitfalls | Long lookup tables | Validation / parsing helpers |
| When to read which reference | Edge-case troubleshooting | Bulk operations |

If the model would write the same helper script across three different invocations, that script belongs in `scripts/` — and the body must still describe what it does well enough to be reproducible by an agent that can't run Python.

---

## Stage 6 — Anti-patterns (and how to diagnose them)

Read each draft against this list before showing it to the user.

**1. Monolith.** SKILL.md > 500 lines doing four loosely related things.
*Diagnostic:* you can't summarize the skill in one sentence.
*Fix:* split into a router + leaves, or extract domains to `references/`.

**2. Over-MUSTed.** Body is a wall of ALWAYS / NEVER / MUST / CRITICAL with no rationale.
*Diagnostic:* count caps-lock absolutes. If >5 in 100 lines, you're overconstraining.
*Fix:* for each absolute, write the underlying reason. Many will dissolve into "prefer X because Y".

**3. Overfit-to-tests.** Skill works perfectly on the 3 test prompts and degrades elsewhere.
*Diagnostic:* skill mentions specific filenames, column names, or user phrasings from the test set.
*Fix:* generalize. Replace concrete references with patterns; add at least one test case from a different domain.

**4. Leaky description.** Description is short and vague; body has all the trigger logic in prose.
*Diagnostic:* the body contains phrases like "use this skill when…" or "this skill should fire if…".
*Fix:* move that content up into the description. The body should assume routing already happened.

**5. Cargo-cult inheritance.** Skill copies structure from another skill (sections, naming, scripts) without need.
*Diagnostic:* sections that don't change behavior if you delete them.
*Fix:* delete them.

**6. Surprise.** Skill does something the description doesn't promise.
*Diagnostic:* a user reading only the description would be surprised by a side effect.
*Fix:* either remove the side effect, or surface it in the description.

**7. Hidden capability assumption.** Skill silently assumes subagents, a browser, a CLI, or specific scripts.
*Diagnostic:* the skill stops working in a stripped-down agent without an obvious reason.
*Fix:* declare assumptions in the description; degrade gracefully in the body.

---

## Stage 7 — Test

Two modes. Pick based on user appetite and available capability.

### Vibe mode

User says "just make it, I'll try it". You write the skill, you stop. Optional: walk through one realistic test prompt mentally or out loud and show the output inline. No benchmarks, no viewer.

This is the right default for subjective or low-stakes skills. Don't force a pipeline on a writing-style skill.

### Full mode (methodology)

Three to five realistic test prompts. For each prompt, produce two outputs:

- **with-skill**: the skill is loaded and the prompt is run.
- **baseline**: for new skills, run with no skill at all; for skills you're improving, run the previous version.

Compare the pairs. The comparison can be qualitative (read both, judge) or quantitative (assertions per test case, computed pass rate, time, tokens).

#### How to actually run the pairs depends on capability

- **If subagents are available**: spawn all with-skill and all baseline runs in the same turn so they finish together. Save outputs to a workspace directory organized by iteration and test ID.
- **If subagents are not available**: run sequentially, one prompt at a time, in the same conversation. You'll be running the skill yourself rather than handing it to an isolated agent — note that this is a weaker test (you have full context the skill is supposed to convey on its own), but it still catches the obvious failures.

#### How to present results for human review

- **If a browser and a viewer tool are available**: open the viewer with both qualitative outputs and the benchmark, ask the user to walk through and leave feedback per test case.
- **If they aren't**: present each test case inline in the conversation — prompt, output, and a one-line diff vs baseline. Ask the user "anything you'd change?" after each.

#### Two things that should not be skipped regardless of mode

1. **Pair the runs.** A with-skill output without a baseline output tells you nothing about whether the skill helped.
2. **Get raw outputs in front of the human before forming your own opinion.** Your judgment is contaminated by having written the skill. Theirs isn't.

If the runtime ships bundled scripts to accelerate this (an aggregator, a viewer generator, a grader subagent prompt), use them — they exist precisely to remove busywork. If it doesn't, the methodology above is the same; you just do the busywork yourself.

---

## Stage 8 — Iterate

After the user reviews and gives feedback, improve the skill. The temptation is to patch each complaint locally. Resist it.

Four lenses, in order:

1. **Generalize from the feedback.** The user is critiquing 3 examples; the skill will face thousands. If the fix is "for this specific case do X", the fix is wrong. Ask what general principle, if applied, would have caught this case and similar ones.

2. **Keep the prompt lean.** Read the transcripts (not just the outputs) and look for time the model spent on dead-ends caused by the skill itself. Cut those parts and rerun.

3. **Look for repeated work across test cases.** If all three runs independently wrote a `parse_csv.py`, that work belongs in `scripts/` — and a prose description of what it does belongs in the body so script-less agents can reproduce it.

4. **Reframe instead of constraining.** If a stubborn issue keeps recurring, don't add another MUST. Try a different metaphor or organizing principle. It's cheap and often unblocks things rigid rules can't.

Stop conditions: the user says they're happy; feedback is empty for an iteration; marginal improvement is shrinking.

---

## Stage 9 — Description optimization

Once the body is stable, the bottleneck moves to the description. The mechanism is the same regardless of capability — only the automation differs.

### The methodology

1. Generate ~20 trigger eval queries — roughly half should-trigger, half should-not-trigger. Negatives must be near-misses (queries that share keywords with the skill but actually need something else), not random irrelevance.
2. Show them to the user for review. Bad eval queries produce bad descriptions.
3. For each candidate description, evaluate it against the eval set: would the skill be invoked given this description and this query? Run each query multiple times to average out non-determinism.
4. Score on a held-out test split, not the training queries — to avoid overfitting the description to the eval set.
5. Iterate: propose a revised description that addresses the failures, rescore, keep the best by held-out score.

### How to actually do it

- **If automated agent invocation is available** (e.g., `claude -p`, an SDK call, or a runtime that lets you fire prompts programmatically): run a tight loop — score → propose revision → rescore — over 3-5 iterations. Bundled scripts that ship with the runtime are doing exactly this.
- **If it isn't**: do a small manual pass. Pick 6 should-trigger and 6 should-not-trigger queries. For each, ask yourself (or the user) honestly: would the current description cause this skill to fire here? Note the misses, propose one description revision that addresses them, repeat once or twice.

### Two cautions

- Don't optimize the description before the body is stable. A description tuned to a buggy body locks the bugs in.
- Should-not-trigger queries are the hard part. "Write a fibonacci function" as a negative for a PDF skill tests nothing. The negatives must be queries a naive keyword match would catch.

---

## Stage 10 — Package and ship

Output is a directory with `SKILL.md` (required) and any optional `scripts/`, `references/`, `assets/`.

If your runtime offers packaging (e.g., zipping into a `.skill` archive and presenting it to the user), use it. If not, hand the user the directory path and tell them what to do — most agent ecosystems install skills by dropping a folder into a known location.

If updating an existing skill rather than creating a new one: preserve the original directory name and `name` frontmatter. Stage edits in a writable location if the installed copy is read-only.

---

## Communicating with the user

Skill creators get used by people from "I run a hardware store and Claude is the first time I've opened a terminal" to "I've shipped MCP servers". Read context cues:

- "evaluation" / "benchmark" — usually fine
- "JSON" / "assertion" / "subagent" — explain on first use unless the user has signaled fluency
- "frontmatter" / "YAML" — explain unless they've shown they read SKILL.md files

When in doubt, define the term in five words and move on. Don't gatekeep, don't condescend.

---

## References

The body deliberately stays at the methodology level. If your runtime ships this skill with bundled accelerators, look in `references/` and `scripts/` for the operational detail. Typical contents:

- `references/eval-pipeline.md` — workspace layout, viewer mechanics, file schemas, environment differences for full-mode testing
- `references/description-optimization.md` — automated optimization loop details
- `references/schemas.md` — JSON shapes for evals, grading, benchmarks
- `agents/grader.md`, `agents/comparator.md`, `agents/analyzer.md` — instructions for specialized subagents, when subagents are available
- `scripts/` — Python accelerators for aggregation, viewer generation, packaging, description optimization

None of these are required for the skill to function. They are time-savers for runtimes that can use them. Any agent that can read text and follow instructions can perform every stage of this skill manually.

---

## The core loop, one more time

1. Capture intent — existing workflow or new?
2. Choose topology — leaf, router, or composite?
3. Survey the ecosystem — what already covers this?
4. Write the description first.
5. Write the body, lean and reasoned, with capability assumptions declared.
6. Diagnose against anti-patterns.
7. Test (vibe or full), using whatever capability you have.
8. Iterate on principles, not symptoms.
9. Optimize the description once the body is stable.
10. Package and ship.
