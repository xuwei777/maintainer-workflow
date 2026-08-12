# Project profiles

Use a thin repository profile to raise or specialize the generic workflow.
Keep current status in work items, change requests, or a short handoff
document, never here.

## What belongs in a repository profile

- authority documents and their precedence;
- architecture seams and module ownership;
- branch prefix, target rules, and release line;
- exact focused and full verification commands;
- project-specific privacy and security boundaries;
- device, deployment, migration, or live-acceptance gates;
- standing authority for work-item, branch, push, and draft-review transitions;
- fresh approvals retained for review-ready, merge, release, deploy, and live operations;
- current-mainline, temporary-track exit, and return-target ownership;
- handoff location and maximum useful scope.

Do not copy product roadmaps, live branch names, current blockers, secrets,
internal hosts, or temporary test results into a reusable Skill.

## Standard application profile

Use this for ordinary applications and services:

1. Treat the public default branch as the canonical baseline.
2. Let a parent work item own a larger capability or task. Optionally use
   ordered work packages for independently acceptable slices; do not require
   them for a simple outcome.
3. Record whether each package gets a child work item, branch, and review or
   remains in the parent. Prefer separate delivery when a package has its own
   acceptance or can change later package decisions.
4. Require focused tests for behavior changes and one full applicable gate
   before release.
5. Keep generated output, local configuration, credentials, and environment
   evidence outside commits.
6. Require explicit approval for push, merge, release, deployment, and real
   external writes when the owner has not already granted them.

## Mainline and delivery profile

Define these fields for projects with a roadmap or more than one active track:

- `current_mainline`: the product outcome that selects near-term work;
- `current_phase`: entry gate, exit condition, and required evidence;
- `temporary_track`: a bounded migration, recovery, or compatibility detour;
- `return_target`: the mainline resumed immediately after the detour closes;
- `active_work_item`: the cohesive deliverable currently in delivery;
- `active_work_package`: its optional current execution slice.

Assign one owner to each planning fact:

| Fact | Authority |
| --- | --- |
| Product outcome and non-goals | Product or charter document |
| Long-term phases, order, entry/exit and revisit gates | Roadmap |
| Current mainline, phase, temporary track, return target and one next action | Short current-status or handoff document |
| One cohesive deliverable and its optional ordered slices | Work item and WP record |
| Diff, review discussion and delivery evidence | Change request |
| Completed history | Git and closed tracker records |

Keep the roadmap durable and the current-status document replaceable. Do not
copy volatile branch names or daily progress into the roadmap, and do not let a
handoff redefine product scope.

Map neutral workflow terms to the repository's collaboration system:

```text
work item       = Issue | ticket | card | equivalent
change request  = pull request | merge request | review | equivalent
draft           = the platform's non-merge-ready review state
review-ready    = the platform's explicit request-for-final-review state
```

Record the exact standing-authority boundary and retained approvals in the
repository profile. Standing authority is bounded delegation, not permanent
permission for unrelated work.

### Optional work packages under a parent work item

Use this as a default shape, not a universal requirement:

```text
one larger capability, task, or direction
  -> zero or more ordered, independently acceptable work packages
  -> delivery records, branches, and reviews according to repository policy
```

Do not create a universal sequence such as foundation, core implementation,
tests, recovery, and docs. Instead, slice on observable product behavior,
architecture ownership, migrations, research questions, or operational
outcomes. Every package includes its own success, failure, recovery, and
verification evidence.

Repositories may use a child work item plus one branch and draft review per
package, or keep small slices in the parent. Decision-gated research may
authorize only the first package because its evidence can invalidate later
ones. Record this mapping and gate policy instead of assuming one shape.

Let standing authority cover transitions between explicitly named packages
only when their entry gates remain true. Keep one package active at a time,
verify it before continuing, and stop for any unauthorized, invalidated, or
materially changed package.

Skip formal packages for a small outcome. Prefer separate delivery when slices
can ship or roll back independently, cross safety or ownership boundaries, or
make a combined review incoherent. Repository rules may choose another mapping.

## High-assurance stateful profile

Raise the workflow when a project controls durable state, authorization,
remote execution, or safety-sensitive automation:

- Untrusted input may propose an action but cannot grant authority.
- Put authorization, ownership, and policy in deterministic code.
- Revalidate permission and target identity immediately before side effects.
- Separate proposal, approval, execution, observation, and durable outcome.
- Persist an immutable action identity for approved writes.
- Never automatically replay an uncertain write.
- Prove duplicate, conflict, rollback, restart, cancellation, and recovery paths.
- Treat synthetic integration as rehearsal, not production acceptance.
- Pin the exact reviewed revision before any deployment or ownership change.
- Require a separate go or no-go decision for production cutover.

## Device or visual profile

Add these rules when behavior depends on a real device or rendered UI:

- Separate source checks, automated tests, emulator evidence, real-device
  evidence, and production behavior.
- Render or capture both primary and constrained layouts for visual changes.
- Compare against the agreed reference criteria, not personal memory.
- Do not call a build successful because the process launched.
- Keep device identifiers, screenshots with personal data, and raw captures out
  of the repository unless explicitly sanitized for publication.

## Profile conflicts

Repository rules may make this workflow stricter. They must not silently grant
more authority than the user or runtime policy. If an authority document and
the live repository disagree, stop and resolve ownership instead of creating a
second source of truth.
