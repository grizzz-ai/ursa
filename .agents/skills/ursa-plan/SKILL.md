---
name: ursa-plan
description: Convert verified discovery evidence into a bounded and testable implementation plan.
---

## Purpose

Define the smallest safe change before product editing begins. The plan must make scope, decisions,
risks, verification, and recovery understandable to an independent reviewer.

## Inputs

- The task statement and an `actor_id` for the planner.
- The `artifact_root` assigned by discovery.
- The expected discovery revision and `git hash-object` value.
- The same user-owned Git repository inspected during discovery.

## Steps

1. Read `discovery.md` from the supplied artifact root. Do not search for or reconstruct another root.
2. Recompute its hash with `git hash-object`. Return `BLOCK` if the revision, hash, task key, intent,
   repository root, or `READY` status does not match the supplied inputs.
3. Re-read applicable repository instructions and refresh branch, HEAD, status, and relevant files.
   Record any difference from discovery instead of silently relying on stale facts.
4. When discovery cites a GitHub issue and `gh` is available, refresh the requirements and relations.
   The text task remains sufficient; optional GitHub failure cannot erase repository evidence.
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
13. Write `plan.md` with exact fields: `task_key`, `artifact_root`, `actor_id`, `revision`,
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

On `READY`, provide the plan auditor with `artifact_root`, plan revision/hash, discovery reference, and
the auditor's own distinct `actor_id`. On `BLOCK`, return the recorded decision to its named owner; do
not ask an auditor or implementer to infer the answer from chat.
