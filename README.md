# AI Engineering Workflow

A vendor-neutral engineering workflow designed for use with Codex and Claude Code.

## Status

This repository is an incomplete scaffold. It contains the repository layout, license, and
repository-local installation contract. The six workflow skills and the worked example are planned
follow-up work and are not present yet.

## Planned workflow

The planned workflow uses six skills in sequence:

1. `discovery`
2. `plan`
3. `plan-audit`
4. `implement`
5. `code-audit`
6. `handoff`

Each skill will have one canonical body under `.agents/skills/<name>/SKILL.md`. Claude Code uses a
relative link under `.claude/skills/<name>` in the consuming repository, so both runtimes discover
the same physical file.

## Repository layout

```text
.agents/skills/       Canonical skill source
docs/installation.md  Install, update, validate, and remove recipes
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

- No production workflow skill exists in this scaffold.
- No end-to-end workflow or worked example is claimed.
- The compatibility evidence currently targets macOS with the runtime versions listed above.
- Windows compatibility has not been verified.

## License

Licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE).
