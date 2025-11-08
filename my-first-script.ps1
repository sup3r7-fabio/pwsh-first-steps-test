# My First PowerShell Script
# This script displays basic system information

Write-Host "Welcome to PowerShell!" -ForegroundColor Green
Write-Host "PowerShell Version: $($PSVersionTable.PSVersion)" -ForegroundColor Cyan
Write-Host "Current Date and Time: $(Get-Date)" -ForegroundColor Yellow
Write-Host "Current Location: $(Get-Location)" -ForegroundColor Magenta
