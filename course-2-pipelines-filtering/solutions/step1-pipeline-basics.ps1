# Solution for Step 1: Pipeline Basics
# This demonstrates the fundamental concepts of PowerShell pipelines

Write-Host "🔄 Step 1: Pipeline Basics Solution" -ForegroundColor Cyan

# Basic pipeline - passing objects through the pipeline
Write-Host "1. Basic pipeline demonstration:" -ForegroundColor Yellow
Get-Process | Measure-Object
Write-Host "   Objects flow through the pipeline as .NET objects" -ForegroundColor Green

# Understanding pipeline objects
Write-Host "2. Pipeline object flow:" -ForegroundColor Yellow  
$processCount = Get-Process | Measure-Object | Select-Object -ExpandProperty Count
Write-Host "   Total processes: $processCount" -ForegroundColor Green

# Multiple pipeline operations
Write-Host "3. Chaining pipeline operations:" -ForegroundColor Yellow
Get-Process | 
    Where-Object { $_.WorkingSet -gt 10MB } |
    Measure-Object |
    Select-Object Count
Write-Host "   Pipeline chains multiple cmdlets together" -ForegroundColor Green

Write-Host "✅ Step 1 Complete: You understand pipeline basics!" -ForegroundColor Magenta
