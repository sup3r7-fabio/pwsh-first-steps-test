# Solution for Step 4: Sorting and Organizing
# This demonstrates sorting and grouping data in PowerShell

Write-Host "📊 Step 4: Sorting and Organizing Solution" -ForegroundColor Cyan

# Basic sorting
Write-Host "1. Basic sorting:" -ForegroundColor Yellow
Get-Process | Sort-Object ProcessName | Select-Object -First 10 ProcessName, Id
Write-Host "   Sorted processes alphabetically" -ForegroundColor Green

# Multiple property sorting
Write-Host "2. Multi-property sorting:" -ForegroundColor Yellow  
Get-Process |
    Select-Object ProcessName, @{Name='MemoryMB';Expression={[math]::Round($_.WorkingSet/1MB,2)}} |
    Sort-Object MemoryMB -Descending | 
    Select-Object -First 5
Write-Host "   Sorted by memory usage (highest first)" -ForegroundColor Green

# Grouping data
Write-Host "3. Grouping operations:" -ForegroundColor Yellow
Get-Process | 
    Select-Object ProcessName, @{Name='MemoryCategory';Expression={
        if($_.WorkingSet -gt 100MB) { "High" }
        elseif($_.WorkingSet -gt 20MB) { "Medium" }
        else { "Low" }
    }} |
    Group-Object MemoryCategory |
    Sort-Object Count -Descending |
    Select-Object Name, Count
Write-Host "   Grouped processes by memory category" -ForegroundColor Green

# Advanced grouping with calculations
Write-Host "4. Advanced grouping:" -ForegroundColor Yellow
Get-Process |
    Group-Object {$_.ProcessName.Substring(0,1).ToUpper()} |
    Where-Object { $_.Count -gt 1 } |
    Sort-Object Count -Descending |
    Select-Object @{Name='FirstLetter';Expression={$_.Name}}, 
                  @{Name='ProcessCount';Expression={$_.Count}}, 
                  @{Name='Examples';Expression={($_.Group | Select-Object -First 3 ProcessName | ForEach-Object ProcessName) -join ", "}}
Write-Host "   Grouped by first letter of process name" -ForegroundColor Green

Write-Host "✅ Step 4 Complete: You can sort and organize data!" -ForegroundColor Magenta
