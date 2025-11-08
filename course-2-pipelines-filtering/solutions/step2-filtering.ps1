# Solution for Step 2: Filtering with Where-Object
# This demonstrates filtering data in PowerShell pipelines

Write-Host "🔍 Step 2: Filtering Solution" -ForegroundColor Cyan

# Basic filtering
Write-Host "1. Basic Where-Object filtering:" -ForegroundColor Yellow
$largeProcesses = Get-Process | Where-Object { $_.WorkingSet -gt 50MB }
Write-Host "   Large processes: $($largeProcesses.Count)" -ForegroundColor Green

# Multiple conditions
Write-Host "2. Multiple filter conditions:" -ForegroundColor Yellow
Get-Process | 
    Where-Object { $_.WorkingSet -gt 20MB -and $_.ProcessName -like "*pwsh*" } |
    Select-Object ProcessName, @{Name='MemoryMB';Expression={[math]::Round($_.WorkingSet/1MB,2)}}
Write-Host "   Filtered by memory AND name pattern" -ForegroundColor Green

# Using comparison operators
Write-Host "3. Various comparison operators:" -ForegroundColor Yellow
# Greater than
$highMemory = Get-Process | Where-Object WorkingSet -gt 100MB
# Like pattern matching  
$shellProcesses = Get-Process | Where-Object ProcessName -like "*sh"
# Not equal
$nonZeroCpu = Get-Process | Where-Object CPU -ne $null

Write-Host "   High memory: $($highMemory.Count), Shell processes: $($shellProcesses.Count)" -ForegroundColor Green

Write-Host "✅ Step 2 Complete: You can filter data effectively!" -ForegroundColor Magenta
