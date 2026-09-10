---
name: plan-audit
description: Independently test a saved implementation plan against repository evidence and risk.
---

## Purpose

Decide whether a specific saved plan is safe to execute. This stage challenges requirements, scope,
evidence, verification, and recovery without editing the plan or product files.

## Inputs

- The `artifact_root`, expected plan revision, and expected plan hash.
- An auditor `actor_id` distinct from the planner recorded in `plan.md`.
- The user-owned Git repository and any optional issue reference recorded by discovery.

## Steps

1. Read `discovery.md` and `plan.md` from the supplied artifact root. Never derive a replacement root.
2. Recompute the plan hash with `git hash-object`. If it or the revision differs, return `BLOCK` for a
   stale review target and do not review a nearby version.
3. Compare the auditor identity with the planner identity. Missing identity or self-review returns
   `BLOCK`; changing a label does not convert the plan author into an independent reviewer.
4. Select the next unused positive audit round. Audit files are append-only and use the path
   `plan-audit-<round>.md`; never replace or renumber a completed round.
5. Re-read repository instructions, refresh Git state, and inspect the load-bearing paths cited by the
   plan. Verify evidence from repository bytes or command results rather than trusting plan prose.
6. When the plan depends on an available GitHub issue, use `gh` to compare its current requirements,
   relations, and competing work. Report unavailable optional context with its actual consequence.
7. Check that known facts and interpretations are separated, and every unresolved decision has an
   owner and execution gate. Confirm the intended branch is explicit and current state is not hidden.
8. Compare the proposed files and steps with the smallest coherent change. Reject copied parallel
   logic, unrelated cleanup, vague path ownership, or an unbounded implementation surface.
9. Test each acceptance condition against the planned evidence. Checks must fail when the behavior is
   wrong and must not claim runtime, external, or deployed proof from source inspection alone.
10. Examine risks, dependency order, authorization boundaries, and rollback. A missing recovery path
    is blocking when the change can affect persistent or external state.
11. Choose exactly one verdict: `PASS` when no material gap remains; `REVISE` for correctable plan
    defects; `BLOCK` when safe execution cannot proceed or independent review is invalid.
12. Write the new audit file with fields: `task_key`, `artifact_root`, `actor_id`, `audit_round`,
    `plan_revision`, `plan_hash`, `verdict`, and `status: complete`.
13. Add Findings, Evidence checked, Required revisions or execution gate, Recipient, and Effect. A
    verdict without a concrete recipient and effect is incomplete and cannot govern the workflow.
14. Hash the saved audit with `git hash-object` and report its path, round, verdict, and hash.

## Output

- `PASS`: the implementer receives the bound plan revision/hash and latest complete audit round.
- `REVISE`: the planner receives actionable findings and must create a new `plan.md` revision; this
  audit remains unchanged, and implementation does not start.
- `BLOCK`: the operator receives the blocking reason. No implementation is permitted.

## Stop conditions

- The review target is missing, stale, internally inconsistent, or belongs to another task.
- Auditor identity is missing or matches the planner identity.
- Repository evidence needed for a safety decision cannot be inspected.
- Writing the verdict would require editing the plan, product, or an earlier audit round.

## Next stage

Route `PASS` to an implementer with the exact bound references. Route `REVISE` to the planner and require
a later audit round for the new plan hash. Route `BLOCK` to the operator. The latest complete round for
the current plan revision/hash governs; an older PASS never authorizes a changed plan.
