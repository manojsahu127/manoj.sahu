param workspaceName string = 'PhilipsSentinelPOC'

resource workspace 'Microsoft.OperationalInsights/workspaces@2020-08-01' existing = {
  name: workspaceName
}

resource parser 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: workspace
  name: 'PovUebaPrivilegedProcess'
  properties: {
    category: 'UEBA POV / Parsers'
    displayName: 'POV UEBA Privileged Process Parser'
    functionAlias: 'PovUebaPrivilegedProcess'
    functionParameters: ''
    version: 1
    query: '''
DeviceProcessEvents
| where isnotempty(AccountUpn)
| extend
    AccountUPN = tolower(tostring(AccountUpn)),
    DeviceName = tostring(DeviceName),
    FileName = tostring(FileName),
    ProcessCommandLine = tostring(ProcessCommandLine),
    ProcessIntegrityLevel = tostring(ProcessIntegrityLevel)
| project
    TimeGenerated,
    AccountUPN,
    DeviceName,
    FileName,
    ProcessCommandLine,
    ProcessIntegrityLevel,
    FolderPath,
    InitiatingProcessFileName,
    InitiatingProcessCommandLine,
    SHA1,
    ReportId
'''
  }
}


