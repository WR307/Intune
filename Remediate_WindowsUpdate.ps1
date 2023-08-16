Try {

$regKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
$regValue = "DisableOSUpgrade"
$regData = "0"

if (!(Test-Path "$regKey")) {
    New-Item -Path "$regKey" -Force | Out-Null
}

if (!(Test-Path "$regKey\$regValue")) {
    New-ItemProperty -Path "$regKey" -Name "$regValue" -Value "$regData" -PropertyType DWORD -Force | Out-Null
     Write-Output "Compliant"
        Exit 0
} else {
    $currentValue = Get-ItemPropertyValue -Path "$regKey" -Name "$regValue"
    if ($currentValue -ne $regData) {
        Set-ItemProperty -Path "$regKey" -Name "$regValue" -Value "$regData" | Out-Null
         Write-Output "Compliant"
        Exit 0
    }
}

} 
Catch {
    Write-Warning "Not Compliant"
    Exit 1
}
