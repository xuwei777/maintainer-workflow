# Maintainer Workflow

> **Make your coding agent finish repository work like a maintainer—not just write code.**

[![Agent Skill](https://img.shields.io/badge/Agent%20Skill-portable-111111?style=flat-square)](https://agentskills.io/)
[![Install with skills](https://img.shields.io/badge/install%20with-skills-111111?style=flat-square)](https://github.com/vercel-labs/skills)
[![License: MIT](https://img.shields.io/badge/license-MIT-111111?style=flat-square)](LICENSE)
[![English](https://img.shields.io/badge/docs-English-111111?style=flat-square)](README.md)
[![简体中文](https://img.shields.io/badge/文档-简体中文-111111?style=flat-square)](README.zh-CN.md)

A portable Agent Skill that keeps coding work on the correct branch, inside
the approved scope, and moving through optional, verifiable work packages to
real acceptance. It follows the Agent Skills format and installs through the
`skills` CLI for Codex, Claude Code, Cursor, Qoder, and other skill-capable
coding agents.

**Small by design. Strict where it matters.** The entire package is one
portable Skill, one read-only preflight, and two optional templates—no
framework, daemon, bot, or project-management runtime.

## Install in one command

```shell
npx skills add xuwei777/maintainer-workflow --skill maintainer-workflow -g
```

Then start a new agent session and ask:

```text
Use $maintainer-workflow to inspect and continue this repository task.
```

## Why install it?

Coding agents rarely fail because they cannot write code. They fail because
they start from stale state, choose an interesting gap instead of the current
goal, expand the scope, trust mocked tests too much, or declare victory before
the real workflow has been exercised.

Maintainer Workflow changes the default behavior:

| Without the Skill | With Maintainer Workflow |
| --- | --- |
| Trust the current folder or an old handoff | Reconcile live Git, work items, reviews, and runtime state first |
| Pick work from visible code gaps | Derive the next slice from the active outcome and unmet exit gate |
| Turn a feature into a generic implementation checklist | Use optional work packages that each deliver an observable result |
| Treat green tests as completion | Separate static, mocked, synthetic, isolated, and live evidence |
| Keep coding after the requested outcome is met | Stop at the exit condition and return to the recorded mainline |
| Infer permission to merge or deploy | Require fresh approval for Ready, merge, release, deploy, and live actions |

It makes the agent act like the maintainer who owns the repository after this
task—not a code generator optimizing for apparent completion.

## How it works

```text
Orient  →  Bound  →  Execute  →  Verify  →  Handoff
```

| Step | Maintainer behavior |
| --- | --- |
| **Orient** | Confirm the real repository, branch, HEAD, upstream, dirty work, active task, and available environment |
| **Bound** | Lock the observable outcome, non-goals, interfaces, authority, risk, and stop condition |
| **Execute** | Change the smallest eligible slice through the repository's existing ownership boundaries |
| **Verify** | Match evidence to risk, including the real user or operator flow when available |
| **Handoff** | Report the exact reviewed HEAD, checks, `NOT_RUN` items, remaining risks, and one safest next action |

## The work-package idea

One parent work item may own a larger capability. Split it only when real
product, architecture, migration, research, or operational seams make the work
easier to verify.

```text
Parent outcome: users can import a CSV safely

WP1  Preview parsed rows and explain invalid records
WP2  Confirm an idempotent import without duplicate writes
WP3  Download failed rows and retry only those records
```

Each WP has its own success, failure, recovery, and real acceptance evidence.
There is no separate “tests WP” or mandatory `foundation → core → docs`
pipeline. A simple task needs no WP labels at all.

The exact package sequence may continue without repeated confirmation only
when the owner has authorized it and the next entry gate is still true. If an
earlier result invalidates a later package, the agent stops or replans instead
of mechanically completing the old checklist.

## Three operating modes

| Mode | Use it when | What the agent does |
| --- | --- | --- |
| **Bootstrap** | A repository has no useful governance | Inspect the stack, propose the smallest rules and verification commands, then wait before writing them |
| **Adopt** | Development already exists but status is unclear | Reconcile Git and fact sources, recover the mainline and active work, and surface conflicts instead of guessing |
| **Deliver** | The current work item and authority are clear | Carry the smallest eligible slice through implementation, automated checks, real acceptance, review, and accurate handoff |

## What it enforces

- live repository orientation before editing;
- one current mainline, bounded temporary tracks, and explicit return targets;
- observable outcomes, non-goals, locked interfaces, and proportional risk;
- preservation of unrelated user changes;
- deterministic authorization for side effects;
- bounded subagent delegation with primary-agent review;
- privacy checks across the complete publish range;
- real or manual acceptance for user-visible behavior when an environment is
  available;
- exact commands, reviewed HEAD, `NOT_RUN` items, risks, and one safest next
  action in every handoff.

## What it does not do

Installing this Skill does **not** create an `AGENTS.md`, roadmap, Issue,
branch, hook, bot, service, commit, or pull request. It does not merge, release,
deploy, or perform destructive cleanup on its own.

When a repository has no rules, the Skill proposes a small, tailored profile
based on the bundled
[`AGENTS.md` template](skills/maintainer-workflow/assets/AGENTS.template.md)
and waits for repository-write authorization. It is a portable instruction set,
not a project-management framework or security sandbox.

## Installation options

Install globally for the current user:

```shell
npx skills add xuwei777/maintainer-workflow --skill maintainer-workflow -g
```

Install only in the current project:

```shell
npx skills add xuwei777/maintainer-workflow --skill maintainer-workflow
```

Inspect the package without installing:

```shell
npx skills add xuwei777/maintainer-workflow --list
```

Use the full Git URL when preferred:

```shell
npx skills add https://github.com/xuwei777/maintainer-workflow.git --skill maintainer-workflow -g
```

The [`skills` CLI](https://github.com/vercel-labs/skills) requires Node.js 18
or newer and installs to the agent selected during setup. Agents without Skill
support can read
[`SKILL.md`](skills/maintainer-workflow/SKILL.md) directly and adopt the
templates manually.

## FAQ

**Does it force Issues or work packages on every task?**

No. Formal WPs are optional. Small work stays small; larger work is split only
where an independently acceptable result improves sequencing or verification.

**Will it create or replace my `AGENTS.md`?**

No. Repository rules override this generic Skill. When useful governance is
missing, it proposes a thin project profile and waits for authorization before
writing it.

**Does it replace CI, tests, or project documentation?**

No. CI and tests provide evidence; project documents own project facts. The
Skill governs how an agent reads those facts, chooses work, matches evidence to
risk, and reports what remains unverified.

**Will it slow down small fixes?**

It is proportional. A small, local change does not need an invented roadmap,
formal WP sequence, or production-style ceremony.

**Is it Codex-only?**

No. It follows the portable Agent Skills format and is distributed through the
cross-agent `skills` CLI. Host-specific behavior still depends on the target
agent's Skill support.

## Package contents

```text
skills/maintainer-workflow/
├── SKILL.md                         # agent-facing workflow
├── agents/openai.yaml               # Skill UI metadata
├── assets/AGENTS.template.md        # thin repository profile
├── assets/work-package.template.md  # parent item and optional WP contract
├── references/project-profiles.md   # profile variants and authority mapping
└── scripts/preflight.ps1            # read-only Windows Git preflight
```

## Development

```powershell
pwsh -File scripts/check.ps1
npx -y skills@latest add . --list
git diff --check
```

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution rules and
[SECURITY.md](SECURITY.md) for safe reporting. Licensed under the
[MIT License](LICENSE).
