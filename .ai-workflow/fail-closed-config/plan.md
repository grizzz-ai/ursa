task_key: fail-closed-config
artifact_root: .ai-workflow/fail-closed-config
actor_id: workflow-planner
revision: 7
discovery_revision: 1
discovery_hash: 3ec2a47ce91d229e0f9b14c97aab52e3bbd3702f
base_ref: a3ec2004f5169450cc882abdab356564fbee534a
status: READY

# Plan

## Goal

Make invalid synthetic configuration fail closed while preserving the two valid modes and non-negative
integer retry limits. Completion requires six deterministic tests, reproducible baseline instructions,
accurate proof limits, and hash-bound workflow evidence.

## Current facts

- Baseline `a3ec2004f5169450cc882abdab356564fbee534a` returns a copy of
  `{ "mode": "safe", "retryLimit": 3 }` whenever `isAppConfig` rejects input.
- The exact-default test passes, the desired fail-closed test fails with `Missing expected exception`,
  and the valid-input test passes.
- `isAppConfig` already owns all structural checks; `parseConfig` owns the fallback decision.
- The repository has no dependencies, compiler step, CI, service, secret, or external side effect.
- Node.js 22.18.0 or newer supplies the declared TypeScript execution and test surface.

## Scope

Change only:

- `examples/config-validation/src/config.ts`
- `examples/config-validation/test/config.test.ts`
- `examples/config-validation/README.md`
- `README.md`
- required files under `.ai-workflow/fail-closed-config/`

Keep package metadata, the six skill definitions, installation docs, license, notice, adapter layout,
and every external integration unchanged.

## Decisions

- Keep `isAppConfig` as the only structural validator.
- Remove `DEFAULT_CONFIG` and replace the invalid branch in `parseConfig` with
  `TypeError("Invalid configuration: expected mode safe|fast and retryLimit as a non-negative integer")`.
- Do not include the rejected value in the error.
- Preserve the exact valid object rather than normalizing, cloning, or applying defaults.
- Replace the baseline-only fallback test with a non-object rejection test.
- Cover five invalid classes: non-object, missing field, unsupported mode, fractional retry limit, and
  negative retry limit. Together with valid input, the final suite contains six tests.
- Track workflow artifacts. Use semantic role identities and separate contexts for both auditors.
- Document Node type stripping as execution without type checking or full compiler support.
- Preserve the exact baseline commit with a merge commit; squash and rebase delivery are invalid.

## Steps

1. Require an independent plan-audit PASS bound to this file's revision and hash.
2. In `config.ts`, remove the `DEFAULT_CONFIG` declaration and replace the silent fallback return with
   the decided `TypeError`; leave `isAppConfig` and the valid return unchanged.
3. In `config.test.ts`, keep the valid test, replace the fallback-observation test with non-object
   rejection, and add four tests for the remaining invalid classes. Use readable Arrange, Act, Assert
   phases and stable error-prefix matching.
4. Update the example README with the full baseline SHA, detached-checkout reproduction, final command,
   expected outcomes, restoration command, and proof limitations.
5. Update root README with one relative link to the worked example and keep private/public status claims
   unchanged.
6. Run the two focused final tests, the full six-test suite, `git diff --check`, the exact inventory,
   source-absence, link, and authorship checks below. Record commands, exits, and counts.
7. Write `implementation.md` with the actual diff and evidence, then obtain a separate code-audit verdict.
8. On code-audit PASS, write `handoff.md` with `track` disposition and stop at the local commit boundary.

## Verification

- Baseline commit:
  - exact-default selected test: exit 0, tests 1, pass 1, fail 0;
  - desired rejection selected test: exit 1, tests 1, pass 0, fail 1, missing exception;
  - valid selected test: exit 0, tests 1, pass 1, fail 0.
- Corrected worktree:
  - `npm test`: exit 0, tests 6, pass 6, fail 0, skipped 0;
  - runtime probe with `null`: nonzero and stable `Invalid configuration:` prefix;
  - runtime probe with `{ "mode": "fast", "retryLimit": 7 }`: exact object returned.
