# Gate Policy

Related index: [LLM Rules](.../../meta/LLM_RULES.md).

Required gates before GREEN:
1. Code gate: lint/type/static/security checks (when configured)
2. Test gate: unit + integration
3. Smoke gate: project smoke checks

Status mapping:
- GREEN: all required gates PASS
- YELLOW: no FAIL, but INCOMPLETE checks or accepted residual risk
- RED: any required gate FAIL
