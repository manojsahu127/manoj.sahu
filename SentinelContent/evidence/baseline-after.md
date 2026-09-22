# UEBA parser POV — baseline after deployment

- Workspace: `<your-Sentinel-workspace-name>`
- Query run date/time: `<date and time>`
- Query range: Previous 7 days
- Branch: `Develop`
- Deployment status: Successful

## Deployed functions

- `PovUebaIdentityAuth`
- `PovUebaPrivilegedProcess`

## Identity parser validation query

```kql
PovUebaIdentityAuth()
| where TimeGenerated > ago(7d)
| summarize
    Events = count(),
    Users = dcount(AccountUPN),
    SourceIPs = dcount(IPAddress),
    FailedSignIns = countif(AuthResult == "Failure")
```

## Identity parser results

| Metric | Value |
|---|---:|
| Events | `284` |
| Users | `8` |
| Source IPs | `24` |
| Failed sign-ins | `31` |

## Schema validation

`PovUebaIdentityAuth()` returned the expected fields:

- `TimeGenerated`
- `AccountUPN`
- `AccountName`
- `IPAddress`
- `AppName`
- `AuthResult`

`PovUebaPrivilegedProcess()` returned the expected fields:

- `TimeGenerated`
- `AccountUPN`
- `DeviceName`
- `FileName`
- `ProcessIntegrityLevel`

## Comparison with baseline before deployment

- Event count difference: `<same / expected difference and explanation>`
- User count difference: `<same / expected difference and explanation>`
- Source IP count difference: `<same / expected difference and explanation>`
- Failed-sign-in count difference: `<same / expected difference and explanation>`

## Dependent-query test results

- Identity failed-authentication hunt: `<Passed / Failed>`
- Privileged-process hunt: `<Passed / Failed>`
- Identity-to-process correlation query: `<Passed / Failed>`

## Conclusion

The deployed UEBA parsers executed successfully and dependent queries `<continue to execute / require follow-up>`.
