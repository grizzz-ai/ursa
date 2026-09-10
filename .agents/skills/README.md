# Canonical skills

This directory is the single source for workflow skill bodies.

The workflow directories are:

- `discovery`
- `plan`
- `plan-audit`
- `implement`
- `code-audit`
- `handoff`

All six canonical skill bodies are present. They form one ordered workflow; audit roles must use an
actor identity distinct from the producer they review.

Consumers copy a canonical skill directory into their repository's `.agents/skills` directory and
create a relative `.claude/skills/<name>` link to it. This avoids maintaining two skill bodies.

The workflow persists evidence under `.ai-workflow/<task-key>/`. Commit, push, pull-request creation,
merge, deployment, and publication remain separate operator decisions.
