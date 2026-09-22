# UEBA parser POV rollback procedure

## Release

- Branch: `Develop`
- Parsers:
  - `PovUebaIdentityAuth`
  - `PovUebaPrivilegedProcess`
- Hunting query:
  - `PovUebaIdentityRiskHunt`

## Rollback steps

1. Identify the Git commit that introduced the failed parser or hunting-query change.
2. Revert the commit:

   ```bash
   git revert <commit-sha>
   git push origin Develop
