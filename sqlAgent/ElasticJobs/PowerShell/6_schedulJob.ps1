$JobName = "GetFragmentation"
$job= Get-AzSqlElasticJob -Name $jobName -ResourceGroupName "SQLAgentDemos" -ServerName "SQLAgentDemo" -AgentName "DemoJobAgent"
$job | Set-AzSqlElasticJob -IntervalType Day -IntervalCount 1 -StartTime (Get-Date) -Enable