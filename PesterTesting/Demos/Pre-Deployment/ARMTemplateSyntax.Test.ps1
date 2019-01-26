param(
    [string]$templatefolder = '.'
)

$templateFiles = Get-ChildItem -Path $templatefolder\* -Filter "*.json" -recurse -File | Where-Object -FilterScript {(Get-Content -Path $_.FullName -Raw) -ilike "*schema.management.azure.com/*/deploymentTemplate.json*"}

foreach ($templateFile in $templateFiles) {
    Describe "Testing Template Content: $templateFile" -Tag 'PreDeployment' {
        $templateContents = get-content $templatefile
        try {
            $templateProperties = ($templateContents  | ConvertFrom-Json )
        }
        catch {
            $ErrorMessage = $_.Exception.Message
        }

        Context "Template Syntax" {

            It "should be less than 1 Mb" {
                Get-Item $templateFile| Select-Object -ExpandProperty Length | Should -BeLessOrEqual 1073741824
            }
      
            It "Converts from JSON" {
                $ErrorMessage | Should -BeNullOrEmpty
            }

       
        

            $missingBrackets = 0
            For ($i = 0; $i -lt $templateContents.Length; $i++) {
                $Matches = [System.Text.RegularExpressions.Regex]::Matches($templateContents[$i], "\"".*\""")
          
                ForEach ($Match In $Matches) {
                    $SquarePairCharNumber = ($Match.Value.Length - $Match.Value.Replace("[", "").Replace("]", "").Length) % 2
                    $ParenthesisPairCharNumber = ($Match.Value.Length - $Match.Value.Replace("(", "").Replace(")", "").Length) % 2
          
                    if ($SquarePairCharNumber -ne 0 -or $ParenthesisPairCharNumber -ne 0) {
                        $missingBrackets++
            
                        It "should have same amount of opening and closing  brackets (Line $($i + 1))" {
                            $PairCharNumber | Should -Be 0
                        }
          
                        break
                    }
                }
            }
            It "Should have no missing bracket pairs" {
                $missingBrackets | Should -Be 0
            }


   
        }

        Context "Template Structure" {

            It "should have a `$schema section" {
                $templateProperties."`$schema" | Should -Not -BeNullOrEmpty
            }
      
            It "should have a contentVersion section" {
                $templateProperties.contentVersion | Should -Not -BeNullOrEmpty
            }
      
            It "should have a parameters section" {
                $templateProperties.parameters | Should -Not -BeNullOrEmpty
            }
          
          
            It "should have a variables section" {
                $templateProperties."variables" | Should -Not -BeNullOrEmpty
            }

          
            It "should have a outputs section" {
                $templateProperties."outputs" | Should -Not -BeNullOrEmpty
            }
            It "should have less than 256 parameters" {
                $templateProperties.parameters.Length | Should -BeLessOrEqual 256
            }

        }

        Context "Parameter and Variable Checks" {

            $parametersUsage = [System.Text.RegularExpressions.RegEx]::Matches($templateContents, "parameters(\(\'\w*\'\))") | Select-Object -ExpandProperty Value -Unique
            Context "Referenced Parameters" {
                ForEach ($parameterUsage In $parametersUsage) {
                    $parameterUsage = $parameterUsage.SubString($parameterUsage.IndexOf("'") + 1).Replace("')", "")
              
                    It "should have a parameter called $parameterUsage" {
                        $templateProperties.parameters.$parameterUsage | Should -Not -Be $null
                    }
                }
            }
          
            $variablesUsage = [System.Text.RegularExpressions.RegEx]::Matches($templateContents, "variables(\(\'\w*\'\))") | Select-Object -ExpandProperty Value -Unique
            Context "Referenced Variables" {
                ForEach ($variableUsage In $variablesUsage) {
                    $variableUsage = $variableUsage.SubString($variableUsage.IndexOf("'") + 1).Replace("')", "")
                
                    It "should have a variable called $variableUsage" {
                        $templateProperties.variables.$variableUsage | Should -Not -Be $null
                    }
                }
            }

        }
    }

}

