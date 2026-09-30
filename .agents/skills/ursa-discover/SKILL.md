---
name: ursa-discover
description: Explain an existing GitHub project or ground a named task without technical user inputs.
---

## Purpose

Explain this project and current work before a task is chosen, or ground the user's named task.
This stage observes and records; it does not edit product files or authorize planning from an overview.

## Access and identity

Use this Git repo; only current-request task/issue focuses discovery; bare calls always ORIENT, ignoring prior chat tasks. Never ask for IDs.
Find Git root/rules; branch's tracked GitHub remote else sole GitHub remote; >1 ask before reads; never default to origin; github.com HTTPS/SSH; aliases BLOCK.
No GitHub remotes: BLOCK; ask Code URL; no remotes: tell user `git remote add origin <URL>`; other remotes: give `git remote add <unused-name> <URL>`; rerun.
Require `gh`, non-JSON `gh auth status --active --hostname github.com`, then `gh repo view owner/repo`.
On gh failure, probe `gh api --hostname github.com meta` in this client; Git transport is not API proof.
Network/sandbox denial: request scoped access, retry original checks; unknown causes BLOCK without guessing.
Suggest `gh auth login` only for confirmed missing auth or reachable rejection; never auto-change credentials.
Match any saved canonical root/repo or named issue before work reads; never use gh defaults/swap upstream.
Use explicit `--repo`/repository API paths. Failed requests BLOCK, never count as empty work lists.
Do not log in, switch accounts, alter remotes, or inspect home SSH configuration automatically.
Assign one runtime-session identity, else a POSIX session token; record its source and authorship.
Keep it for this actor; relabeling, Git email and model/provider names do not make a new reviewer.
No secret/.env/home-credential/global-skill reads or token display; describe only declared integrations.
Do not execute project setup/test/deploy commands or enumerate live cloud accounts/resources.
Preserve dirty files/staged entries; no staging or Git-config writes; create only workflow records/refs, never .gitignore.
If the user or repo rules prohibit writes or require permission not yet given, skip saving.
Unsaved means no READY/handoff or workflow/project writes; use `git --no-optional-locks` for reads.
Save artifact then .ref (relative path, revision/round, bare Git blob OID); all hash fields are bare OIDs; incomplete writes never READY.
Missing pairs need fresh producer passes, not fabricated refs; detected competing passes BLOCK.
These checks provide no attestation, tamper-proof storage, locking or transaction guarantees.

## Steps

1. Snapshot branch, HEAD, dirty state, last ten commits and remotes; separate facts from interpretation.
   Read default branch via `gh repo view owner/repo --json defaultBranchRef`; do not trust origin/HEAD.
2. Read project structure/manifests and documented run/test commands; cite paths and Git refs.
   Describe declared dependencies/integrations, never live access; report absent tests/instructions.
3. Read at most 30 open issues and 30 PRs for this repo; label bounded lists and read relevant bodies.
   Read open milestones with repository-scoped pagination. No GitHub Projects query or scope.
4. Without a task, explain project purpose/parts, current work, documented checks, gaps and 2–3 choices.
5. Save `.ai-workflow/_project/overview.md`; `_project` is reserved and never an eligible task key.
   Fields: `mode: orientation`, `repository_root`, `github_repo`, `actor_id`, `actor_source`,
   `session_authorship`, `revision`, `branch`, `base_ref`, `checked_at`, `status: ORIENTED|BLOCK`.
   Add cited facts/gaps/choices; increment its revision. It is not task evidence or plan permission.
6. With a user-named task, refresh this same pass and focus evidence on that intent.
7. Trim/collapse ASCII whitespace to one space; retain case/punctuation; hash UTF-8 bytes without
   a trailing newline via `git hash-object --stdin` as `intent_hash`.
8. Derive one lowercase letters/digits/hyphens `task_key` and `.ai-workflow/<task_key>/` root.
   Existing discovery must match root/key/intent/repo; incomplete or different identity BLOCK.
9. Write `discovery.md`, incrementing its revision; never replace another intent's records.
   Fields: `task_key`, `artifact_root`, `actor_id`, `revision`, `intent_hash`, `repository_root`,
   `branch`, `base_ref`, `status: READY|BLOCK`, `mode: task`, `github_repo`, `checked_at`,
   `actor_source`, `session_authorship`. Only task discovery with READY may feed planning.
10. Include instructions, paths/command evidence, constraints, dirty/related work, cited facts,
    interpretations, gaps and planning input. Hash the saved artifact and save its companion ref.
11. Keep snapshots current: changed branch/HEAD/relevant bytes require refreshed context; material
    drift invalidates approval. Distinguish this pass's outputs from pre-existing dirty work.
12. Resolve artifact collisions before writing; never overwrite another intent or completed audit.

## Output

- `ORIENTED`: readable overview/choices; state saved with ref or not saved; no selected task or plan authority.
- `READY`: a named task's complete discovery/ref pair; identity and every fact are verified or a gap.
- `BLOCK`: explain the failed access/identity/evidence check and exact next action; no later stage starts.
  Save the blocker only at a safe, validated artifact root; an unsaved report is not durable evidence.

## Stop conditions

- The directory is not a Git repository, or required repository instructions cannot be read.
- Existing task artifacts identify another intent or cannot be validated safely.
- The requested work would require destructive discovery, secret access, or an external mutation.
- Evidence is insufficient to distinguish the requested path from conflicting work.

## Next stage

On ORIENTED, ask the user to choose a task. On READY, the planner resolves the saved discovery/ref
pair for that task; no chat history or manual root/revision/hash/actor input is needed. On BLOCK,
the operator resolves the gap, then discovery writes a fresh revision and reference.