- Require `! rg -qF 'DEFAULT_CONFIG' examples/config-validation/src/config.ts` to exit 0.
- Recompute every workflow hash and revision binding. Latest plan and code audits must be PASS and use
  contexts distinct from their reviewed actors.
- Build `actual` with
  `{ git diff --name-only a3ec2004f5169450cc882abdab356564fbee534a^; git ls-files --others --exclude-standard; } | LC_ALL=C sort -u`.
  Take `plan_audit_round` from the supplied audit input only after recomputing that audit's hash,
  confirming its PASS verdict, and confirming its binding to this plan revision and hash. Build
  `expected` from the sorted list of `README.md`, `package.json`, the three example files,
  `discovery.md`, `plan.md`, and `implementation.md`, then use an arithmetic `while` loop to add every
  contiguous `plan-audit-<n>.md` from 1 through that verified governing round. Compare `actual` and `expected`
  byte-for-byte and require exit 0 before code audit; later code-audit and handoff artifacts extend the
  expected list at their owning stages.
- Run `git diff --check` and require exit 0. Run
  `rg -qF '[Fail-Closed Configuration Example](examples/config-validation/README.md)' README.md && test -f examples/config-validation/README.md`
  and require exit 0.
- Derive `product_actual` from `actual` by excluding `.ai-workflow/`; require it to equal the five
  expected product paths (`README.md`, `package.json`, and the three example files). Run
  `git diff -U0 a3ec2004f5169450cc882abdab356564fbee534a^ -- $product_actual`, retain only added lines while
  excluding diff headers, and count case-insensitive matches for
  `SPDX|copyright|vendored|third-party|adapted from` without printing them. Require zero new matching
  lines. Existing unchanged notices do not fail this added-content check; a new match blocks handoff
  for inspection rather than being accepted by exception.
- The implementation and code audit use the current worktree and must not claim committed-clone proof.
  The restricted-identifier check is not an implementation completion condition. After an authorized
  handoff commit, the delivery operator runs the repository-external publication gate over every changed
  text path and repeats the matrix from a clean checkout of that exact commit before any push. The gate
  must return exit 0 and zero restricted matches; only its exit and aggregate count enter delivery
  evidence, while its patterns and raw matches remain outside this repository. Missing or failing
  operator evidence blocks push and routes to a new implementation revision, code-audit round, and
  handoff revision.

## Risks

- A broad rewrite could duplicate validation or change valid behavior. Keep the change at the existing
  invalid branch and assert exact valid output.
- A test could fail because Node cannot execute its syntax. The valid focused test distinguishes runtime
  setup from the expected baseline failure.
- Documentation could claim full TypeScript or production support. State the narrow runtime and proof
  limits explicitly.
- Workflow prose could expose private context. Downstream stages receive only saved artifact inputs and
  all changed text passes disclosure validation.
- Squash or rebase would replace the baseline SHA. Delivery must use a merge commit and verify ancestry.

## Recovery

- Before the final commit, restore only the four product files from the baseline when abandoning the
  correction. Preserve discovery, every plan revision, and all completed audit rounds; record the
  abandoned or revised outcome in a new owning-stage artifact rather than deleting history.
- A plan or code audit REVISE remains immutable; write a new owning-stage revision and later audit round.
- A failed committed check requires corrective bytes, a new implementation revision, another code audit,
  and another handoff revision before delivery.
- Before push, abandon the local branch without affecting the default branch.

## Dependencies

- Node.js 22.18.0 or newer and Git are the only runtime tools.
- No npm download, model credential, secret, cloud resource, database, or network access is required.
- Commit, push, pull request, merge, and visibility remain separate operator gates.

## Missing facts

None. The baseline, validation owner, error contract, file scope, test cases, runtime, and recovery are
all fixed and observable.

## Handoff

Recipient: `independent-plan-reviewer` in a context distinct from `workflow-planner`.

Effect: PASS authorizes `workflow-implementer` to execute this exact revision. REVISE returns to the
planner for a new plan revision. BLOCK returns to the operator and stops product editing.
