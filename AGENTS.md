# Maintainer Workflow repository agreement

This repository distributes one portable Agent Skill. Keep it small, public,
and vendor-neutral.

## Before editing

Run:

```powershell
git status --short --branch
git remote -v
git branch -vv
```

Read `README.md`, the affected file under `skills/maintainer-workflow/`, and
the current Issue when one exists. Preserve unrelated changes and stop when
the branch, Issue, or working tree disagrees with the task.

## Scope

- Put agent-facing instructions in `skills/maintainer-workflow/SKILL.md`.
- Put optional detail in a directly linked `references/` file.
- Put reusable output templates in `assets/` and deterministic helpers in
  `scripts/`.
- Keep repository-facing installation and contribution guidance at the root.
- Do not add a framework, package manager, generated site, or compatibility
  wrapper unless a verified installer requires it.
- Do not include private project names, internal hosts, credentials, real
  deployment paths, user data, or volatile project status.

## Verification

Documentation and Skill changes use:

```powershell
pwsh -File scripts/check.ps1
npx -y skills@latest add . --list
git diff --check
```

Report exactly what ran. Publishing, tagging, merging, and pushing require
explicit owner authorization.
