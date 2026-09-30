---
name: ursa-plan-audit
description: Independently test a saved implementation plan against repository evidence and risk.
---

## Purpose

Decide whether a specific saved plan is safe to execute. This stage challenges requirements, scope,
evidence, verification, and recovery without editing the plan or product files.

## Managed inputs

Use Git root; branch's tracked GitHub remote else sole GitHub remote; >1 ask before reads; never default to origin; github.com HTTPS/SSH; aliases BLOCK.
No GitHub remotes: BLOCK; ask Code URL; no remotes: tell user `git remote add origin <URL>`; other remotes: give `git remote add <unused-name> <URL>`; rerun.
Require `gh`, non-JSON `gh auth status --active --hostname github.com`, then `gh repo view owner/repo`.
gh failure: probe `gh api --hostname github.com meta` here; network denial requests scoped access and retry; suggest login only for confirmed auth failure.
Match saved root/repo and any named issue before work reads. Use explicit `--repo`/scoped API.
Failed reads stop; never equate them with empty lists, read home SSH config, log in or alter remotes.
Assign one runtime session ID, else a POSIX session token; record its source and authored stages.
Keep it for this actor; model names, Git email and relabeling never establish an independent session.
Select a user-chosen task: explicit intent or one eligible record for this repo/stage, never mtime.
If absent/ambiguous, ask by task description; orientation is not task evidence. No user ID/hash input.
Read producer-saved `<artifact>.ref`: relative path, revision/round, bare Git blob OID. Recompute hashes;
check all task/root/repo/base/status/bindings. Missing/partial pairs stop; never manufacture refs.
Legacy records need fresh producer passes/audits. Changed branch/HEAD/relevant bytes need context
refresh; material drift invalidates approval. Preserve dirty work; ignore only this pass's outputs.
Refresh relevant GitHub facts with explicit binding; no token display or secret/global-skill reads.
Record extra fields: repository_root, github_repo, branch, checked_at, actor_source, session_authorship; hash fields are bare Git blob OIDs.
Save outputs before their refs; interruption/write failure prevents readiness; competing passes stop.
This is a procedural contract, not identity attestation, tamper proof, locking or transactions.

## Steps

1. Resolve the selected task root; read discovery, plan and their saved producer refs.
2. Require task-scoped READY discovery and the exact READY plan revision/hash; stale targets BLOCK.
   Never derive a replacement root or review a nearby version; validate the plan's discovery binding.
   A later complete REVISE/BLOCK overrides an earlier PASS; never claim an older PASS still governs.
3. Compare the auditor identity with the planner identity. Missing identity or self-review returns
   `BLOCK`; changing a label does not convert the plan author into an independent reviewer.
4. Select the next unused positive audit round. Audit files are append-only and use the path
   `plan-audit-<round>.md`; never replace or renumber a completed round.
5. Re-read repository instructions, refresh Git state, and inspect the load-bearing paths cited by the
   plan. Verify evidence from repository bytes or command results rather than trusting plan prose.
6. Refresh GitHub requirements, relations and competing work with explicit repository binding.
   Failed mandatory reads BLOCK; compare current requirements against the proposed plan.
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
