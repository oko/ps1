<#
Fix display sleep resolution resets on Windows 7/8/10

Based on solution proposed here:
    
    http://answers.microsoft.com/en-us/windows/forum/windows_7-hardware/windows-7-movesresizes-windows-on-monitor-power/1653aafb-848b-464a-8c69-1a68fbd106aa
    
Run as Administrator with `Set-ExecutionPolicy Unrestricted`
#>
Param([int]$HRES, [int]$VRES)

# All display configurations are stored under this key
$BASEKEY = "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Configuration"
#$HRES = 3840
#$VRES = 2160

Write-Host "Setting virtual resolution to $HRES x $VRES"

# Helper function to get the basename of the key
Function KeyBase($k) {
    $k.Name.Split('\')[-1]
}

# Get all `SIMULATED_*` display configurations
$keys = Get-ChildItem $BASEKEY | Where-Object { $_.Name -like "*\SIMULATED_*"}
foreach($key in $keys) {
    $name = KeyBase($key)
    # Set first-level 00 key values
    $key = $key.OpenSubKey('00', $true)
    $key.SetValue("PrimSurfSize.cx", $HRES, [Microsoft.Win32.RegistryValueKind]::DWord)
    $key.SetValue("PrimSurfSize.cy", $VRES, [Microsoft.Win32.RegistryValueKind]::DWord)

    # Set second-level 00 key values
    $key = $key.OpenSubKey('00', $true)
    $key.SetValue("ActiveSize.cx", $HRES, [Microsoft.Win32.RegistryValueKind]::DWord)
    $key.SetValue("ActiveSize.cy", $VRES, [Microsoft.Win32.RegistryValueKind]::DWord)
    $key.SetValue("DwmClipBox.right", $HRES, [Microsoft.Win32.RegistryValueKind]::DWord)
    $key.SetValue("DwmClipBox.bottom", $VRES, [Microsoft.Win32.RegistryValueKind]::DWord)
    Write-Host "Updating configuration for $name"
}