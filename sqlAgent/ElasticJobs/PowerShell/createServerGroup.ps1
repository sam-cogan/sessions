Write-Output "Creating test target groups..."
$jobAgent= Get-AzureRmSqlElasticJobAgent -ResourceGroupName "SQLAgentDemos" -ServerName "SQLAgentDemo" -Name "DemoJobAgent"
# Create ServerGroup target group
$TargetServerName="sqlagentdemo.database.windows.net" 
$MasterCredName="mastercred"
$ServerGroup = $JobAgent | New-AzureRmSqlElasticJobTargetGroup -Name 'ServerGroup1'
$ServerGroup | Add-AzureRmSqlElasticJobTarget -ServerName $TargetServerName -RefreshCredentialName $MasterCredName
$ServerGroup | Add-AzureRmSqlElasticJobTarget -ServerName $TargetServerName  -Database "demojobagent" -Exclude
