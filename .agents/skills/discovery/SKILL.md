---
name: discovery
description: Restore repository facts and create the durable starting point for an engineering task.
---

## Purpose

Turn a task statement into verified repository context that another agent can use without receiving
the earlier conversation. This stage observes and records; it does not edit product files.

## Inputs

- A concrete task statement.
- An `actor_id` that identifies this workflow participant.
- An optional GitHub issue URL for additional facts.
- The user-owned Git repository that contains the work.

## Steps

1. Confirm the current directory belongs to a Git work tree. If it does not, stop with `BLOCK`.
2. Read repository instruction files that govern the root and likely changed paths. Record their names.
3. Inspect the current branch, HEAD commit, working-tree status, recent history, and configured remotes.
4. When an issue URL is supplied and `gh` is available, read its body, state, relations, and relevant
   pull requests. Treat unavailable optional GitHub context as a named gap, never as confirmed fact.
5. Search the repository for files, symbols, tests, documentation, and prior changes related to the
   requested behavior. Cite concrete paths and Git references for every load-bearing conclusion.
6. Separate confirmed facts from interpretations and unresolved questions. Do not invent missing state.
7. Derive a short lowercase `task_key` using letters, digits, and hyphens. Keep one key for the entire
   workflow; later stages must receive it rather than derive another.
8. Set `artifact_root` to `.ai-workflow/<task_key>/`. Hash the normalized task statement with
   `git hash-object --stdin` and use that value as `intent_hash`.
9. If the artifact root already contains `discovery.md`, compare its task key and intent hash. Continue
   only when both match. A different or incomplete identity is a collision and returns `BLOCK`.
10. Create the artifact root through the agent runtime's repository file operations. Never change
    `.gitignore` automatically and never overwrite artifacts belonging to another intent.
11. Write `discovery.md` with these exact fields: `task_key`, `artifact_root`, `actor_id`, `revision`,
    `intent_hash`, `repository_root`, `branch`, `base_ref`, and `status`.
12. Below the fields, record instructions read, relevant paths, command evidence, constraints, dirty
    state, related work, confirmed facts, interpretations, gaps, and the recommended planning input.
13. Hash the saved artifact with `git hash-object <artifact_root>/discovery.md` and report that hash.

## Output

- `READY`: a complete `discovery.md`, its revision and hash, and the unchanged `artifact_root` for the
  planner. Every fact needed for planning is either supported or explicitly marked unresolved.
- `BLOCK`: a saved `discovery.md` describing missing repository access, an identity collision, or a
  load-bearing fact that cannot be verified. The operator receives the blocker; no later stage starts.

## Stop conditions

- The directory is not a Git repository, or required repository instructions cannot be read.
- Existing task artifacts identify another intent or cannot be validated safely.
- The requested work would require destructive discovery, secret access, or an external mutation.
- Evidence is insufficient to distinguish the requested path from conflicting work.

## Next stage

On `READY`, give the planner only the task statement, `artifact_root`, discovery revision, and discovery
hash. Do not send the prior chat transcript. On `BLOCK`, wait for the operator to resolve the recorded
gap and then create a new discovery revision.
