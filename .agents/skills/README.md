# Canonical skills

This directory is the single source for the six workflow skill bodies:

- `ursa-discover`
- `ursa-plan`
- `ursa-plan-audit`
- `ursa-implement`
- `ursa-code-audit`
- `ursa-handoff`

Start with `ursa-discover` in the user's GitHub project. With no task, it explains the project,
current work and possible next steps. After the user chooses a task, discovery grounds that task
for planning. An overview alone never authorizes planning or implementation.

Each stage requires the project's GitHub remote, `gh` authentication and access to that repository.
Git transport authentication, including SSH, does not authenticate the GitHub CLI's API requests.
Missing access stops the stage with a concrete connection action; Projects are outside this workflow.

Agents manage session identities and saved references; users choose tasks without typing IDs or hashes.
Audits require a separate reviewing session from the author. Changing a label or model does not
establish independence, and a later REVISE or BLOCK prevents use of an earlier PASS.

The installer copies only SKILL.md into `.agents/skills/<name>` and creates a relative
`.claude/skills/<name>` link. This README is source documentation, not an installed dependency.

Orientation is saved in `.ai-workflow/_project/overview.md`; task evidence lives under
`.ai-workflow/<task_key>/`. Each saved output has a companion `.ref` checked by its recipient.
A no-write request leaves an unsaved overview and no durable handoff; project files remain unchanged.
These are agent instructions, not tamper-proof records, identity attestation or executable enforcement.

Commit, push, pull-request creation, merge, deployment and publication remain separate operator decisions.
