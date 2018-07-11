Write-Output "Creating job agent..."
$AgentName = "sqlDemoAgent"
$JobAgent = $JobDatabase | New-AzureRmSqlElasticJobAgent -Name $AgentName