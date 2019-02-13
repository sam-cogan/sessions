param(
    # JSon File Describing Environment
    [string]$environmentFile
)

$infrastructure = (Get-Content $environmentFile | ConvertFrom-Json )
$environmentPrefix = $infrastructure.environmentPrefix

Describe  -Tags "InfrastructureTests" "Resource Group" {

    context "Resource Group Settings" {
        $resourceGroup = Get-AzureRmResourceGroup -Name "$environmentPrefix-rg" -ErrorAction SilentlyContinue

        it "Should Exist" {
            $resourceGroup | should not be $null
        }

        it "Should be in the correct region" {
            $resourceGroup.Location | should be $infrastructure.region
        }
    }

}

Describe "Networking Tests" -Tags "PostDeployment" {

    $vNet = Get-AzureRmVirtualNetwork -Name "$environmentPrefix-vNet" -ResourceGroupName "$environmentPrefix-rg"

    Context "Virtual Network" {


        it "Check Virtual Network Exists" {
            Get-AzureRmVirtualNetwork -Name "$environmentPrefix-vNet" -ResourceGroupName "$environmentPrefix-rg" -ErrorAction SilentlyContinue| Should Not be $null
        }

        it "Should be in the correct region" {
            $vNet.Location | should be $infrastructure.region
        }

        $infrastructure.Networking.Subnets |
            ForEach-Object {
            $subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $_.Name -VirtualNetwork $vnet -ErrorAction SilentlyContinue
            it "Subnet $($_.Name) Should Exist" {
                $subnet| Should Not be $null
            }
            it "Subnet $($_.Name) Should have Address Range $($_.addressRange)" {
                $subnet.AddressPrefix | Should be $_.addressRange
            }
        }
    }

    Context "Network Security Groups" {
        $vnet = Get-AzureRmVirtualNetwork -Name "$environmentPrefix-vNet" -ResourceGroupName "$environmentPrefix-rg" 

        $infrastructure.Networking.Subnets |
            ForEach-Object {
            $nsg = Get-AzureRmNetworkSecurityGroup -Name "$($_.name)-nsg" -ResourceGroupName "$environmentPrefix-rg" -ErrorAction SilentlyContinue
            $subnetName = $_.name
            it "Subnet $subnetName Should Exist" {
                $nsg| Should Not be $null
            }

            it "Nsg $subnetName-nsg Should Be Assigned to Subnet $subnetName" {
                $subnetId = $($vnet.Subnets | Where { $_.name -match $subnetName }).id
        
                $assignedNsg = $($vnet.Subnets | Where { $_.id -match $subnetId }).NetworkSecurityGroup.id
                $assignedNsg.split('/')[-1] | Should be "$($_.name)-nsg"
            }
        }
    }


}

Describe "Virtual Machine Test" -Tags "PostDeployment" {
    $vms = get-azurermvm -ResourceGroupName $environmentPrefix-rg


    Context "VM Deployment State" {

        it "VM Count should equal $($Infrastructure.VirtualMachines.count)" {
            $vms.count | should be $Infrastructure.VirtualMachines.count
        }

        it "All VMs should be in a running state" {
            $($vms | where-object {$_.provisioningstate -ne "Succeeded"}).count | should be 0
        }
    }

    Context "VM COnfiguration" {
        foreach ($vm in $Infrastructure.VirtualMachines) {
            $azureVM = get-azurermvm -Name $vm.name -ResourceGroupName "$environmentPrefix-rg"

            it "$($vm.name) should be in the correct region" {
                $azureVM.Location | should be $vm.region
            }

            it "$($vm.name)  should be of size $($vm.size)" {
                $azureVM.HardwareProfile.VmSize | should be $vm.size
            }
        }
    }
}