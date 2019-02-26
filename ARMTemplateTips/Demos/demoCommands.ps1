


### 3_Outputs
New-AzureRmResourceGroupDeployment -Name "3_outputs_1" -ResourceGroupName "igniteARMDemos" -TemplateFile .\3_Outputs\simpleOutput.json
$x=New-AzureRmResourceGroupDeployment -Name "3_outputs_2" -ResourceGroupName "igniteARMDemos" -TemplateFile .\3_Outputs\objectOutput.json
$y= [Newtonsoft.Json.JsonConvert]::SerializeObject($x.Outputs.publicIP.value, [Newtonsoft.Json.Formatting]::Indented) | ConvertFrom-Json
New-AzureRmResourceGroupDeployment -Name "3_outputs_3" -ResourceGroupName "igniteARMDemos" -TemplateFile .\3_Outputs\Variables.json

### 4_NestedTemplates

$x=New-AzureRmResourceGroupDeployment -Name "4_nested_1" -ResourceGroupName "crossSubscriptionDeployment" -TemplateFile .\4_NestedTemplates\2_cross_sub\CrossSubscriptionDeployments.json -TemplateParameterFile .\4_NestedTemplates\2_cross_sub\CrossSubscriptionDeployments.parameters.json

### 6_conditions

New-AzureRmResourceGroupDeployment -Name "6_conditions_1" -ResourceGroupName "igniteARMDemos" -TemplateFile .\6_Conditions\if.json -TemplateParameterFile .\6_Conditions\if.params.json

### 8_sublevel

New-AzureRmDeployment -Name "8_sublevel_01" -Location "West Europe" -TemplateFile .\8_SubLevelDeployments\template.json -TemplateParameterFile .\8_SubLevelDeployments\template.parameters.json