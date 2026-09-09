# Canonical skills

This directory is the single source for workflow skill bodies.

The planned directories are:

- `discovery`
- `plan`
- `plan-audit`
- `implement`
- `code-audit`
- `handoff`

Each completed directory will contain one `SKILL.md`. This scaffold intentionally contains none of
those files. A disposable `workflow-scaffold-probe-219` fixture may be created during private
compatibility testing, but it must never be committed.

Consumers copy a canonical skill directory into their repository's `.agents/skills` directory and
create a relative `.claude/skills/<name>` link to it. This avoids maintaining two skill bodies.
