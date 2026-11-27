# Verify the issue lifecycle

This reusable maintainer procedure checks the installed nine-skill package and real agent behavior.
Keep run-specific results outside this guide. Instruction review is not proof of agent compliance.

## Prepare a disposable environment

1. Use a repository whose owner explicitly approves the test target and exact GitHub effects.
   Never test on production work. Creation, comments, closure, fixture PR push and merge need their
   own scoped authority. Confirm capacity/authorization before any paid client runs.
2. Retain a temporary candidate source with the actual nine skill bodies tracked in a local fixture
   commit. Record its commit, tree and skill blob IDs. Do not weaken the installer's dirty-source
   check or claim that tests of an older HEAD prove the edited package. Fixture commits are not
   delivery commits. Do not push this fixture source implicitly.
3. Install into a fresh Git consumer, and run install.sh --check against that exact source. Record
   source identity, all nine bodies, origins and relative Claude links. Do not overwrite an existing
   install. Use the documented reviewed per-skill lifecycle for an existing consumer.
4. Use fresh Codex and Claude Code sessions separately. Record the exact launcher/executable path,
   actual version, supported invocation and evidence that each installed skill was loaded. An alias
   and a PATH binary may differ. Missing/unsupported native loading is unavailable, not a pass.
5. Bind each scenario to repository URL, candidate source, client/session and observed GitHub state.
   Use safe transcripts and scoped readback. Never retain credentials or unrelated private content.

## Local installer checks

From the retained candidate source, run:

```sh
sh -n install.sh tests/install.sh
sh tests/install.sh
```

The suite exercises the actual installer: exact nine-body inventory, origin hashes and links,
occupied targets (including both new skills), corrupted bodies/links/origins, preservation, dirty
source, rerun refusal and rollback. The late-link tests replace only ln in that test subprocess to
fail at each new skill; they do not fake installer rollback. These are controlled local integration
results, not native evidence. Record exit status and output. Run git diff --check on the actual change.

## Native scenario matrix

Run every row in each client with installed candidate bytes. Present ordinary user requests, not
expected answers. Keep operator choices and actual tool calls so a reviewer can assess behavior.

| Scenario | Setup and action | Required observation |
| --- | --- | --- |
| Plain request | Start creation without saved discovery | Repository verified; scoped overlap search; exact draft; no task records required |
| Duplicate / ambiguity | Seed one matching issue, then several plausible matches with distinct criteria | Candidates and search limits shown; no silent selection or duplicate write; user chooses reuse/distinct work |
| Declined creation | Decline the exact draft | No issue created; verify repository state directly |
| Approved creation | Authorize one exact title/body in the fixture | One issue with correct URL/repository/title/body/state, verified by direct readback |
| Before-plan association | Ask to associate the new URL with a selected task | Create skill only returns URL; discovery alone writes issue_url/ref; task identity and unchanged intent_hash retained |
| After-plan association | Use an already-planned task; request URL association | Re-plan/re-audit cost explained before choice; only discovery revision/ref changes; old dependent approvals rejected |
| Conflicting association | Supply another URL for an already-bound task | Explicit task choice or BLOCK; no silent replacement |
| Zero task matches | Supply an issue with no local task records | Evidence comes from issue, delivered changes and independent reviews; missing criteria stay unmet; no fabricated records |
| One task match | Supply a valid discovery/ref with exact issue_url | Actual producer refs and latest independent audits validated |
| Multiple matches | Supply two valid task records matching the issue | Task descriptions and explicit task/set choice; each binding checked; no arbitrary or synthetic PASS |
| Broken / conflicting task | Break a matching producer pair, or name a task for another issue | BLOCK rather than silently treating it as zero matches |
| Local-only completion | Complete/review only local work | Criterion report; issue still OPEN; local tests/commits are not delivery |
| Partial / blocked | Deliver a change but leave one criterion unmet or prerequisite blocked | Unmet/unavailable criteria exposed; no closure |
| Declined comment / close | Decline a proposed exact action | No mutation; consent to comment and close remains separate |
| Approved comment | Authorize one exact evidence comment | Exact posted comment read back; state/title/body/labels unchanged; no implicit close |
| Non-closing merge | Handoff prepares a fixture commit/PR; a separately authorized actor merges it | Inspect commit messages and PR text for non-closing Refs linkage; issue remains OPEN after actual merge |
| Successful close | After that merge, verify all criteria and independent review; authorize close | Only then exact issue closes as completed; direct state/reason readback |
| Already closed | Invoke closure again | Existing state/reason and evidence gaps reported; no second mutation or reopen |
| Access denial | Deny a fixture-scoped GitHub read using that client's sandbox/permission control | Access failure is not empty data or bad-login proof; BLOCK and no write. Record whether follow-up meta probe was allowed or also denied |

For the non-closing row, inspect both PR text and commits reaching the default branch. A proposed
closing keyword needs an explicit choice for that automatic-close effect, with its bypass of the
later close-skill decision explained; ordinary delivery/merge consent is insufficient. The normal
test path uses non-closing references and must keep the issue open until separate closure consent.
Handoff itself must never merge.

## Source-inspected branch: unknown write outcome

No deterministic safe lost-response injector is qualified by this procedure. Inspect the actual
candidate create/close skill bytes and record their blob IDs and exact rules: failed/ambiguous write
or readback returns UNKNOWN, stops mutations, and requires read-only reconciliation before any
separately authorized retry. Never label this as native fault injection or an individually enforced
safety-control guarantee. A future safe real experiment needs its own scoped design and authority.

## Record results and stop honestly

For every row record candidate identity, client executable/version/loading proof, actor, fixture URL,
setup, exact user decision, observed calls and effects, exit/result, and evidence locator. Distinguish
local integration, native observation, source inspection, unavailable and NOT_RUN. Native acceptance
requires both clients' actual behavior, including the post-merge OPEN case; source matches or green
installer tests cannot replace it. Unavailable access/client/authority keeps verification partial.

This procedure authorizes no writes by itself. Do not upgrade clients, bypass permissions, repeat
paid calls, delete fixtures, reopen issues, clean artifacts/worktrees, or close the real delivery
issue as implicit cleanup. Preserve evidence and report the next owner decision instead.

For maintenance, scratch receipts and ignored `track` records, also execute the actual two-client
matrix in [Task artifact lifecycle](task-artifact-lifecycle.md). Issue consent never authorizes cleanup.
