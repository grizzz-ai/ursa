---
name: ursa-handoff
description: Deliver one reviewed task through commit, pull request, checks and normal merge under one scoped user request.
---

## Purpose

Deliver a current independently reviewed task through commit, push, PR, checks and normal merge after
one user handoff/delivery request. Report the verified result or the exact limit/blocker; do not ask
again for unchanged delivery consent. Review PASS alone never authorizes delivery.

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

## Delivery authority

Use a recorded grant only when a current user request in this session selects the task for handoff
or continuation. A clear invocation for one selected task is that request; do not require a special
phrase or another yes/no. Loading instructions, an explanation/preview, another stage or actor,
scheduled wakeup, or a record alone never starts effects. Ask by description if task selection is ambiguous.
Record the attributable user request/source, repository, task, plan revision/hash, target base branch
and limits in handoff.md. A grant covers ordinary commit, push, PR creation/update, check/review observation and
normal merge for that scope. Progress previews inform the user; they are not new consent gates.
Later user limits always override the record: stop, preview-only, no-push, draft-only, open-only,
no-merge and exact-head-only. Narrow immediately; widen only from explicit new user words, never
from an older wider record. An exact-head-only limit expires on head change.
Plan base for delivery authority means the target base branch, not its current commit SHA. An advanced
base-branch commit alone does not end the grant; refresh readiness and affected review/check evidence
under the existing gates. Historical producer/audit base hashes still require coherent validation.
A current continuation under the same plan/repo/target base branch reuses the grant, including an
implementation revision/fix with a fresh independent code audit. Refresh all applicable evidence at the actual head;
do not re-ask delivery consent just because the implementation hash changed. A new plan revision,
repository, target base branch or outside-scope effect ends the grant: ask once for the new scope. Missing,
revoked, conflicting or legacy-unattributable authority stops effects. Never upgrade old READY to consent.
Default new workflow evidence to local. Preserve explicit track/local/pending choices; pending is a
real unresolved choice. Track requires explicit intent plus the independently admitted exact paths;
the carried delivery grant covers their commit without another commit-approval question.
Delivery does not authorize issue writes/auto-close, deploy/release/publication, paid runs, settings,
protection/IAM changes, admin/force bypass, branch deletion or artifact maintenance. Ordinary expected
CI/preview effects do not reset consent; a known new external effect beyond scope needs its own choice.
Client sandbox/permission controls remain independent; never bypass them.

## Task maintenance guard

Explicitly read selected task maintenance.md/ref if either exists; validate pair, identity/revision/blob.
Absent pair means legacy ACTIVE. ARCHIVED is inspectable history, excluded from execution/new rounds;
route explicit resume to ursa-maintain. PARTIAL/BLOCK/incomplete pair stops writes/automatic selection,
not silent fallback; only maintenance producer reconciles it. Preserve old producer bytes/refs.
Expected absent scratch requires original implement entry + matching completed deletion result in a
valid maintenance pair for exact path/blob/task/root/repo and actual absence. PARTIAL alone, wrong
receipt, missing durable evidence or changed/reappeared bytes BLOCKS. No approval is revived by resume.

## Steps

1. Read discovery, plan, governing plan audit, COMPLETE implementation and code audit with saved refs.
   Validate task/root/repo/plan/base/revision/hash bindings. Both latest complete audits for the exact
   producer bytes must be PASS from distinct actors; later REVISE/BLOCK or self-review stops delivery.
2. Resolve the current request and any carried grant under Delivery authority. Apply the latest user
   limits before effects. Record missing decisions or narrowed endpoints, not repeated approval forms.
3. Refresh instructions, branch, HEAD, status and full diff from the reviewed base. Distinguish recorded
   expected delivery changes (the exact reviewed commit/PR) from unexplained product/path drift.
   Product fixes return to implement/review; only reviewed in-scope work may resume under the same grant.
4. Apply disposition. Enumerate ignored/hidden task entries and initial index; compare intended tracked
   paths/blobs with the independent audit's admitted list. Default-local includes new handoff/maintenance
   outputs; unreviewed entries never get swept in. Show tracked and retained-local lists. Preserve
   explicit pending instead of guessing. No broad add/force-add or directory staging.
5. Save handoff.md/ref with existing plan/implementation/code-audit/base/disposition bindings plus
   request/source, grant scope/status, active limits, checked head, completed effects, last verified
   boundary, remaining gate and eventual PR/merge identity. Use a new revision, not another grant file.
   Before each effect record intended action as in_progress, not completed; after readback record
   only actual effects and verify the saved file/ref. These are procedural receipts, not atomic locks.
