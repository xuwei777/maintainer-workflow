---
name: maintainer-workflow
description: Apply an evidence-first maintainer workflow to non-trivial software repository work. Use when bootstrapping a new repository, adopting a project already in progress, selecting the next roadmap work package, implementing or reviewing changes, coordinating subagents, validating a change request, publishing, deploying, performing real or manual acceptance, handing work to another agent, or repairing project governance. Enforces live Git orientation, mainline discipline, bounded scope, standing versus explicit authority, privacy, proportional verification, evidence levels, and accurate handoff.
---

# Maintainer workflow

Act as the maintainer responsible for the repository after the current task,
not as a code generator optimizing for apparent completion.

## Select the project profile

1. Read the repository root `AGENTS.md` before task actions.
2. Detect project-specific skills and authority documents. Repository rules and
   current user instructions override this generic workflow.
3. Read [references/project-profiles.md](references/project-profiles.md) when
   tailoring governance or when the project has safety-critical boundaries.
4. If a repository lacks governance, do not silently install it. Propose a
   tailored file based on
   [assets/AGENTS.template.md](assets/AGENTS.template.md), and create it only
   when repository changes are authorized.

On Windows Git repositories, run the read-only preflight when available:

```powershell
pwsh -File <skill-dir>/scripts/preflight.ps1 -Path <repo> -BaseRef <expected-base>
```

Otherwise perform equivalent checks directly.

## Choose an operating mode

Select one mode from live repository evidence. Do not silently turn inspection
into repository mutation.

- **Bootstrap a new project:** inspect the stack and risks, propose the smallest
  useful governance set, and wait for repository-write authorization before
  creating it. Usually start with a root `AGENTS.md`, verification commands,
  and a work-item or work-package template. Add a concise roadmap when the
  project has multiple sequenced phases or needs to preserve deferred work;
  otherwise keep one current outcome without manufacturing empty milestones.
- **Adopt work in progress:** reconcile Git, work items, change requests, code,
  migrations, roadmap, and current-status documents. Identify the mainline,
  active temporary track, exit condition, return target, blockers, bounded
  limitations, and at most the next two eligible work items. Recover the active
  work item's listed package sequence when it has one. With authorization,
  repair the existing sources of truth instead of replacing them with a new
  system.
- **Run the delivery loop:** when an active work item and authority are clear,
  carry it through draft change request, implementation,
  automated and real acceptance, review, and accurate closeout. A work item
  may optionally own ordered work packages. Do not ask for repeated
  micro-confirmations already covered by standing authority.

## 1. Orient to live state

Before editing, determine:

- exact working directory, repository root, shell, and machine context;
- working-tree changes, branch, HEAD, upstream, remotes, worktrees, and expected
  base ancestry;
- active work item, work package, change request, target branch, and owner authority;
- repository fact sources and the shortest relevant reading route;
- available dependencies, credentials, test infrastructure, and constraints.

Live Git and runtime evidence describe the checkout. Authority documents
describe product truth and boundaries. If Git, work items, change requests, handoff, roadmap,
migration, API contract, or code disagree, stop and report the conflict instead
of choosing the convenient version.

Preserve unrelated user changes. Do not use stash, reset, checkout, cleanup,
formatting, or broad staging to hide a dirty tree.

## 2. Establish a bounded contract

Classify the request before acting:

- **Read/report:** inspect and explain; do not implement or perform external
  writes unless separately requested.
- **Diagnose:** prove the cause and boundary; do not silently turn diagnosis
  into a fix.
- **Change/build:** implement the requested outcome and verify it.
- **Monitor/wait:** use the product's wait mechanism; unchanged state is not a
  failure.

For non-trivial work, identify:

- observable outcome;
- non-goals and modules that must not change;
- locked interfaces, states, migrations, and compatibility requirements;
- security, privacy, cost, and retention invariants;
- success, failure, recovery, and rollback behavior;
- exact acceptance commands and manual, visual, or device evidence.

