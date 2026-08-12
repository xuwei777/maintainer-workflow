# Agent working agreement

This file defines durable repository rules for coding agents. User instructions
and security policy take precedence. Keep current task status out of this file.

## 1. Orient before editing

Run:

```powershell
git status --short --branch
git remote -v
git branch -vv
```

Then read:

1. `<project context or terminology document>`
2. `<current handoff, if the repository uses one>`
3. `<documentation map>`
4. the active work item, work package, or change request
5. the files that own the affected behavior

Stop instead of guessing when the branch, work item, code, migration, contract,
or documentation disagree, or when overlapping unrelated changes exist.

## 2. Repository lineage and authority

- Canonical baseline: `<remote>/<branch>`
- Branch convention: `<prefix>/<issue-or-scope>`
- Change-request target rule: `<PR, MR, review, or equivalent rule>`
- Default decomposition: `<simple work item | parent work item with optional WPs | project-specific>`
- WP delivery mapping: `<child work item and branch/review per WP | parent sections | project rule>`
- Standing authority for an approved work item: `<whole simple work item or
  exact listed WPs, branch, push, and draft review actions the agent may perform
  without asking again; the parent item alone grants nothing>`
- Fresh explicit approval: `review-ready, merge, release, deploy, paid/live,
  destructive cleanup, and ownership changes`

Preserve unrelated changes. Do not stash, reset, clean, broadly format, stage,
push, merge, publish, deploy, or delete remote state without authority.

## 3. Scope and architecture

- Product scope authority: `<file>`
- Architecture authority: `<file>`
- Roadmap authority: `<file>`
- Current status authority: `<file, work item, or change request>`
- Current mainline and phase authority: `<roadmap or product file>`
- Temporary-track exit and return authority: `<handoff, work item, or roadmap>`
- Canonical implementation seams: `<modules or services>`
- Explicit non-goals: `<project-specific boundaries>`

Do not add adjacent features, speculative abstractions, dependencies, public
plugin systems, compatibility layers, or generated scaffolding unless required.

Select near-term work items only from the current phase's unmet exit
conditions. Derive optional WPs from the approved work-item outcome and
acceptance. Mark other findings as bounded limitations or future roadmap work.
After a temporary track meets its exit condition, close it and return to its
recorded target instead of continuing adjacent infrastructure work.

A larger capability or task may use optional ordered work packages. Derive each
WP from an observable product, architecture, migration, research, or
operational slice; do not split every feature into generic implementation,
testing, recovery, and documentation phases. Each WP owns its own verification.
Do not require WP labels for a simple outcome. Keep one WP active, and continue
between listed WPs without asking only when standing authority and the next
entry gate cover the transition. Stop for an unlisted, invalidated, or
materially changed WP.

## 4. Security and privacy

- `<deterministic authorization boundary>`
- `<credential and secret handling rule>`
- `<private data and evidence rule>`
- `<unknown-result and recovery rule>`

Use reserved example domains and IP ranges. Keep real infrastructure, user data,
raw logs, credentials, and private paths out of source control, work items,
change requests, and docs.

## 5. Verification

Focused checks:

```text
<commands>
```

Full applicable gate:

```text
<command>
```

Visual, device, migration, deployment, or privacy checks:

```text
<commands or evidence requirements>
```

Report exact commands and results. Mark unperformed checks `NOT_RUN` with the
reason. Lower-level evidence does not prove real-device or production behavior.
For user-visible behavior, actively perform the real workflow when an
appropriate environment is available; automated tests alone are insufficient.

## 6. Delivery mapping

- Work-item system: `<Issue, ticket, card, or equivalent>`
- Change-request system: `<PR, MR, review, or equivalent>`
- Work-package template: `<path>`
- Parent-item/WP/branch/review mapping: `<rule>`
- Status-update owner: `<handoff, tracker, or equivalent>`

Follow the installed maintainer workflow. Do not ask again for transitions
covered by standing authority, and always request the fresh approvals above.

## 7. Handoff

Report the outcome, changed files, exact branch and HEAD, checks passed, checks
not run, compatibility and privacy impact, remaining risks, and one safest next
action. Keep transient status in `<handoff location>` and durable facts in their
authority documents.
