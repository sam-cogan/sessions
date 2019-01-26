param(
    [string]$templatefolder = '.'
)

$templateFiles = Get-ChildItem -Path $templatefolder\* -Include "*.json" -Exclude "*.parameters.json"

foreach ($templateFile in $templateFiles) {
    Describe "Testing Template: $templateFile" -Tags Template {

        try {
            $templateProperties = (get-content "$templatefile"  | ConvertFrom-Json )
        }
        catch {
            $ErrorMessage = $_.Exception.Message
        }

        Context "Template JSON Syntax" {

            It "should be less than 1 Mb" {
                Get-Item $templateFile| Select-Object -ExpandProperty Length | Should -BeLessOrEqual 1073741824
            }
      
            It "Converts from JSON" {
                $ErrorMessage | Should -BeNullOrEmpty
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
    }

}
