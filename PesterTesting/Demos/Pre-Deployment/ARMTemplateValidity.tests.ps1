
param(
    [string]$templatefolder = '..\',
    [string]$validationResourceGroup = "PesterRG",
    [string]$validationResourceGroupRegion = "West Europe"

)

$templateFiles = Get-ChildItem -Path $templatefolder\* -Filter "*.json" -recurse -File | Where-Object -FilterScript {(Get-Content -Path $_.FullName -Raw) -ilike "*schema.management.azure.com/*/deploymentTemplate.json*"}


Describe "Online Template Testing" -Tag 'PreDeployment' {

    BeforeAll {
        $context = $null
        try {$context = Get-AzureRmContext} catch {throw "Not logged into Azure"}
        New-AzureRmResourceGroup -Name $validationResourceGroup -Location $validationResourceGroupRegion -force
    }


    Context "Validate Template" {
        foreach ($templateFile in $templateFiles) {
            $templateContents = get-content $templatefile.FullName
            try {
                $templateProperties = ($templateContents  | ConvertFrom-Json )
            }
            catch {
                $ErrorMessage = $_.Exception.Message
            }
           

            $Parameters = $templateProperties.parameters | Get-Member | Where-Object -Property MemberType -eq -VAlue "NoteProperty" | Select-Object -ExpandProperty Name
            $TemplateParameters = @{}
            ForEach ($Parameter In $Parameters) {
                if (!($templateProperties.parameters.$Parameter.defaultValue)) {
                    if ($templateProperties.parameters.$Parameter.allowedValues) {
                        $TemplateParameters.Add($Parameter, $templateProperties.parameters.$Parameter.allowedValues[0])
                    }
                    else {
                        switch ($templateProperties.parameters.$Parameter.type) {
                            "bool" {
                                $TemplateParameters.Add($Parameter, $true)
                            }
        
                            "int" {
                                if ($templateProperties.parameters.$Parameter.minValue) {
                                    $TemplateParameters.Add($Parameter, $templateProperties.parameters.$Parameter.minValue)
                                }
                                else {
                                    $TemplateParameters.Add($Parameter, 1)
                                }
                            }
        
                            "string" {
                                if ($templateProperties.parameters.$Parameter.minValue) {
                                    $TemplateParameters.Add($Parameter, "a" * $templateProperties.parameters.$Parameter.minLength)
                                }
                                else {
                                    $TemplateParameters.Add($Parameter, "dummy")
                                }
                            }
        
                            "securestring" {
                                $TemplateParameters.Add($Parameter, (convertto-securestring "dummy" -force -AsPlainText))
                            }
        
                            "array" {
                                $TemplateParameters.Add($Parameter, @(1, 2, 3))
                            }
        
                            "object" {
                                $TemplateParameters.Add($Parameter, (New-Object -TypeName psobject -Property @{"DummyProperty" = "DummyValue"}))
                            }
        
                            "secureobject" {
                                $TemplateParameters.Add($Parameter, (New-Object -TypeName psobject -Property @{"DummyProperty" = "DummyValue"}))
                            }
                        }
                    }
                }
            }

            $output = Test-AzureRmResourceGroupDeployment -ResourceGroupName "PesterRG" -TemplateFile $templateFile.FullName @TemplateParameters

            It "$templateFile should be a valid template" {
                $output | Should -BeNullOrEmpty
            }
        }
    }

    AfterAll {
        $context = $null
        try {$context = Get-AzureRmContext} catch {throw "Not logged into Azure"}
        Remove-AzureRMResourceGroup -Name $validationResourceGroup -force
    }

    

}