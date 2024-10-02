$VMName = Read-Host "VMName(example:001_P_test)?"
$CPU    = Read-Host "CPU Core?"
#$Memory = Read-Host "Memory?"
#$VMSize = Read-Host "DiskSize?"
$ISOPath = Read-Host "ISO Path?"

$VM = @{
    Name = $VMName

#should fix
    #MemoryStartupBytes = $Memory
    MemoryStartupBytes = 1GB
    Generation = 2
    NewVHDPath = "Z:\$VMName\$VMName.vhdx"
#should fix
    #NewVHDSizeBytes = $DiskSize
    NewVHDSizeBytes = 40GB
    BootDevice = "VHD"
    Path = "Z:\$VMName"
    SwitchName = (Get-VMSwitch).Name
}

New-VM @VM
Set-VMMemory -VMName $VMName -DynamicMemoryEnabled $False
Set-VMProcessor -VMName $VMName -Count $CPU
Add-VMDvdDrive -VMName $VMName -ControllerNumber 0 -Path $ISOPath
$VMDvdDrive = Get-VMDvdDrive $VMName
Set-VMFirmware -VMName $VMName -EnableSecureBoot Off -FirstBootDevice $VMDvdDrive
Get-VM | select-object name,path,Generation,MemoryStartup|format-table -autosize
