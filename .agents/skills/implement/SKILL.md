---
name: implement
description: Execute one approved plan revision and leave a truthful implementation record for review.
---

## Purpose

Change repository files only within a current independently approved plan. Preserve enough evidence
for another actor to determine what changed, what was tested, and whether review may begin.

## Inputs

- The task statement, fixed `artifact_root`, and implementer `actor_id`.
- Expected plan revision and hash plus the governing plan-audit round and hash.
- The user-owned repository and its planned base reference and working branch.

## Steps

1. Read `plan.md` and the supplied plan-audit file from the artifact root. Do not locate substitutes.
2. Recompute both hashes with `git hash-object`. Confirm their revisions, task key, artifact root, and
   binding fields match the supplied values; an inconsistency returns `BLOCKED`.
3. Confirm the audit actor differs from the plan actor and its verdict is `PASS`. Search later complete
   audit rounds for the same plan; a later `REVISE` or `BLOCK` governs and stops implementation.
4. Re-read repository instructions and refresh the branch, HEAD, status, and planned paths. Return
   `REPLAN` if repository changes invalidate scope, sequencing, recovery, or verification.
5. Record the base reference and pre-existing dirty paths. Never absorb unrelated changes into scope.
6. Apply the plan in its stated order using the repository's normal editing facilities. Keep shared
   logic in the planned owner and avoid opportunistic cleanup or unapproved dependencies.
7. When a needed change crosses the planned file or behavior boundary, stop editing and classify it as
   `REPLAN`; do not disguise scope growth as implementation detail.
8. Run every planned local check directly and preserve command, exit status, and concise outcome.
   Record skipped or unavailable evidence with its consequence instead of treating it as passing.
9. Inspect `git status` and the complete diff against the planned inventory. Separate pre-existing,
   intended, generated, and unexpected paths; unexpected paths prevent `COMPLETE`.
10. Set the implementation revision to one greater than the current `implementation.md`, or `1` when
    absent. Never overwrite an implementation record for a different task identity.
11. Write `implementation.md` with fields: `task_key`, `artifact_root`, `actor_id`, `revision`,
    `plan_revision`, `plan_hash`, `plan_audit_round`, `plan_audit_hash`, `base_ref`, and `status`.
12. Add Changes, Commands, Verification, Drift, Git state, Risks, and Handoff sections. Name the exact
    recipient and effect for the terminal state, then hash the saved file with `git hash-object`.

## Output

- `COMPLETE`: the code auditor receives the plan binding, implementation revision/hash, full changed
  inventory, checks, and known risks. This state does not authorize commit, push, PR, or merge.
- `REPLAN`: the planner receives the discovered scope or contract change; code audit does not begin.
- `PARTIAL` or `BLOCKED`: the operator receives completed work, missing proof, and the concrete gate;
  no audit or handoff proceeds until a later implementation revision resolves it.

## Stop conditions

- Plan or audit identity, hash, revision, verdict, actor separation, or base reference is stale.
- Current repository facts conflict with a load-bearing plan decision or recovery path.
- Execution needs an unplanned file, dependency, external mutation, secret, or destructive action.
- A required check fails, cannot run, or exposes unexplained changes outside the approved inventory.

## Next stage

On `COMPLETE`, provide a distinct code auditor only the artifact root, bound plan and implementation
references, base ref, changed inventory, and check results. On any other state, route to the named
recipient and wait for a new governing artifact rather than continuing from conversation context.
