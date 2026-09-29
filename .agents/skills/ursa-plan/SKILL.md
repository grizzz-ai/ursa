---
name: ursa-plan
description: Convert verified discovery evidence into a bounded and testable implementation plan.
---

## Purpose

Define the smallest safe change before product editing begins. The plan must make scope, decisions,
risks, verification, and recovery understandable to an independent reviewer.

## Managed inputs

Use Git root and active branch tracking GitHub remote; otherwise require one GitHub remote; >1 asks user before reads, not origin or other branch.
No remotes: BLOCK with repo Code URL and `git remote add origin <URL>` then rerun; accept github.com HTTPS/scp/ssh URLs; unresolved aliases BLOCK.
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

1. Require a chosen intent. If only an overview exists, ask for a task; obtain fresh task discovery.
2. Resolve only that intent's root; read `discovery.md` and its producer ref. Require mode `task`
   and status `READY`; preserve root/key/intent/repo/revision/hash checks, never reconstruct a root.
3. Re-read instructions and refresh branch, HEAD, dirty status and relevant paths; record all drift.
4. Refresh relevant GitHub requirements, relations and competing work with explicit repo binding.
   Read failures block readiness; the user's task supplies intent, not substitute repository evidence.
5. State the goal in observable terms and explain why the change belongs in the identified paths.
6. List in-scope files or components and explicit exclusions. Name the intended working branch.
7. Record every decision that changes behavior, contracts, authorization, sequencing, or verification.
   If such a choice lacks an owner or answer, produce a blocked plan rather than guessing.
8. Describe the current flow using inspected paths and references, then define the minimal change shape.
9. Give ordered implementation steps. Each step must name its target and the evidence it should leave.
10. Define realistic checks before implementation: local tests, integration behavior, external effects,
    and clear rule-outs for layers that do not apply. A passing command must have a falsifiable meaning.
11. Record concrete failure modes, recovery or rollback, dependencies, and authorization boundaries.
12. Set `revision` to one greater than the current `plan.md` revision, or `1` when no plan exists.
13. Write `plan.md` with fields: `task_key`, `artifact_root`, `actor_id`, `revision`,
    `discovery_revision`, `discovery_hash`, `base_ref`, and `status`.
14. Include sections named Goal, Current facts, Scope, Decisions, Steps, Verification, Risks, Recovery,
    Dependencies, Missing facts, and Handoff. Do not edit product files while planning.
15. Hash the saved plan with `git hash-object <artifact_root>/plan.md` and report the revision and hash.

## Output

- `READY`: a complete `plan.md` plus its revision/hash for a distinct plan auditor. No implementation
  permission is implied by producing a plan.
- `BLOCK`: a saved plan identifying each unresolved fact or decision, its owner, and the exact execution
  gate. Recipient: operator. Audit and implementation stop until the planner writes a new revision.

## Stop conditions

- Discovery identity, revision, hash, repository, or status is stale or inconsistent.
- A load-bearing choice, dependency, acceptance condition, or verification path remains unknown.
- The requested change conflicts with repository instructions or cannot be recovered safely.
- Planning would require product edits, external mutations, or unsupported claims.

## Next stage

On READY, a separate reviewing session resolves the saved plan/ref and discovery/ref for this task.
On BLOCK, return the recorded decision to its named owner; wait for a fresh producer revision,
never infer missing evidence from chat. Keep technical references in the background.
