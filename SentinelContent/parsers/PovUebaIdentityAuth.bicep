param workspaceName string = 'PhilipsSentinelPOC'

resource workspace 'Microsoft.OperationalInsights/workspaces@2020-08-01' existing = {
  name: workspaceName
}

resource parser 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: workspace
  name: 'PovUebaIdentityAuth'
  properties: {
    category: 'UEBA POV / Parsers'
    displayName: 'POV UEBA Identity Authentication Parser'
    functionAlias: 'PovUebaIdentityAuth'
    functionParameters: ''
    version: 1
    query: '''
SigninLogs
| extend
    AccountUPN = tolower(tostring(UserPrincipalName)),
    AccountName = tostring(UserDisplayName),
    IPAddress = tostring(IPAddress),
    AppName = tostring(AppDisplayName),
    AuthResult = iff(ResultType == '0', 'Success', 'Failure')
| project
    TimeGenerated,
    AccountUPN,
    AccountName,
    IPAddress,
    AppName,
    AuthResult,
    ResultType,
    ResultDescription,
    ConditionalAccessStatus,
    LocationDetails
'''
  }
}
