Write-Host "Hello, PowerShell!"
$processes = Get-Process | Where-Object { $_.CPU -gt 0 }
Write-Output $processes
