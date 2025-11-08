# Test Script for Course 2: PowerShell Pipelines & Filtering
Write-Host '🧪 Testing Course 2 Components...' -ForegroundColor Cyan

# Test 1: Pipeline basics
Write-Host '1. Testing pipeline basics...' -ForegroundColor Yellow
try {
    $processes = Get-Process | Measure-Object
    Write-Host "   ✅ Pipeline test passed: $($processes.Count) processes found" -ForegroundColor Green
} catch {
    Write-Host "   ❌ Pipeline test failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 2: Filtering with Where-Object
Write-Host '2. Testing filtering capabilities...' -ForegroundColor Yellow
try {
    $filtered = Get-Process | Where-Object { $_.WorkingSet -gt 50MB }
    Write-Host "   ✅ Filtering test passed: $($filtered.Count) processes using >50MB memory" -ForegroundColor Green
} catch {
    Write-Host "   ❌ Filtering test failed: $($_.Exception.Message)" -ForegroundColor Red
}# Test 3: Selection and transformation
Write-Host '3. Testing selection and transformation...' -ForegroundColor Yellow
try {
    $transformed = Get-Process | Select-Object Name, @{Name='MemoryMB';Expression={[math]::Round($_.WorkingSet/1MB,2)}} | Select-Object -First 5
    Write-Host "   ✅ Selection test passed: $($transformed.Count) processes transformed" -ForegroundColor Green
} catch {
    Write-Host "   ❌ Selection test failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 4: Sorting and grouping
Write-Host '4. Testing sorting and grouping...' -ForegroundColor Yellow
try {
    $grouped = Get-Process | Group-Object ProcessName | Sort-Object Name | Select-Object -First 3
    Write-Host "   ✅ Grouping test passed: $($grouped.Count) process groups created" -ForegroundColor Green
} catch {
    Write-Host "   ❌ Grouping test failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host '🎉 Course 2 component testing complete!' -ForegroundColor Magenta