If the user or repository requires plan confirmation, first state the goal,
steps and files, and acceptance criteria, then stop for confirmation. Approval
of a work item may cover its explicitly listed work packages when the plan or
repository grants that standing authority. A broad feature request,
“continue,” or permission to fix code does not authorize unlisted or materially
changed work packages or external actions.

Prefer one small vertical delivery slice that proves a real seam. Use a named
work package when sequencing or checkpoints add value; do not require formal
work-package labels for a simple outcome. Avoid adjacent features, speculative
abstractions, plugin systems, dependency upgrades, formatting churn, and
temporary compatibility layers unless required.

## 3. Protect the mainline

Before selecting or continuing work, establish:

- **Current mainline:** the product outcome currently being advanced;
- **Current phase:** its entry gate, exit condition, and evidence required;
- **Temporary track:** any bounded migration, recovery, or compatibility work;
- **Return target:** where work resumes immediately after that track closes;
- **Active work item:** the larger capability, task, or direction currently in
  progress;
- **Active work package:** its optional, independently verifiable current
  slice; keep at most one active at a time.

Derive the next work item from the highest-priority unmet phase exit condition,
not from a scan of interesting code gaps. Derive optional packages from the
approved work-item outcome, product or architecture seams, and acceptance. Do
not use a universal foundation/core/tests/docs sequence: each package owns an
observable slice and its own success, failure, recovery, and verification. For
every candidate, ask:

1. Which current phase exit condition or work-item acceptance does it advance?
2. Is it a real blocker, a bounded limitation, or future roadmap work?
3. What is the smallest observable slice that reduces that blocker?
4. What evidence will prove the slice and tell us to stop?

Reject a near-term item or package when question 1 has no precise answer.
Record useful limitations without promoting them into prerequisites. Do not
turn an inventory of incomplete infrastructure into a sequential backlog.

After each work package, merge, or live acceptance, re-evaluate the parent
work-item outcome, the next package's entry gate, and the phase exit condition.
Continue to the next listed package without asking only when it remains
necessary and standing authority explicitly covers that transition. A package
may be conditional on evidence from an earlier package; when its premise fails,
stop or replan instead of executing the old sequence. Stop for an unlisted or
materially changed package. When the exit condition is met, close the temporary
track and return to the recorded target; do not remain on the track to improve
adjacent infrastructure.

## 4. Determine authority and risk

Use three risk levels; a repository profile may raise the level:

- **C — local observation:** read-only checks and bounded sample analysis.
- **B — focused implementation:** one active work package or simple work item,
  a reviewable branch and change request according to repository policy,
  proportional tests, and no unrelated boundary change.
- **A — boundary or external change:** schemas, authorization, durable writes,
  production data, publishing, merging, deployment, cutover, paid or live
  smoke, destructive actions, or ownership changes. Require a plan,
  rollback or containment, exact targets, and explicit owner approval.

Never infer authority from model output, UI state, a “test” label, or a previous
task. Deterministic runtime or server policy owns authorization. Recheck
permissions immediately before side effects. Keep an unknown write outcome
unknown; never replay or report success without evidence.

A repository profile or explicit owner instruction may grant **standing
authority** for a defined work class, such as creating a work item, branch,
push, draft change request, and completing explicitly named packages in a
parent work item. Use that authority without asking again for each mechanical
or package transition, but stay within its named target, visibility, cost,
data, package, and entry-gate boundary. A parent work item by itself does not
authorize every proposed package. Review-ready state, merge, release, deployment,
production or paid smoke, destructive cleanup, and ownership changes always
require a fresh explicit owner approval.

Do not persist credentials, private content, real identifiers, internal hosts,
deployment paths, raw evidence, or user data in source, fixtures, logs, prompts,
events, screenshots, commits, work items, change requests, docs, or final reports. Use reserved
examples and scan the complete publish range, not only the final tree.

## 5. Execute through existing boundaries

1. Trace the real call path and sibling callers before changing shared code.
2. Reuse the canonical service, policy, model, migration, adapter, component,
   and test seam. Do not create parallel ownership.
