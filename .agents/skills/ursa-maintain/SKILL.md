---
name: ursa-maintain
description: Inventory task artifacts, preview shared ignore rules, and separately authorize archive, resume or scratch cleanup.
---

## Purpose and boundaries

Reduce Changes noise while preserving inspectable, resumable evidence. Default to inventory/dry-run.
Hiding, archiving and deleting are distinct effects, never automatic consequences of delivery.
Never edit product code, stage/commit/push, write GitHub issues/PRs, deploy, change global configuration,
remove a worktree or delete external directories. A bare invocation asks which task; no age-based choice.
These are agent procedures, not locks, atomic transactions, identity attestation or tamper-proof storage.

## Access and identity

Use Git root and repo instructions. Resolve the branch's tracked GitHub remote, else sole GitHub
remote; multiple candidates require a choice before reads. Accept github.com HTTPS/SSH, aliases BLOCK.
No GitHub remote: ask for Code URL/separately authorized remote setup; never alter remotes yourself.
Require gh; run non-JSON `gh auth status --active --hostname github.com`, then `gh repo view owner/repo`.
Scope requests with explicit --repo/repository API paths. Failed reads are failures, not empty evidence.
After gh failure probe `gh api --hostname github.com meta`; network/sandbox failure means scoped access,
not bad login. Login advice only for missing auth (exit4) or HTTP401; never log in/switch accounts.
Keep one runtime actor identity, else a POSIX session token, with source/authored stages. Never relabel
an actor as independent. No token display, secret/home-credential/global-skill reads or account scans.
Match selected task description to real discovery/ref and its canonical task/root/repo/intent binding.
Recompute bare Git blob OIDs; validate producer revisions, latest independent audits and delivery.
No workflow pairs may be invented/repaired. Preserve staged, dirty, ignored and other-session work.

## Inventory first

1. Resolve one selected `.ai-workflow/<task_key>/`; never `_project`, branch name, mtime or similar title.
   Read-only inspection of archived history is allowed; wrong identity or unresolved choice BLOCKS.
2. Snapshot branch/HEAD, tracked/staged/untracked changes and ignored entries. Explicitly enumerate
   the task root, including hidden/ignored files; ordinary git status alone omits required evidence.
   Classify exact relative paths: durable, ignored, archived-in-place, disposable, shared or unknown.
   Record file kind, regular-file blob, producer/ref bindings, dependencies and ownership evidence.
   Do not follow symlinks or read secrets. `_project` overview/ref are shared retained orientation
   evidence, never task-owned scratch, archive or deletion candidates. Inspect them for dependencies.
3. Inventory all relevant active/deferred/archived task records and shared dependencies. A partial
   inventory, unresolvable reference or unknown owner protects affected paths; never infer no reference
   from a failed read. Logs, backups and archived revisions without real disposable receipts stay.
4. Show intended action, exact changed paths/content/state, retained evidence, effects and recovery.
   Separate consent is needed for visibility, archive, resume and each cleanup preview. Decline or
   missing consent means no effect. A changed scope/payload requires a fresh preview/choice.

## Visibility: shared .gitignore

Propose only root-anchored `/.ai-workflow/` after inspecting the entire matched namespace and existing
.gitignore bytes/negations. Enumerate tracking for the WHOLE matched namespace with
`git ls-files -z -- .ai-workflow/`, not just the selected task. Reconcile that exact path set with the
recursive filesystem inventory and status, including tracked imported/other-task records; derive
counts from the reconciled set. Failed/partial reads are unavailable, never zero/all-untracked.
Show matched paths and tracked versus ignored classification. Unknown or
product content, symlinked path or conflicting effective rule blocks the broad proposal; offer narrower
exact rules/new preview. Never silently hide product edits or overwrite unrelated rules.
Explain before approval: files remain on disk; archive does not reclaim space; tracked files remain
tracked. The .gitignore edit stays an uncommitted product/configuration change until normal reviewed
team delivery. `git clean -X`/`-x` can delete ignored evidence; `git stash -u` omits it, so is not backup.
Never run those cleanup commands or git rm --cached. Do not change .git/info/exclude/global excludes.
After separate approval, recheck bytes, minimally add the exact agreed rule preserving existing bytes,
then use `git check-ignore -v` and actual status to verify effects; never stage it here. An identical
already-effective rule is a no-op, not duplicate text. Declining leaves rules/status unchanged.

## Maintenance producer

Only this skill writes task `maintenance.md` and `maintenance.ref`; original producer pairs stay intact.
No maintenance pair means legacy ACTIVE, not permission to invent history. Validate an existing pair;
an incomplete/mismatched pair blocks normal writes and success. Only this producer may reconcile real
state and produce a fresh truthful revision; it never rewrites discovery/implementation/audit refs.
Preserve prior maintenance output/ref as durable revision-scoped recovery snapshots before replacement;
retain original bytes and canonical-path context, never present snapshots as current producer pairs.
Carry validated per-item deletion results/provenance forward unchanged through archive/resume/revisions,
or explicitly bind their preserved receipt; never lose the evidence for expected scratch absence. Resolve any
competing pass before writing; inability to preserve/reconcile means BLOCK, never assume ownership.
Fields: task_key, artifact_root, repository_root, github_repo, actor_id, actor_source,
session_authorship, revision, checked_at, branch, base_ref, operation, status (ACTIVE|ARCHIVED|PARTIAL|BLOCK),
source_bindings, retained_inventory, disposable_inventory, authorized_effect, remaining_items, actual_results.
Bind original discovery/latest applicable plan/audits/implementation/delivery path/revision/hash. Inventory
excludes maintenance output/ref themselves to avoid self-hashing. Previous recovery copies are durable.
Save output, hash saved bytes, then save ref with relative path, revision and bare blob_oid. Verify pair
and actual filesystem before reporting state. Interrupted saving never establishes a complete state.

