$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$here\Add-Numbers.ps1"

Describe "Testing Add Numbers" -Tags "Example"  {
    Context "Numeric Tests" {
        It "adds positive numbers" {
            Add-Numbers 2 3 | Should be 5
        }
        
        It "adds negative numbers" {
            Add-Numbers (-2) (-2) | Should be (-4)
        }

        It "adds one negative number to positive number" {
            Add-Numbers (-2) 2 | Should be 0
        }

        It "concatenates strings if given strings" {
            Add-Numbers two three | Should be "twothree"
        }

        It "should not be 0" {
            Add-Numbers 2 3 | Should Not be 0
        }
    }
    Context "String Tests" {

        It "concatenates strings if given strings" {
            Add-Numbers two three | Should be "twothree"
        }
    }
}
