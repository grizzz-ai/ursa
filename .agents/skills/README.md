# Canonical skills

This directory is the single source for workflow skill bodies.

The workflow directories are:

- `discovery`
- `plan`
- `plan-audit`
- `implement`
- `code-audit`
- `handoff`

Phase A currently delivers `discovery`, `plan`, and `plan-audit`. The remaining three names stay
reserved for the next delivery phase; the repository does not claim a complete workflow yet.

Consumers copy a canonical skill directory into their repository's `.agents/skills` directory and
create a relative `.claude/skills/<name>` link to it. This avoids maintaining two skill bodies.
