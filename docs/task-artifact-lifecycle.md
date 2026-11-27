# Task artifact lifecycle

Use `ursa-maintain` in your consuming Git repository. A bare request starts with task choice and an
inventory, not cleanup. It reports retained, ignored, archived, disposable, shared and unknown paths.
The six coding stages and optional issue skills remain separate; maintenance never writes GitHub.

## Visibility is a team decision

A root-anchored `/.ai-workflow/` rule in your shared `.gitignore` can remove untracked workflow noise
from Changes. The agent shows the exact addition, existing/negated rules and every affected class
before asking. It refuses a broad rule when the namespace includes unknown or product content and
offers narrower rules instead. Installation, discovery and audits never add it automatically.

Approving the edit leaves an uncommitted `.gitignore` change. Teammates benefit after your normal
reviewed delivery. Existing tracked files stay tracked; the agent does not run `git rm --cached`.
Declining leaves the rules unchanged; repeating an identical effective rule does not duplicate it.
Files remain on disk: ignoring is neither archiving nor deletion nor reclaimed disk space.

Ignored evidence is vulnerable to `git clean -X` and `git clean -x`; maintenance never runs them.
`git stash -u` omits ignored files and is not a backup. Protect evidence with a separately verified
backup where needed. Never assume a clean Changes view means all local evidence is safely stored.

## Preserve and archive

Task producer records and their refs, prior audit revisions, delivery evidence and maintenance
receipts remain durable. `_project/overview.md` and its ref are shared orientation records, hidden by
the same rule but never owned by an individual task or eligible for archival/deletion. Old logs and
preview backups with no creation receipt are retained as unknown, not guessed disposable.

Archive requires the selected goal actually complete. Product changes need independent review and
verified delivery; a merged PR or passing test alone is insufficient. Associated issue criteria must
be checked, but maintenance never closes the issue. Active, partial, blocked and deferred tasks remain
protected. A read-only task needs its promised result, not an invented delivery PR.

After a separate preview and choice, archive records ARCHIVED in place. Original task paths, bytes
and audit bindings stay intact. Ordinary execution skips archived tasks; explicit inspection and
issue evidence lookup can still read them. Naming the same intent offers resume or a new task only
for a distinct intent. It never silently overwrites the archive.

Resume is separately chosen. Original identity/dependencies are checked before ACTIVE state returns;
changed HEAD/branch/relevant bytes still require context refresh and new planning/review where needed.
No earlier PASS becomes current solely because you resumed. Missing/corrupt evidence stops the action.

## What can be cleaned

Only `ursa-implement` records new scratch provenance: necessary actual planned commands may create
fresh files at `.ai-workflow/<task_key>/scratch/<actor-or-session>/<operation>/`. Its implementation
record/ref binds each exact path to task, creator, actual command/exit, absent-before observation,
resulting Git blob, role and disposable/required-evidence classification. No retrospective ownership
of older files, clobbering, symlink traversal or extra commands merely to create cleanup candidates.

A producer receipt proves origin, not permission to delete. Independent review must confirm retained
command/result evidence suffices without the raw payload. Required logs and any actual dependency
protect the file even if its ownership entry says disposable. Unknown/shared/other-session/user files,
tracked/staged paths and all durable producer records stay. Incomplete dependency inventory blocks
only the affected cleanup; filenames, age and merge state never establish safe ownership.

Maintenance previews exact deletions, protected survivors, retained evidence and recovery. Archive,
ignore, delivery and issue consent do not authorize deletion. Approve the exact cleanup separately,
with accepted discard or a verified backup: deleted disposable bytes are not magically recoverable.
External temp roots and worktrees are inventory-only/manual handoff, never automatically removed.
A future removal needs its own reviewed recovery design and evidence retained outside the worktree.

## Partial approval and interruption

The maintenance owner saves a verified PARTIAL journal/ref before the first effect. It rechecks exact
path/blob, regular-file/real-parent containment, ownership and dependencies before each approved file.
No wildcard, recursive-root remover, `rm -rf`, directory staging or following symlinks is allowed.
Only explicitly approved empty directories may be removed after their enumerated files.

If any previewed item is unapproved or unexecuted, the record stays PARTIAL and lists the remainder.
Completing an approved subset does not complete the original preview. Final ACTIVE/ARCHIVED requires
all previewed effects reconciled, or an explicit operator withdrawal of the remainder. Withdrawal
records no deletion and cannot turn incomplete task work into completion.

