---
id: <yyyy-mm-dd>-release-checklist
type: process
status: active
created: <YYYY-MM-DD>
updated: 2026-03-18
aliases:
  - "Шаблон RELEASE_CHECKLIST"
tags: [template, release, deployment, quality-gates]
source_path: "meta/templates/release_checklist.md"
knowledge_criticality: high
verification_status: unverified
verified_by_me: false
curation_mode: none
---

# RELEASE_CHECKLIST

Связанный индекс: [Индекс шаблонов](./README.md).

- [ ] Version selected (`vMAJOR.MINOR.PATCH`)
- [ ] All required checks green
- [ ] Changelog updated
- [ ] Smoke passed on release artifact
- [ ] Rollback target tag documented
- [ ] Monitoring signals confirmed
- [ ] Owner decision recorded (`Release` | `Hold` | `Rollback`)
- [ ] Tag created
- [ ] Post-release validation completed
