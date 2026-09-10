# AI Engineering Workflow

A vendor-neutral engineering workflow designed for use with Codex and Claude Code.

## Status

The six workflow skills and one worked example are present as a private publication candidate.
Clean-room publication review and public launch remain follow-up work.

## Workflow

The workflow uses six skills in sequence:

1. `discovery`
2. `plan`
3. `plan-audit`
4. `implement`
5. `code-audit`
6. `handoff`

Each skill has one canonical body under `.agents/skills/<name>/SKILL.md`. Claude Code uses a
relative link under `.claude/skills/<name>` in the consuming repository, so both runtimes discover
the same physical file.

Each task keeps durable evidence under `.ai-workflow/<task-key>/`. Producer artifacts use revisions
and hashes; plan and code audits are append-only independent gates. The handoff records whether those
artifacts are tracked, local, or pending and stops before merge.

See the [Fail-Closed Configuration Example](examples/config-validation/README.md) for a synthetic
TypeScript change carried through this file-based workflow.

## Repository layout

```text
.agents/skills/       Canonical skill source
docs/installation.md  Install, update, validate, and remove recipes
examples/              Synthetic worked examples
LICENSE               Apache License 2.0
NOTICE                Copyright notice
```

## Requirements

- Git
- GitHub CLI (`gh`) authenticated for private-repository access
- A user-owned Git repository where the skills will be installed
- Codex `0.153.4`, the compatibility-tested version
- Claude Code `2.1.2`, the pinned version whose local-menu verification is still pending

See [Installation](docs/installation.md) for the repository-local adapter recipes.

## Limitations

- The worked example demonstrates a narrow repository-local correction, not production readiness.
- Commit, push, pull-request creation, merge, deployment, and publication require separate decisions.
- The compatibility evidence currently targets macOS with the runtime versions listed above.
- Windows compatibility has not been verified.

## License

Licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE).
