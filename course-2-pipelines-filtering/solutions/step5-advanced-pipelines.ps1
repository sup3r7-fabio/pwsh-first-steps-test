# Solution for Step 5: Advanced Pipeline Techniques
# This demonstrates advanced PowerShell pipeline concepts and techniques

Write-Host "🚀 Step 5: Advanced Pipeline Techniques Solution" -ForegroundColor Cyan

# Pipeline variables and foreach-object
Write-Host "1. Advanced pipeline processing:" -ForegroundColor Yellow
Get-Process |
    Where-Object { $_.WorkingSet -gt 10MB } |
    ForEach-Object {
        [PSCustomObject]@{
            ProcessName = $_.ProcessName
            MemoryMB = [math]::Round($_.WorkingSet/1MB,2)
            Status = if($_.Responding) { "✅ Active" } else { "❌ Frozen" }
            Category = switch ($_.WorkingSet) {
                {$_ -gt 500MB} { "🔥 Very High" }
                {$_ -gt 100MB} { "🟠 High" }
                {$_ -gt 50MB}  { "🟡 Medium" }
                default        { "🟢 Normal" }
            }
        }
    } |
    Sort-Object MemoryMB -Descending |
    Select-Object -First 10
Write-Host "   Created custom objects with enhanced data" -ForegroundColor Green

# Complex filtering and transformation pipeline
Write-Host "2. Complex data processing pipeline:" -ForegroundColor Yellow
$processAnalysis = Get-Process |
    Where-Object { $_.ProcessName -notmatch '^(Idle|System)' } |
    Select-Object ProcessName, WorkingSet, CPU, Threads |
    Group-Object { 
        switch ($_.WorkingSet) {
            {$_ -gt 200MB} { "Resource Intensive" }
            {$_ -gt 50MB}  { "Moderate Usage" }
            default        { "Lightweight" }
        }
    } |
    ForEach-Object {
        [PSCustomObject]@{
            Category = $_.Name
            ProcessCount = $_.Count
            TotalMemoryMB = [math]::Round(($_.Group | Measure-Object WorkingSet -Sum).Sum/1MB, 2)
            AverageMemoryMB = [math]::Round(($_.Group | Measure-Object WorkingSet -Average).Average/1MB, 2)
            TopProcesses = ($_.Group | Sort-Object WorkingSet -Descending | 
                           Select-Object -First 3 ProcessName | 
                           ForEach-Object ProcessName) -join ", "
        }
    } |
    Sort-Object TotalMemoryMB -Descending

$processAnalysis
Write-Host "   Analyzed process resource usage patterns" -ForegroundColor Green

# Pipeline performance optimization
Write-Host "3. Pipeline performance techniques:" -ForegroundColor Yellow
Measure-Command {
    # Efficient pipeline - filter early
    $efficientResult = Get-Process | 
        Where-Object { $_.WorkingSet -gt 50MB } | 
        Select-Object ProcessName, @{Name='MB';Expression={[math]::Round($_.WorkingSet/1MB,2)}} |
        Sort-Object MB -Descending |
        Select-Object -First 5
} | ForEach-Object { Write-Host "   Efficient pipeline took: $($_.TotalMilliseconds)ms" -ForegroundColor Green }

# Advanced pipeline with error handling
Write-Host "4. Pipeline with error handling:" -ForegroundColor Yellow
$safeProcessing = Get-Process |
    ForEach-Object {
        try {
            if ($_.ProcessName -and $_.WorkingSet) {
                [PSCustomObject]@{
                    Name = $_.ProcessName
                    MemoryMB = [math]::Round($_.WorkingSet/1MB,2)
                    Status = "✅ Processed"
                }
            }
        }
        catch {
            [PSCustomObject]@{
                Name = "Unknown"  
                MemoryMB = 0
                Status = "❌ Error: $($_.Exception.Message)"
            }
        }
    } |
    Where-Object { $_.Status -eq "✅ Processed" } |
    Sort-Object MemoryMB -Descending |
    Select-Object -First 5

$safeProcessing
Write-Host "   Processed with error handling and validation" -ForegroundColor Green

Write-Host ""
Write-Host "🎉 Congratulations! You have completed Course 2: PowerShell Pipelines & Filtering!" -ForegroundColor Magenta
Write-Host "You now understand:" -ForegroundColor Yellow
Write-Host "  ✅ How PowerShell pipelines work with objects" -ForegroundColor Green
Write-Host "  ✅ Filtering data with Where-Object" -ForegroundColor Green
Write-Host "  ✅ Selecting and transforming with Select-Object" -ForegroundColor Green
Write-Host "  ✅ Sorting and organizing with Sort-Object and Group-Object" -ForegroundColor Green
Write-Host "  ✅ Advanced pipeline techniques and optimization" -ForegroundColor Green
Write-Host ""
Write-Host "🚀 Ready for Course 3: PowerShell Functions & Modules!" -ForegroundColor Cyan
