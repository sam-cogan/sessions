Write-Output "Creating test target groups..."
# Create ServerGroup target group
$TargetServerName="sqlagentdemo" 
$MasterCred=get-azurermsqle
$ServerGroup = $JobAgent | New-AzureRmSqlElasticJobTargetGroup -Name 'ServerGroup1'
$ServerGroup | Add-AzureRmSqlElasticJobTarget -ServerName $TargetServerName -RefreshCredentialName $MasterCred.CredentialName