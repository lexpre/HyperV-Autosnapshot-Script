# ---------------------------------------------
# Script: hypervAutomaticSnapshot.ps1
# Version: 1.0
# Author: Alessandro Previati www.fanfanfone.it
# Date: 28/06/2019
# ---------------------------------------------

##Variable setting
$vms = Get-VM | Where-Object {$_.State -eq 'Running'}
#$vms = Get-VM

##For each VM for create incremental snapshot
ForEach ($vm in $vms) {

Rename-VMSnapshot -VMName $vm.name -Name "AutomaticSnapshot01" -NewName "AutomaticSnapshotOLD"
Rename-VMSnapshot -VMName $vm.name -Name "AutomaticSnapshot02" -NewName "AutomaticSnapshot01"
Rename-VMSnapshot -VMName $vm.name -Name "AutomaticSnapshot03" -NewName "AutomaticSnapshot02"
Rename-VMSnapshot -VMName $vm.name -Name "AutomaticSnapshot04" -NewName "AutomaticSnapshot03"
Rename-VMSnapshot -VMName $vm.name -Name "AutomaticSnapshot05" -NewName "AutomaticSnapshot04"
Checkpoint-VM -Name $vm.name -SnapshotName "AutomaticSnapshot05"
Get-VM $vm.name | Remove-VMSnapshot -Name "AutomaticSnapshotOLD"

Start-Sleep -s 5
}

##END