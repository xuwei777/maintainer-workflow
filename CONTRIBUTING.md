# Contributing

Keep contributions focused on observable agent behavior.

1. Open an Issue for a behavioral change or new compatibility claim.
2. Change the smallest relevant Skill, reference, template, or script.
3. Do not add private project details, volatile status, real infrastructure,
   credentials, user data, or copied proprietary policies.
4. Run:

   ```powershell
   pwsh -File scripts/check.ps1
   npx -y skills@latest add . --list
   git diff --check
   ```

5. In the pull request, state the behavior changed, checks run, checks not run,
   and any compatibility or privacy impact.

New tool-specific wrappers need evidence that the target agent cannot consume
the standard Skill through the `skills` CLI. Prefer documentation over another
installer.
