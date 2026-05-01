# Release and Rollback Policy

Related index: [LLM Rules](.../../meta/LLM_RULES.md).

Pre-release requirements:
1. CHECKLIST complete
2. CHANGELOG updated
3. Test gates green
4. Safe rollback point identified

Rollback ladder:
1. Feature flag / config toggle off
2. git revert
3. redeploy previous stable tag

Never release high-risk changes without explicit owner decision.
