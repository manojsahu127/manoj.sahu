# UEBA parser POV rollback procedure

## Deployed content

- Parser: `PovUebaIdentityAuth`
- Parser: `PovUebaPrivilegedProcess`
- Hunting query: `PovUebaIdentityRiskHunt`

## Rollback steps

1. Identify the commit that introduced the issue.
2. Revert that commit:

   ```bash
   git revert <commit-sha>
   git push origin Develop
   ```

3. Confirm the GitHub Sentinel deployment workflow succeeds.
4. In Sentinel, confirm the previous parser/query logic is restored.
5. Re-run:
   - parser schema checks
   - parser baseline queries
   - dependent hunting-query test
6. Record the rollback commit and validation outcome.

## Important

Do not delete the Bicep file to roll back. Use Git revert so Sentinel redeploys the previous known-good version.