## Archive and resume

Archive requires the selected task's goal/criteria actually complete: product work needs independent
review plus delivered bytes; read-only tasks need evidence of their own promised result, no invented PR.
An issue, if associated, supplies acceptance, not authority to close it. A merge, test green, old branch
or handoff READY alone is insufficient. Active/partial/blocked/deferred tasks are retained/protected.
Preview in-place ARCHIVED state, exact retained originals/dependencies and recovery; obtain separate
approval. Recheck evidence and write only the maintenance pair; never move/rename/truncate producer
records or change their roots/hashes. Verify retained blobs. No disk-space claim or scratch deletion.
ARCHIVED tasks are excluded from execution selection; inspection remains possible. Resume is a separate
choice: validate original graph, root/repo/intent and dependencies, stop competing changes, then publish
ACTIVE. Changed branch/HEAD/relevant bytes still need existing context refresh/re-plan/re-audit; no old
PASS is revived. Unknown/corrupt evidence stays BLOCK. Same complete archived/active state is a no-op.

## Scratch provenance and eligibility

Only untracked regular files in `.ai-workflow/<task_key>/scratch/<actor-or-session>/<operation>/` with
real implement-owned `scratch_inventory` entries can qualify. Validate actual implementation/ref and
creation task/actor/command/exit/absent-before/path/blob; maintenance never creates ownership receipts.
A filename, extension, age or merged branch is not provenance. Parent symlink/traversal, changed bytes,
tracked/staged/product/user/shared/other-session/unknown ownership excludes the path from deletion.
Raw logs are disposable only if the real producer says disposable and independent review confirms
retained durable results suffice without the payload. Ownership entries are provenance, not perpetual
payload dependencies. Any actual plan/audit/verification reliance on raw bytes overrides disposal.
Plans/audits/producer refs, archived revisions, maintenance/recovery records, required logs and unreceipted
preview backups are durable. No retroactive attribution of old clutter. Active/deferred tasks cannot
be destructively cleaned. Missing/incomplete dependency evidence blocks affected cleanup.
External temp roots and worktrees are inventory-only/protected/manual handoff: never remove/prune/force,
even if old or merged. A future removal needs a separately reviewed recovery/evidence design.

## Cleanup: exact preview, partial effects, reconciliation

1. Default dry-run: list each candidate path/blob/provenance, exclusions, shared dependencies, exact
   proposed deletions, survivors and recovery. Explain disposable bytes cannot be recovered without a
   verified backup or explicit acceptance of discard. No consent is inferred from archive/ignore/close.
2. Require separate exact cleanup authorization, including accepted discard or verified backup. Recheck
   state, bytes, ownership, dependencies and all resolved parents. Save/verify a PARTIAL journal/ref
   before the first deletion with the full previewed set, approved subset and remaining items.
3. Delete only approved enumerated regular files inside this task's scratch subtree, revalidating before
   EACH effect. No rm -rf, glob, recursive root removal or symlink following. Remove only explicitly
   approved empty directories after their files. Stop on drift/failure/new reference; record survivors.
4. While ANY previewed item remains unapproved or unexecuted, including a subset approval or stopped
   run, status stays PARTIAL with the remaining exact items. Completing the approved subset alone is
   not completion of the preview. Only after every item is reconciled complete, or the operator
   explicitly withdraws the remainder, may a fresh record return to prior eligible ACTIVE/ARCHIVED.
   Withdrawal records no deletion and never implies acceptance or archival of an incomplete task.
5. Read actual absences/survivors and retained producer blobs, then save truthful per-item results and
   final pair. No success from intended commands or absence alone. Preserve original implementation
   entries. Receipt binds original scratch path/blob/task/root/repo, authority and observed deletion.
6. After interruption, a fresh pass reads receipts/current filesystem; never blindly replay. Preview
   remaining effects and require fresh separate approval; decline means no deletion. A prior PARTIAL
   journal is not a complete deletion receipt or execution eligibility. Do not claim transactionality.
7. Idempotent reread may report already-deleted only from matching complete deletion receipt plus
   original valid implement entry and actual absence. Unknown/wrong receipt or missing durable pair
   BLOCKS. Reappearing or changed files are protected drift, not permission to delete again.

## Recipient and outcome

Operator receives INVENTORY/DECLINED (no mutation), ACTIVE/ARCHIVED (verified pair and actual retained
state), PARTIAL (actual effects + remainder) or BLOCK (exact gap). Visibility-only reports effective
rule/unchanged tracked state, not completion. Save failure/readback uncertainty stops further effects;
reconcile read-only before any new separately authorized action. Archived evidence consumers may read
expected scratch absence only via matching complete receipt and original implement entry; missing
durable evidence always blocks. Route explicit resume here, fresh work to discovery/review gates.
Never close/comment on an issue, stage files or automatically continue another workflow stage.
