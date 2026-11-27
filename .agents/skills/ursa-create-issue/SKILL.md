---
name: ursa-create-issue
description: Preview a nonduplicate GitHub issue and create it only with explicit authorization.
---

## Purpose

Turn a user-selected next step or plain-language request into a concise, testable GitHub issue.
Saved discovery is optional; GitHub Issues remain optional for other Ursa tasks.

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

## Retained task evidence

Read selected task maintenance/ref when present and validate identity/revision/blob. Archived evidence
may be inspected without resume; do not exclude it from exact issue evidence lookup or rewrite it.
PARTIAL/BLOCK/broken maintenance pair blocks task-based write readiness, not a fallback to no evidence.
Absent scratch is expected only with original valid implement entry, matching complete maintenance
receipt for exact path/blob/task/root/repo and actual absence; PARTIAL/wrong receipt or missing durable
pair is a gap. Reappearing/changed file is protected drift. No archival or issue effect is implied.

## Steps

1. Resolve the user's intent and verified repository. If unclear, ask by task description, never IDs.
   A bare invocation offers task choices; it does not select or create an issue automatically.
2. If the user selected saved task evidence, validate discovery/ref before using it; an orientation
   overview is context only. Without saved evidence, inspect relevant repository paths directly.
3. Search open and relevant closed issues for overlap with scoped gh reads. State search terms,
   coverage/limits and candidates. Show duplicates or ambiguity; ask whether to reuse an existing
   issue or why a distinct issue is needed. Never silently select a match or create a duplicate.
4. Draft a title and body with the problem/trigger, bounded scope, acceptance criteria, concrete
   verification, dependencies and exclusions. Do not invent roles, labels, Projects or sprints.
5. Show the exact repository, proposed title/body and intended create action. Ask for explicit approval
   of that payload. Declined or not-yet-authorized means no write. Changed payload needs fresh approval.
6. Recheck repository, relevant overlap and payload before the approved write. If changed, stop and
   show the revised preview. Create once with scoped gh and an exact body file, not shell interpolation.
7. Read the returned issue back: canonical URL, repository, number, title, body and state must match.
   Failed/ambiguous write or readback means UNKNOWN; preserve the intended payload and safe observed
   facts and stop writes. Reconcile with read-only search/readback; if a retry is still needed, show
   its exact payload and possible duplicate effect, then obtain fresh separate authorization even
   for an unchanged payload. Earlier approval never authorizes a retry after UNKNOWN.
   Do not claim creation or retry blindly. Do not post a compensating comment or delete anything.
8. Return the verified issue URL and next choice. To associate a saved task, route to ursa-discover
   with that URL and the task description; never edit its records here. Explain before association
   after planning that a fresh discovery revision invalidates downstream plans/audits, requiring
   re-plan/re-audit. The operator may instead keep the issue separate and select evidence at closure.

## Output and next stage

- CREATED: operator receives verified canonical URL and exact payload/readback; no implementation starts.
- REUSED: operator chose a verified existing issue; no new issue was created.
- PREVIEW / DECLINED: operator receives exact draft or refusal result, no GitHub mutation.
- BLOCK / UNKNOWN: operator receives ambiguity, access/evidence gap or uncertain effect and read-only
  reconciliation needed. No later write is authorized by this status.

Creation never commits, pushes, creates PRs, closes issues, starts planning or supplies fabricated
workflow records. User-selected association routes to ursa-discover; further work needs its normal gates.
