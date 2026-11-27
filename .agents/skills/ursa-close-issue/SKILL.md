---
name: ursa-close-issue
description: Check acceptance and delivered evidence before separately authorized issue closure or comment.
---

## Purpose

Reconcile one issue against real acceptance and delivery evidence. Local completion leaves it open;
a merged PR alone is insufficient. An optional update is one separately authorized factual comment.

## Access and identity

Use Git root and project instructions; branch's tracked GitHub remote else sole GitHub remote;
multiple remotes require a choice before reads. Accept github.com HTTPS/SSH; aliases BLOCK.
No GitHub remote: ask for the Code URL and a separately authorized remote setup; do not change remotes.
Require gh, non-JSON `gh auth status --active --hostname github.com`, then `gh repo view owner/repo`.
Scope every read/write with explicit --repo or repository API path; match the named issue/task to it.
After gh failure run `gh api --hostname github.com meta` in this client. Transport/sandbox failure
means request scoped access, never recommend login solely for network failure. Login advice only
for missing auth (exit 4) or HTTP 401; unknown causes BLOCK. Never log in or switch accounts yourself.
Assign one runtime session identity (else a POSIX session token); retain source and authored stages.
Do not inspect secrets, home credentials/global skills, change settings, stage files or alter product code.
Do not print tokens. Preserve dirty work. Failed reads are not empty lists or proof of completion.
Read any selected task's producer refs; validate root/key/intent/repo/revisions and bare Git blob OIDs.
Missing/partial/mismatched pairs or competing passes BLOCK; never manufacture records or repair refs.
Only ursa-discover writes discovery.md, issue_url and its ref. Neither skill below edits task records.
These are agent procedures, not transactional enforcement or identity attestation.

## Resolve task evidence

1. Resolve the exact issue URL/number from the user's selected issue in the verified repository;
   a bare number needs repository/type resolution. Do not infer a task from mtime, branch or title.
2. If a task is named, validate its discovery/ref and issue_url. A conflicting issue or invalid pair
   BLOCKS; do not silently fall back. A legacy task without issue_url needs explicit selection and
   demonstrated relevance to this issue; read it without adding a field.
3. Otherwise match exact canonical issue_url across local .ai-workflow task discovery records only,
   excluding _project. A matching broken/missing producer pair is a blocker, not an absent match.
   Zero matches: use issue/comments, actual delivered diff/commit and independent review/PR evidence;
   never invent task records, and leave unsupported criteria unmet. One valid match: follow its
   producer refs and latest governing audits. Several: show task descriptions and ask which task or
   explicit set to use before proceeding; validate each independently and map evidence per criterion.
   Never combine unrelated records into a synthetic PASS. No issue association is written here.

## Assess and act

1. Read the issue body, state/reason, comments and relevant delivery/PR evidence with explicit scope.
   Already closed: report observed state/reason and evidence gaps without another close or reopen.
2. For selected Ursa tasks, validate discovery, plan, implementation, governing audits and delivery
   records against their refs, identities, revisions, hashes and base. Require independent reviewers;
   later REVISE/BLOCK overrides PASS. Missing or stale proof stays a gap, never repaired here.
3. Map every acceptance criterion to primary evidence and mark met, unmet or unavailable. Inspect
   actual changes/checks, not just prose claiming PASS. Local tests/commits do not prove delivery.
4. Verify delivery by reading merged PR and delivered commit/diff, or a reviewed exact commit on the
   intended remote delivery branch without a PR. Bind evidence to actual delivered bytes; a pushed
   unmerged feature branch alone is not delivery. A merge does not prove unrelated acceptance.
5. Report COMPLETE, PARTIAL, BLOCKED or LOCAL-ONLY assessment. Missing criteria, failed reads, unknown
   delivery or missing review prevent closure. Keep the issue open; explain what evidence is missing.
6. Offer either no write, one factual progress/evidence comment, or (only when complete and delivered)
   closure as completed. Show exact repository/issue URL, action, payload and resulting state.
   Ask separately for that action's authorization; approval to comment never authorizes closure,
   and approval to close never authorizes an extra comment. Decline/pending means no mutation.
7. Refresh criteria, evidence and state immediately before the approved action. Material change
   returns to assessment/preview. Execute the exact scoped comment or close once using gh.
8. Read back exact closed state/reason, or posted comment ID/URL/body and unchanged issue state.
   Uncertain write/readback returns UNKNOWN: stop writes, preserve safe observed facts and approved
   payload, reconcile read-only before any separately authorized retry. Never repeat blindly.
9. Return observed effect and remaining work to the operator. Do not edit title/body/labels, reopen,
   mark duplicate/wontfix, clean artifacts/worktrees, commit, push, merge or deploy.

## Output and recipient

- CLOSED: operator receives verified issue identity, completed reason and criterion/delivery evidence.
- COMMENTED: operator receives verified exact comment and issue state; no closure was implied.
- OPEN / DECLINED: operator receives criterion report, missing evidence or declined action; no write.
- BLOCK / UNKNOWN: operator receives access/identity/evidence gap or uncertain effect and required
  reconciliation. No later stage or mutation is authorized. Saved task evidence remains unchanged.

This skill observes delivery; it never performs it. A discovery/audit run never invokes issue writes.
