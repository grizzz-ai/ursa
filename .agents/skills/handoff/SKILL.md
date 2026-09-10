---
name: handoff
description: Preserve reviewed evidence and execute only separately authorized delivery actions.
---

## Purpose

Turn a current code-audit PASS into a reviewable operator handoff while keeping artifact disposition,
commit, push, and pull-request decisions explicit. This stage always stops before merge.

## Inputs

- The fixed `artifact_root`, plan and implementation revisions/hashes, and code-audit round/hash.
- A handoff `actor_id`, the user-owned repository, reviewed base ref, branch, inventory, and checks.
- An artifact disposition decision: `track`, `local`, or `pending`.
- Separate operator decisions for commit, push, and pull-request creation as each boundary is reached.

## Steps

1. Read the bound plan, implementation, and code-audit artifacts from the supplied root. Recompute
   hashes and confirm task identity, revisions, base ref, reviewed inventory, and audit `PASS` agree.
2. Find the latest complete code-audit round for the current implementation. A later `REVISE` or
   `BLOCK`, a stale binding, or missing evidence returns `BLOCK`.
3. Refresh repository instructions, branch, HEAD, status, and complete diff from the reviewed base.
   Any byte or path drift since audit returns `BLOCK` and routes back to implementation review.
4. Apply artifact disposition before delivery. `track` includes workflow artifacts in reviewed scope;
   `local` keeps them outside the commit; `pending` records the unresolved owner and returns `BLOCK`.
5. Create or revise `handoff.md` with fields: `task_key`, `artifact_root`, `actor_id`, `revision`,
   `plan_revision`, `plan_hash`, `implementation_revision`, `implementation_hash`, `code_audit_round`,
   `code_audit_hash`, `base_ref`, `disposition`, and `status`.
6. Record reviewed paths, checks, remaining risks, recovery, and the proposed next mutation. Hash the
   saved handoff, then recheck that saving it respected the chosen disposition and audit inventory.
7. At the commit boundary, accept exactly one decision: `authorized`, `declined`, or
   `not-yet-authorized`. The latter two perform no commit; an unresolved decision leaves status pending.
8. On authorized commit, stage only the reviewed inventory permitted by disposition, inspect the staged
   diff, create one repository-conforming commit, and record its exact SHA and resulting Git state.
9. Ask for a separate push decision bound to that commit SHA. Push only `authorized`; `declined` or
   `not-yet-authorized` leaves the remote unchanged and ends truthfully.
10. After an authorized push, ask separately whether to create a pull request for the pushed branch.
    Confirm the base branch, issue reference, title, and factual test evidence before using `gh`.
11. Read the created pull request back and record its URL, base, head, state, and linked issue. A failed
    or mismatched readback returns `BLOCK`; never claim a proposed command as delivery evidence.
12. Stop before merge in every outcome. PR creation, review readiness, and merge are different decisions;
    no earlier authorization implies a later one.

## Output

- `READY`: current reviewed evidence plus the exact completed mutation, SHA or PR URL, Git state,
  remaining risks, and the next decision for the operator.
- `BLOCK`: stale audit, diff drift, pending disposition, declined or missing authority, failed action,
  or mismatched readback, with the unchanged boundary stated. Recipient: operator.

## Stop conditions

- Artifact identity, hashes, latest audit verdict, base, branch, inventory, or repository bytes drift.
- Disposition is `pending`, or an action lacks its own explicit operator decision.
- Staging would include unreviewed files, push would target another SHA, or PR metadata is ambiguous.
- Any request would merge, deploy, publish, alter visibility, or infer authority from an earlier step.

## Next stage

After a verified PR exists, give the operator its URL, exact head SHA, checks, risks, and required review
gate. If no PR exists, report the last completed boundary and preserved state. Never merge; a later
review and explicit merge decision own that action.
