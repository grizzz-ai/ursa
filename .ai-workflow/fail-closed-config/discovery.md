task_key: fail-closed-config
artifact_root: .ai-workflow/fail-closed-config
actor_id: workflow-discoverer
revision: 1
intent_hash: 26b6a8d7ba0c6184d26d3565d45806708dc0d86c
repository_root: /private/tmp/ai-engineering-workflow-224
branch: feat/224-add-synthetic-typescript-workflow-example
base_ref: a3ec2004f5169450cc882abdab356564fbee534a
status: READY

# Discovery

## Instructions read

- `README.md`
- `.agents/skills/README.md`
- `.agents/skills/discovery/SKILL.md`

No repository-level `AGENTS.md` or `CLAUDE.md` exists at this revision.

## Repository evidence

- The working tree is a Git worktree on `feat/224-add-synthetic-typescript-workflow-example` at
  `a3ec2004f5169450cc882abdab356564fbee534a`.
- `git status --short` was empty before this artifact was created.
- The repository has one remote named `origin`; its default branch is `main`.
- The baseline commit adds only `package.json` and `examples/config-validation/`.
- `package.json` requires Node.js 22.18.0 or newer and runs one TypeScript test file with `node --test`.

## Relevant paths

- `examples/config-validation/src/config.ts` owns `AppConfig`, validation, and `parseConfig`.
- `examples/config-validation/test/config.test.ts` contains valid-input, observed-fallback, and desired
  fail-closed tests.
- `examples/config-validation/README.md` documents the observed baseline and proof limits.
- `.agents/skills/` contains the six-stage workflow used for this change.

## Command evidence

- The selected fallback test exits 0 with one passing test and asserts
  `{ "mode": "safe", "retryLimit": 3 }` for malformed input.
- The selected fail-closed expectation exits 1 with one failing test and `Missing expected exception`.
- The selected valid-input test exits 0 with one passing test.
- The full baseline suite runs three tests: two pass and one fails.

## Confirmed facts

- `parseConfig` validates the input with `isAppConfig`.
- When validation fails, it returns a copy of `DEFAULT_CONFIG` instead of rejecting the input.
- A valid configuration is returned unchanged.
- The example uses only erasable TypeScript syntax supported by the declared Node runtime.
- There are no dependencies, generated files, external services, secrets, databases, or network calls.

## Constraints

- Preserve valid `safe` and `fast` modes and non-negative integer retry limits.
- Reject every unsupported shape synchronously with a stable, non-sensitive error prefix.
- Keep the example dependency-free and deterministic.
- Track all workflow artifacts so each later stage can recompute the previous stage's identity.
- Keep the repository private during this workflow and make no production-readiness claim.

## Interpretations

- The smallest behavior change is to replace the invalid-input return in `parseConfig` with a
  `TypeError`; `isAppConfig` remains the single validation owner.
- The regression suite should name invalid classes separately so one failure cannot hide another.

## Gaps

None. The baseline behavior, intended correction, runtime, paths, and verification surface are all
observable in this repository.

## Planning input

Plan a correction limited to the parser, its tests, the example README, the root example link, and the
required workflow artifacts. Bind all stages to this baseline commit and preserve it in final history.
