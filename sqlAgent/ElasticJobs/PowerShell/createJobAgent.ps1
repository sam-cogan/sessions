Write-Output "Creating job agent..."
$AgentName = "sqlDemoAgent"
$JobAgent = $JobDatabase | New-AzSqlElasticJobAgent -Name $AgentName