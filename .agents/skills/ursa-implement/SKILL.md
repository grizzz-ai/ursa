---
name: ursa-implement
description: Execute one approved plan revision and leave a truthful implementation record for review.
---

## Purpose

Change repository files only within a current independently approved plan. Preserve enough evidence
for another actor to determine what changed, what was tested, and whether review may begin.

## Managed inputs

Use Git root; branch's tracked GitHub remote else sole GitHub remote; >1 ask before reads; never default to origin; github.com HTTPS/SSH; aliases BLOCK.
No GitHub remotes: BLOCK; ask Code URL; no remotes: tell user `git remote add origin <URL>`; other remotes: give `git remote add <unused-name> <URL>`; rerun.
Require `gh`, non-JSON `gh auth status --active --hostname github.com`, then `gh repo view owner/repo`.
gh fail: `gh api --hostname github.com meta`; if network fails, NEVER suggest login; ask scoped access/retry. Login only on meta PASS + confirmed auth failure.
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

1. Resolve the selected task root; read discovery, plan and governing plan audit with producer refs.
2. Require task-scoped READY discovery, exact READY plan and latest complete audit PASS.
   Any identity/revision/hash/base/binding mismatch returns BLOCKED; never choose substitutes.
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
