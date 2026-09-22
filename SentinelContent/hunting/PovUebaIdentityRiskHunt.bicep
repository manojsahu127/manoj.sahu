param workspaceName string = 'PhilipsSentinelPOC'

resource workspace 'Microsoft.OperationalInsights/workspaces@2020-08-01' existing = {
  name: workspaceName
}

resource huntingQuery 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: workspace
  name: 'PovUebaIdentityRiskHunt'
  properties: {
    category: 'Hunting Queries'
    displayName: 'POV UEBA - Repeated Failed Authentication by Account'
    functionAlias: ''
    functionParameters: ''
    version: 1
    query: '''
let Lookback = 24h;
let FailureThreshold = 5;
PovUebaIdentityAuth()
| where TimeGenerated > ago(Lookback)
| where AuthResult == 'Failure'
| summarize
    FailedSignIns = count(),
    SourceIPs = dcount(IPAddress),
    Applications = make_set(AppName, 10),
    FirstSeen = min(TimeGenerated),
    LastSeen = max(TimeGenerated)
  by AccountUPN, AccountName
| where FailedSignIns >= FailureThreshold
| project
    AccountUPN,
    AccountName,
    FailedSignIns,
    SourceIPs,
    Applications,
    FirstSeen,
    LastSeen
| order by FailedSignIns desc
'''
  }
}
