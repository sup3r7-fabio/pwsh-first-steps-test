# My First PowerShell Script - Solution Example
# This script displays basic system information

# Welcome message with color formatting
Write-Host "Welcome to PowerShell!" -ForegroundColor Green

# Display PowerShell version information
Write-Host "PowerShell Version: $($PSVersionTable.PSVersion)" -ForegroundColor Cyan

# Show current date and time
Write-Host "Current Date and Time: $(Get-Date)" -ForegroundColor Yellow

# Display current working directory
Write-Host "Current Location: $(Get-Location)" -ForegroundColor Magenta

# Bonus: Display additional environment info
Write-Host "Computer Name: $env:COMPUTERNAME" -ForegroundColor Blue
Write-Host "Username: $env:USERNAME" -ForegroundColor White

# Learning Notes:
# - Write-Host is used for colored console output
# - $PSVersionTable is an automatic variable containing PowerShell version info
# - Get-Date and Get-Location are essential cmdlets for system information
# - Environment variables are accessed with $env: prefix
# - String interpolation uses $() for expressions within strings
