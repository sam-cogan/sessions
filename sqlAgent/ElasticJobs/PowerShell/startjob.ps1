# $jobName="CreateTablePS"

# $jobexecution= Start-AzureRmSqlElasticJob -JobName $jobName -ResourceGroupName "SQLAgentDemos" -ServerName "SQLAgentDemo" -AgentName "DemoJobAgent"
# $jobexecution


$jobName="GetFragmentation"

$jobexecution= Start-AzureRmSqlElasticJob -JobName $jobName -ResourceGroupName "SQLAgentDemos" -ServerName "SQLAgentDemo" -AgentName "DemoJobAgent"
$jobexecution