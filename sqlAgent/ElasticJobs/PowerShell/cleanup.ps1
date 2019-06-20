$resourceGroup="SQLAgentDemos" 
$ServerName= "SQLAgentDemo" 
$AgentName= "DemoJobAgent"

Get-AzSqlElasticJob -ResourceGroupName $resourceGroup -ServerName $ServerName -AgentName $AgentName | Remove-AzSqlElasticJob -Force

Remove-AzSqlElasticJobTargetGroup -Name ServerGroup1 -ResourceGroupName $resourceGroup -ServerName $ServerName -AgentName $AgentName -Force

Get-AzSqlElasticJobCredential  -ResourceGroupName $resourceGroup -ServerName $ServerName -AgentName $AgentName | Remove-AzSqlElasticJobCredential 