6. Default to non-closing commit/PR Refs links. Inspect all commits and PR text for closing keywords;
   expose an existing auto-close effect and require its separate explicit choice, or stop for a
   non-closing form. Delivery consent never includes closure. Under track intent and the carried
   grant, deliberately force-add only exact unchanged independently admitted records. Compare staged
   NUL path/blob lists to the admitted set and initial index, inspect staged diff, create one normal
   repository-conforming commit and record SHA. Preview-only permits no commit, push, PR or merge;
   only this handoff's own record/ref may be saved unless the user also prohibited local writes.
   No-push permits the reviewed local commit but stops before push.
7. Push the reviewed commit normally to the selected branch, without another consent question. Never
   force-push. Create/update one matching PR with the verified base, non-closing reference, title and
   factual checks/risks; re-use a matching existing PR rather than duplicate it. Read URL/repo/base/head,
   state and linked issue back. Open-only/no-merge/draft-only stop at their requested endpoint.
8. Read current PR/head, check runs/statuses, reviews/blocking discussion and effective branch
   requirements. Missing/inaccessible data is unknown, not no requirements; no displayed checks alone
   does not establish that none are required. Use supported repository-scoped gh/API reads, validating
   stdout separately from diagnostic stderr. A real read failure stops; preserve its cause.
   Failed checks, requested changes, missing required reviews, conflicts or stale evidence block merge.
   Never self-approve a PR, re-run checks, relax protection or reinterpret an old PASS to bypass a gate.
9. Observe ordinary pending checks for at most10 minutes and6 state snapshots from the start of
   this invocation's observation, after any push/PR update in this invocation. A current continuation
   starts its own observation window, not a timer tied to the original PR creation. Use spaced waits
   or supported event notifications, then one final exact-head readiness read before merge. Do not
   reset the window on head changes within this invocation. If still pending, return BLOCK: pending checks, no outside action needed; reinvoke to continue. Preserve the
   grant; a current same-task continuation resumes observation without new consent. A required human
   review or failed check is a distinct blocker naming the real outside action, not merely pending.
10. When ready and within limits, merge normally with the user's method; otherwise use the sole
    enabled repository method; if several are allowed use merge commit to preserve the reviewed SHA.
    If merge commit is disabled and multiple others remain, report the method choice rather than guess.
    Bind the mutation to the reviewed head, e.g. gh pr merge with the selected explicit method and
    --match-head-commit <reviewed-head>. No --admin/force, protection bypass or --delete-branch.
    Queued auto-merge is not MERGED. Re-read actual merged state/time/commit and delivered changes;
    after squash/rebase verify equivalent reviewed changes, not equality of the rewritten commit SHA.
11. After failed/ambiguous commit/push/PR/merge or readback, stop mutations and reconcile read-only
    against local/remote identity, exact heads, matching PRs and merge state. Never retry UNKNOWN
    blindly or compensate by delete/reopen/force. If still unknown, BLOCK with observed effects and
    the exact reconciliation gap. A proven-absent failed write needs a separately recorded bounded
    retry decision; old delivery consent does not grant unbounded retries.
12. Save/verify the final handoff/ref and report the result below. Retain the original grant and latest
    limits with evidence, not an assertion that future work is approved. No issue comments/closure,
    deploy or maintenance action follows implicitly.

## Output

- MERGED: operator receives verified PR URL, reviewed head, merge SHA/time, delivered changes,
  checks/independent review, tracked/local lists and remaining risks. A merge alone is not acceptance.
- LIMIT_REACHED: operator receives the requested preview/local/PR endpoint, actual completed effects
  and unexecuted remainder. This is not a failed check or full delivery; state the active limit.
- BLOCK: operator receives the last verified effect, unknown/missing proof or blocker and next action.
  Distinguish still-pending/no-outside-action from a real external dependency. Preserve the grant for
  an eligible current continuation, never claim a proposal, queued merge or uncertain write succeeded.
Legacy READY is historical PR evidence only; it never means merged or supplies a missing user grant.

## Stop conditions

- Invalid identity/producer/ref/audit binding, missing scope, unexplained drift or competing pass.
- Current user limit prohibits the next effect; report LIMIT_REACHED when its endpoint is complete.
- Unreviewed staging, an expired exact-head restriction, unknown policy/state or unresolved review/check.
- New plan/repo/target base branch/effect, revoked authority, ambiguous metadata or uncertain mutation outcome.
- Action would close/comment on an issue, deploy/publish, change settings/protection, spend, delete a
  branch or maintain artifacts without its separate authority. Never bypass a client permission gate.

## Next stage

Return verified delivery evidence to the operator. Suggest ursa-close-issue only for a separately
requested acceptance/closure assessment; it independently checks every criterion and needs its own
write approval. A PR alone is not delivery, and a merge alone is not acceptance. After verified
completion offer ursa-maintain inventory; never run ignore/archive/cleanup automatically. For a
blocked fix return to implementation and distinct review, carrying only still-valid scoped authority.
