---
name: ursa-code-audit
description: Independently review an implementation against its approved plan and exact repository diff.
---

## Purpose

Decide whether completed implementation bytes satisfy the bound plan without hidden scope, stale proof,
or self-review. This stage reads and appends evidence; it does not edit product files.

## Inputs

- The fixed `artifact_root`, plan revision/hash, and implementation revision/hash.
- A code-auditor `actor_id` distinct from the implementer recorded in `implementation.md`.
- The user-owned repository, planned base reference, changed inventory, and recorded check results.

## Steps

1. Read the bound `plan.md`, governing plan audit, and `implementation.md` from the supplied root.
2. Recompute their hashes with `git hash-object`. Return `BLOCK` when identity, revision, binding,
   base reference, or `COMPLETE` implementation status differs from the supplied values.
3. Compare auditor and implementer identities. Missing identity or self-review returns `BLOCK`; a new
   actor label does not make the implementation author independent.
4. Choose the next unused positive code-audit round and reserve `code-audit-<round>.md`. Earlier audit
   files remain immutable, including rounds whose findings were later fixed.
5. Re-read repository instructions and resolve the recorded base commit. Inspect current `git status`
   plus the complete diff from that base; never review only a selected patch supplied in prose.
6. Compare every changed path and behavior with plan scope, decisions, sequencing, and exclusions.
   Classify missing, extra, generated, and pre-existing paths explicitly.
7. Read the changed files in context. Check correctness, failure handling, maintainability, dependency
   limits, security boundaries, and whether public claims match evidence.
8. Re-run checks needed to evaluate acceptance. Confirm a reported pass has a falsifiable assertion and
   does not substitute static inspection for runtime or external proof promised by the plan.
9. Challenge implementation drift and recovery. Scope-changing drift requires `REVISE` unless the plan
   was revised and independently approved before these bytes were produced.
10. Choose exactly one verdict: `PASS` when no material issue remains, `REVISE` for correctable defects,
    or `BLOCK` when safe review cannot complete or independence is invalid.
11. Write the new `code-audit-<round>.md` audit with fields: `task_key`, `artifact_root`, `actor_id`, `audit_round`,
    `plan_revision`, `plan_hash`, `implementation_revision`, `implementation_hash`, `base_ref`,
    `verdict`, and `status: complete`.
12. Add Findings, Evidence checked, Diff inventory, Required revisions or gate, Recipient, and Effect.
    Hash the saved audit and report its path, round, verdict, hash, and reviewed repository state.

## Output

- `PASS`: the handoff agent receives the bound audit round/hash and exact reviewed inventory.
- `REVISE`: the implementer receives actionable findings and must write a new implementation revision;
  this audit stays unchanged and a later round must review the resulting bytes.
- `BLOCK`: the operator receives the independence, access, identity, or evidence failure; handoff stops.

## Stop conditions

- Any supplied artifact is missing, stale, cross-task, internally inconsistent, or not hash-bound.
- Auditor identity is absent or matches the implementer.
- The base commit or complete working diff cannot be inspected, or required evidence is unavailable.
- Writing the verdict would require editing product bytes or an earlier audit record.

## Next stage

Route `PASS` to handoff with exact artifact hashes and reviewed Git inventory. Route `REVISE` to the
implementer and require a later audit round. Route `BLOCK` to the operator; no commit, push, PR, merge,
deploy, or publication action follows from any non-PASS result.