On restart the agent reads the real surviving files and receipts, previews remaining effects and
asks for a new choice. It never blindly retries the first deletion or infers success from absence.
A missing/mismatched output/ref pair is incomplete; only the owning producer can reconcile current
state and save a fresh truthful pair. Original producer attestations are never repaired or invented.
The maintenance history and validated deletion results remain durable through archive/resume.

After valid cleanup, the historical implementation still lists its original scratch. Consumers accept
absence only for that exact path/blob/task/root/repo with both original implement provenance and a
complete matching observed deletion receipt. PARTIAL alone, wrong receipt, missing durable record or
reappeared/changed file blocks this exception. It never authorizes deleting a newly appeared file.

## Review and track ignored evidence

Implement and code-audit explicitly enumerate the task root, including ignored and hidden entries,
alongside normal Git diffs/status. Inventories record paths/kinds/blobs/bindings and classifications;
the independent audit admits exact paths and versions for `track`. Ordinary status is insufficient.

Handoff re-enumerates and compares exact bytes before any approved commit. Force-add is restricted to
individually previewed unchanged reviewed paths, under both track and commit decisions. New or changed
handoff/maintenance outputs stay explicitly local or need review before tracking. Compare the staged
path/blob list to the approved list; never force-add a directory. Report both tracked and local lists.

## Maintainer verification

Use a disposable Git consumer and separately approved effects/budget. Retain the exact candidate
source in a temporary local fixture commit: installation checks tracked HEAD bytes. Run the real
`sh -n install.sh tests/install.sh`, `sh tests/install.sh` and `git diff --check`; do not disable guards.
The suite proves nine-body packaging, actual rollback and preservation, not native agent behavior.
No hosted workflow is implied; the same shell suite can run locally or in external CI with Git/sh.

Install/validate all nine bodies, origins and relative Claude links. Record source/skill blobs,
executable/version, actual named skill loading and fresh actor identities in each client. Real native
discovery/planning/independent-audit/implement/handoff records are required, never parent-written PASS
or refs. Keep test-specific session/private repository receipts outside public guides.

Reuse one complete fixture task per client for track and cleanup: a genuine planned shell test checks
exact newly implemented marker bytes, emits real stdout/stderr into two implement-owned scratch logs,
and produces real receipts. Distinct review confirms results and raw-payload dispensability. Actual
separately authorized delivery/criteria establish completion; stage only reviewed durable paths, not
scratch. Parent scaffolding and fault injections are labelled test setup, not producer evidence.

| Scenario in BOTH clients | Actual evidence required |
| --- | --- |
| Inventory/dry-run/decline | Ignored/hidden/tracked paths listed; files/index/other tasks unchanged |
| Shared ignore approve/repeat/collision | Exact minimal rule and effective check-ignore; product sentinel visible; duplicate rule absent; tracked records retained; unknown namespace blocks |
| Archived/incomplete/deferred work | Only completed selected task archives, original graph unchanged; `_project`/other tasks protected; read-only archived inspection and explicit resume |
| Scratch provenance/required log | Real implementation command/receipts; unreceipted, required or shared payloads refused |
| Track under ignore | Independent full inventory and admitted versions; actual staged NUL-delimited path/blob set equals exact reviewed list, no new unreviewed output swept in |
| Partial cleanup | Approve journal plus first log only, withhold second/finalization; first absent, second unchanged, status PARTIAL, durable originals unchanged |
| Reconcile/repeat | Fresh session does not replay first; decline remainder unchanged, separately approve second, verify final absences; repeat no new effect |
| Broken pair/receipt and drift | Declared snapshot-backed withheld ref, wrong receipt/path/blob or changed/symlink path blocks; restore originals before positive test |
| Resume after cleanup | Exact receipted scratch absence accepted; no durable missing-file exemption or stale PASS revival |
| External roots/worktrees | Inventory/protected handoff only; no remove/prune/force, issue write or implicit cleanup |

Use real command-boundary interruption, not timing luck: stop after journal or one authorized deletion.
A second control temporarily withholds a real pair's ref, preserving/restoring exact originals. Never
claim a killed process/atomicity test from those bounded controls. Capture before/after filesystem,
producer hashes, `git status --ignored`, `git check-ignore -v`, staged `git ls-files --stage -z` and
`git diff --cached --name-only -z` plus actual calls/exit/results. No destructive Git clean experiment.
Record unavailable loading/access/authority/permission failures as partial, not expected behavior.
Procedures provide no transaction/lock/tamper-proof guarantee; passing source checks cannot prove them.
