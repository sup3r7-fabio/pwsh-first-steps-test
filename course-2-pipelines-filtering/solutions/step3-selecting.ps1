# Solution for Step 3: Selecting and Transforming with Select-Object
# This demonstrates data selection and transformation techniques

Write-Host "📋 Step 3: Selection and Transformation Solution" -ForegroundColor Cyan

# Basic property selection
Write-Host "1. Basic property selection:" -ForegroundColor Yellow
Get-Process | Select-Object ProcessName, Id, WorkingSet | Select-Object -First 5
Write-Host "   Selected specific properties from objects" -ForegroundColor Green

# Calculated properties
Write-Host "2. Calculated properties:" -ForegroundColor Yellow
Get-Process | 
    Select-Object ProcessName, 
                  @{Name='MemoryMB';Expression={[math]::Round($_.WorkingSet/1MB,2)}},
                  @{Name='Status';Expression={if($_.Responding){"Running"}else{"Not Responding"}}} |
    Select-Object -First 5
Write-Host "   Created custom calculated properties" -ForegroundColor Green

# Property transformation
Write-Host "3. Advanced property transformation:" -ForegroundColor Yellow
Get-Process |
    Select-Object @{Name='Process';Expression={$_.ProcessName.ToUpper()}},
                  @{Name='Memory_Category';Expression={
                      if($_.WorkingSet -gt 100MB) { "High" }
                      elseif($_.WorkingSet -gt 50MB) { "Medium" }  
                      else { "Low" }
                  }} |
    Group-Object Memory_Category |
    Select-Object Name, Count
Write-Host "   Transformed and categorized data" -ForegroundColor Green

# Selecting specific items
Write-Host "4. Item selection methods:" -ForegroundColor Yellow
$processes = Get-Process
Write-Host "   First 3: $($processes | Select-Object -First 3 | ForEach-Object ProcessName)"
Write-Host "   Last 2: $($processes | Select-Object -Last 2 | ForEach-Object ProcessName)"  
Write-Host "   Unique names: $($processes | Select-Object -Unique ProcessName | Measure-Object | Select-Object -ExpandProperty Count)" -ForegroundColor Green

Write-Host "✅ Step 3 Complete: You can select and transform data!" -ForegroundColor Magenta
