---
name: ursa-handoff
description: Preserve reviewed evidence and execute only separately authorized delivery actions.
---

## Purpose

Turn a current code-audit PASS into a reviewable operator handoff while keeping artifact disposition,
commit, push, and pull-request decisions explicit. This stage always stops before merge.

## Managed inputs

Use Git root; branch's tracked GitHub remote else sole GitHub remote; >1 ask before reads; never default to origin; github.com HTTPS/SSH; aliases BLOCK.
No GitHub remotes: BLOCK; ask Code URL; no remotes: tell user `git remote add origin <URL>`; other remotes: give `git remote add <unused-name> <URL>`; rerun.
Require `gh`, non-JSON `gh auth status --active --hostname github.com`, then `gh repo view owner/repo`.
gh fail: `gh api --hostname github.com meta`; if network fails, NEVER suggest login; ask scoped access/retry. Login only for missing auth (exit 4) or HTTP 401.
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

- An artifact disposition decision: `track`, `local`, or `pending`.
- Separate operator decisions for commit, push, and pull-request creation as each boundary is reached.

## Steps

1. Read discovery, plan, governing plan audit, implementation and code audit with saved refs.
   Confirm all identity/revision/hash/base/inventory bindings; require COMPLETE implementation.
2. Both governing audits must be latest complete PASS for their exact producer revision/hash.
   A later REVISE/BLOCK, self-review, stale binding or missing proof returns BLOCK.
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
12. Always stop before merge; PR/review/merge need separate authority, never inferred from earlier steps.

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
