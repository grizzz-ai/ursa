---
name: ursa-code-audit
description: Independently review an implementation against its approved plan and exact repository diff.
---

## Purpose

Decide whether completed implementation bytes satisfy the bound plan without hidden scope, stale proof,
or self-review. This stage reads and appends evidence; it does not edit product files.

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

1. Read bound discovery, plan, governing plan audit and implementation with their saved refs.
2. Confirm identity, revisions, base and bindings; require COMPLETE implementation and latest plan PASS.
   Invalid producer pairs or a later REVISE/BLOCK return BLOCK; never locate nearby substitutes.
3. Compare auditor and implementer identities. Missing identity or self-review returns `BLOCK`; a new
   actor label does not make the implementation author independent.
4. Choose the next unused positive code-audit round and reserve `code-audit-<round>.md`. Earlier audit
   files remain immutable; later complete REVISE/BLOCK overrides PASS; never claim the older PASS governs.
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
