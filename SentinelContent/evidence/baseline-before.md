# UEBA parser POV — baseline before deployment

- Workspace: `<your-Sentinel-workspace-name>`
- Query run date/time: `<date and time>`
- Query range: Previous 7 days
- Branch: `Develop`

## Query

```kql
SigninLogs
| where TimeGenerated > ago(7d)
| summarize
    Events = count(),
    Users = dcount(UserPrincipalName),
    SourceIPs = dcount(IPAddress),
    FailedSignIns = countif(ResultType != "0")
```

## Results

| Metric | Value |
|---|---:|
| Events | `284` |
| Users | `8` |
| Source IPs | `24` |
| Failed sign-ins | `30` |

## Notes

Baseline captured before deploying `PovUebaIdentityAuth`.
