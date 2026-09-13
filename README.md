# AI Engineering Workflow

A vendor-neutral engineering workflow designed for use with Codex and Claude Code.

Developed by [Grizzz AI](https://github.com/grizzz-ai).

## Status

The six workflow skills and one worked example are present as a private publication candidate.
Repository-local discovery has been verified with Codex `0.153.4` and Claude Code `2.1.2`, where skills appear as direct commands.
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
- GitHub access to clone this repository while it remains private
- A user-owned Git repository where the skills will be installed
- Codex `0.153.4`, the compatibility-tested version
- Claude Code `2.1.2`, the compatibility-tested version

## Quickstart

Clone the workflow once, outside the repositories where you write code:

```sh
mkdir -p "$HOME/.local/share"
cd "$HOME/.local/share"
git clone https://github.com/grizzz-ai/ai-engineering-workflow.git
```

Open an existing Git repository in VS Code, use its integrated terminal, and install the workflow into
the repository you opened:

```sh
cd /path/to/your-project
"$HOME/.local/share/ai-engineering-workflow/install.sh"
```

You can instead select another repository explicitly:

```sh
"$HOME/.local/share/ai-engineering-workflow/install.sh" --target /path/to/your-project
```

The installer copies all six canonical skill files into the selected repository, creates local Claude
Code links to those copies, records their source commit and blob hashes, and validates the result. It
does not change project code, `AGENTS.md`, `CLAUDE.md`, Git configuration, or global agent settings.

GitHub, Codex, and Claude Code authenticate separately. GitHub authentication only grants access to
clone repositories. Sign in to Codex and Claude Code through each product's own supported sign-in flow;
the installer never reads or stores model credentials.

After signing in, open the target repository in VS Code and start with:

> Use the discovery skill to inspect this repository and identify the best next engineering task.

Run the read-only check at any time from the target repository:

```sh
"$HOME/.local/share/ai-engineering-workflow/install.sh" --check
```

See [Installation](docs/installation.md) for the installed layout, validation behavior, and guarded
per-skill update and removal recipes.

## Limitations

- The worked example demonstrates a narrow repository-local correction, not production readiness.
- Commit, push, pull-request creation, merge, deployment, and publication require separate decisions.
- The compatibility evidence currently targets macOS with the runtime versions listed above.
- Windows compatibility has not been verified.

## Support

Use [GitHub Issues](https://github.com/grizzz-ai/ai-engineering-workflow/issues) for installation problems, documentation errors, and reproducible compatibility reports.

## License

Licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE).
