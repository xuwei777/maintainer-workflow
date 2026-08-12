# Parent work item and optional work packages

Use a parent work item for a larger capability, task, or research direction
when decomposition adds value. A simple task does not need formal WP labels.

## Why now

- Current mainline: `<product outcome>`
- Current phase: `<phase>`
- Exit condition advanced: `<one precise unmet gate>`
- Eligibility: `current phase deliverable | exit blocker | authorized temporary track`
- Deferred findings: `<bounded limitations or future items; record only>`

## Parent outcome

Describe the complete observable result or decision this work item owns.

## Invariants and non-goals

- `<product, architecture, compatibility, privacy, or security boundary>`
- `<adjacent capability or future direction excluded>`

## Proposed work packages (optional)

Do not use a generic foundation/core/tests/docs sequence. Name each package by
the observable product, architecture, migration, research, or operational slice
it owns. Every package includes its own verification.

| WP | Observable slice | Entry gate | Independent acceptance | Delivery record |
| --- | --- | --- | --- | --- |
| WP1 | `<bounded result>` | `<precondition>` | `<behavior and evidence>` | `<child item or parent section>` |
| WP2 | `<bounded result>` | `<WP1 evidence or other gate>` | `<behavior and evidence>` | `<child item or parent section>` |

This sequence is a plan, not authority by itself. Record which packages are
authorized and whether later packages are conditional.

## Parent exit criteria

- `<evidence that closes the larger work item>`
- `<condition that stops or replans the remaining sequence>`

## Active package contract

Repeat this contract in a child work item or parent section for the active WP.
For a simple task without WPs, use it for the whole work item.

- Parent work item: `<ID or not applicable>`
- Package: `<WP name or simple work item>`
- Outcome: `<one independently acceptable result>`

### Scope

In:

- `<required behavior or module>`

Out:

- `<adjacent slice or future package>`

Locked interfaces and invariants:

- `<API, state, compatibility, privacy, or security boundary>`

### Acceptance

Success:

- `<positive behavior and exact evidence>`

Failure and recovery:

- `<negative, cancellation, retry, rollback, or unknown-result behavior>`

Automated checks:

```text
<exact focused and applicable full commands>
```

Real or manual acceptance:

- Environment: `<local, isolated, device, staging, production, or not applicable>`
- Workflow: `<steps the agent must actually perform>`
- Evidence: `<state, screenshot, log, metric, or result>`

### Delivery mapping and authority

- Active package record: `<child Issue, parent section, ticket, or equivalent>`
- Branch and change request: `<mapping and target>`
- Standing authority: `<whole simple item or exact listed WPs and actions allowed>`
- Next-package rule: `<pre-authorized transition or fresh decision gate>`
- Change control: `<unlisted, invalidated, or materially changed WPs stop>`
- Fresh explicit approval: `review-ready / merge / release / deploy / live actions`
- Package stop condition: `<evidence that closes this slice>`
- Parent return target: `<mainline or parent phase>`