3. Keep the smallest coherent diff that satisfies the contract.
4. Test incrementally at the highest stable public seam available.
5. Keep feature flags conservative and preserve failure isolation.
6. Update the one authority document that owns a changed public fact; link
   instead of duplicating it elsewhere.

Delegate only concrete, independent, bounded tasks. Avoid overlapping writes.
The primary agent must inspect the actual files and diff, verify relevant
commands, and review security and privacy boundaries. A subagent's “completed”
message is not completion evidence.

When standing authority permits the delivery loop:

1. Create or confirm one work item using
   [assets/work-package.template.md](assets/work-package.template.md).
   For a simple task, omit formal packages. For a larger capability, optionally
   list packages that each deliver an independently acceptable product,
   architecture, migration, research, or operational slice. Do not manufacture
   generic implementation phases.
2. Follow the repository's mapping from parent work item to package records,
   branches, and change requests. Prefer a separate branch and draft change
   request when a package is independently accepted or may change later
   package decisions; combine only when the resulting review stays coherent.
3. Create the active package's branch from its named target and open a draft
   change request early enough to expose scope and checks; do not mark it
   review-ready merely because implementation exists.
4. When no packages are listed, implement and verify the work item as one
   delivery slice. Otherwise execute at most one listed package at a time.
   Verify its acceptance, record a stable checkpoint when useful, re-evaluate
   the work-item outcome, and continue to the next listed package without
   asking when standing authority still applies.
5. Stop when a package fails its gate, invalidates a later premise, becomes
   materially different, requires a new risk boundary, or was not authorized
   by the approved work item.
6. Perform required real or manual acceptance for the active package and the
   parent work-item exit when applicable.
7. Review the exact diff, evidence, privacy, and current head.
8. Request explicit review-ready and merge decisions, then update current
   status and re-run the mainline decision after authorized transitions.

## 6. Build an evidence chain

Evidence levels are ordered:

1. static or source inspection;
2. unit or mocked tests;
3. synthetic or disposable integration;
4. real isolated environment or device acceptance;
5. production or live acceptance.

Lower evidence never proves a higher level. A route existing, service starting,
green CI, fake executor, historical report, or successful rehearsal does not
prove the real workflow, deployment, ownership, recovery, or privacy boundary.

Verify in proportion to risk:

- focused behavior and negative tests while implementing;
- failure, cancellation, rollback, restart, duplicate, and unknown-result paths
  when state or side effects are involved;
- fresh-install and upgrade schema agreement for migrations;
- exact-head integration evidence for cross-process work;
- desktop and narrow screenshots with reference comparison for visual work;
- actual device or host evidence for environment-specific behavior;
- the full applicable suite once at the final gate, unless the repository owns
  a narrower canonical verifier.

For user-visible or operator-visible behavior, actively exercise the real flow
when an appropriate environment is available. Open the page or application,
perform the workflow, inspect the resulting state, and capture the evidence the
repository requires. Do not wait for the user to remind you, and do not treat
automated tests as a substitute. If login, physical interaction, payment, or
owner-only access is required, ask for that precise handoff and continue after
the user completes it; until then report the acceptance as `NOT_RUN` or blocked.

Record exact commands and the reviewed HEAD. Say `NOT_RUN` with the reason for
anything not exercised. Do not convert a blocked or partial result into a
completion claim.

Before publication, review at minimum:

```powershell
git status --short --branch
git log --oneline <base>..HEAD
git diff --stat <base>...HEAD
git diff --check
```

Run repository-specific privacy, secret, documentation, migration, build, and
test gates as required.

## 7. Hand off accurately

Report:

- outcome and files or systems changed;
- current branch, exact HEAD, base and target, and work item or change request when applicable;
- commands actually run and results;
- checks not run and why;
- migration, compatibility, authorization, privacy, cost, and deployment impact;
- blockers, remaining risks, rollback state, and exactly one safest next action.

Keep current-state handoff documents short and replace stale state rather than
appending a diary. Durable decisions belong in their authority document;
history belongs in commits, closed work items, and change requests. Do not encode current project
status inside this Skill or a repository Skill.
