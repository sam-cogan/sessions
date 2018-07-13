$resourceGroup="SQLAgentDemos" 
$ServerName= "SQLAgentDemo" 
$AgentName= "DemoJobAgent"

Get-AzureRmSqlElasticJob -ResourceGroupName $resourceGroup -ServerName $ServerName -AgentName $AgentName | Remove-AzureRmSqlElasticJob -Force

Remove-AzureRmSqlElasticJobTargetGroup -Name ServerGroup1 -ResourceGroupName $resourceGroup -ServerName $ServerName -AgentName $AgentName -Force

Get-AzureRmSqlElasticJobCredential  -ResourceGroupName $resourceGroup -ServerName $ServerName -AgentName $AgentName | Remove-AzureRmSqlElasticJobCredential 
