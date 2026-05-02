# Contributing

Thank you for improving this starter pack.

This repository is a method and template collection, not a hosted product. Good contributions make the first run clearer, safer, and easier to adapt.

## Good First Contributions

- Fix confusing language in `README.md`, `QUICKSTART.md`, or `ONBOARDING.md`.
- Add a small example under `examples/`.
- Improve a project template in `meta/templates/`.
- Add a compatibility note for a tool you actually tested.
- Improve validation scripts without adding external services.
- Report where the first 10 minutes were unclear.

## Before You Open A Pull Request

1. Keep the starter pack generic. Do not include private paths, company names, tokens, customer data, or personal operating details.
2. Keep examples minimal and reusable.
3. Link every important new Markdown file from a nearby `README.md`.
4. Run:

   ```bash
   python3 scripts/check_links.py
   python3 scripts/check_forbidden_markers.py
   python3 scripts/inventory.py
   ```

5. Update `CHANGELOG.md` when the change affects public use.

## Contribution Types

### Documentation Fix

Use this for wording, structure, examples, and quickstart improvements.

### Method Change

Use this for changes to rules, routing, lifecycle, project structure, or skills. Please explain:

- what problem the current method causes;
- what behavior changes;
- which files or templates are affected;
- how a new user can verify the change.

### Tool Compatibility Note

Compatibility notes should be based on an actual run. Include:

- tool name and version if available;
- operating system if relevant;
- exact first prompt used;
- what worked;
- what failed or required adjustment.

## Pull Request Standard

A pull request should include:

- short summary;
- changed files;
- validation commands run;
- any known gaps.

Large methodological rewrites are easier to review if they start as an issue or discussion first.
