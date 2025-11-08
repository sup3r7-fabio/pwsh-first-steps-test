# PowerShell Pipelines & Filtering - Solution Examples

## Step 1: Pipeline Basics Solution

### step1-pipeline-basics.ps1
```powershell
# Step 1: Pipeline Basics
# Understanding how objects flow through the pipeline

# Get services and examine their structure
Write-Host "=== Services Object Structure ===" -ForegroundColor Cyan
Get-Service | Get-Member | Select-Object -First 5

# Pass services through the pipeline and count them
Write-Host "`n=== Total Services Count ===" -ForegroundColor Cyan
$serviceCount = Get-Service | Measure-Object
Write-Host "Total services on this system: $($serviceCount.Count)"

# Display the first 3 services to see object properties
Write-Host "`n=== First 3 Services ===" -ForegroundColor Cyan
Get-Service | Select-Object -First 3 | Format-Table Name, Status, StartType -AutoSize

Write-Host "`n✅ Step 1 Complete! You understand pipeline basics." -ForegroundColor Green
```

**Key Learning Points:**
- Objects (not text) flow through PowerShell pipelines
- Each command receives full object properties and methods
- `Get-Member` shows object structure and available properties
- `Measure-Object` provides statistical information about collections

---

## Step 2: Filtering Solution

### step2-filtering.ps1
```powershell
# Step 2: Filtering with Where-Object
# Learn to filter objects based on conditions

# Filter running services
Write-Host "=== Running Services ===" -ForegroundColor Cyan
$runningServices = Get-Service | Where-Object { $_.Status -eq 'Running' }
Write-Host "Running services count: $($runningServices.Count)"
$runningServices | Select-Object -First 5 | Format-Table Name, Status -AutoSize

# Filter services by name pattern
Write-Host "`n=== Services with 'Windows' in Name ===" -ForegroundColor Cyan
Get-Service | Where-Object { $_.Name -like '*Windows*' } | 
    Select-Object Name, Status | Format-Table -AutoSize

# Multiple conditions with logical operators
Write-Host "`n=== Stopped Services (Automatic Start) ===" -ForegroundColor Cyan
Get-Service | Where-Object { $_.Status -eq 'Stopped' -and $_.StartType -eq 'Automatic' } |
    Select-Object Name, Status, StartType | Format-Table -AutoSize

# Filter processes by memory usage (greater than 50MB)
Write-Host "`n=== High Memory Processes (>50MB) ===" -ForegroundColor Cyan
Get-Process | Where-Object { $_.WorkingSet -gt 50MB } |
    Select-Object Name, @{Name='MemoryMB';Expression={[math]::Round($_.WorkingSet/1MB,2)}} |
    Sort-Object MemoryMB -Descending | Select-Object -First 5 | Format-Table -AutoSize

Write-Host "`n✅ Step 2 Complete! You can filter objects with conditions." -ForegroundColor Green
```

**Key Learning Points:**
- `Where-Object` filters objects based on conditions
- Comparison operators: `-eq`, `-ne`, `-lt`, `-gt`, `-le`, `-ge`
- Pattern matching with `-like` and wildcards
- Logical operators: `-and`, `-or`, `-not`
- Combining multiple conditions for complex filtering

---

## Step 3: Selecting and Transforming Solution

### step3-selecting.ps1
```powershell
# Step 3: Selecting and Transforming Data
# Learn to shape your data output

# Select specific properties
Write-Host "=== Service Essentials ===" -ForegroundColor Cyan
Get-Service | Select-Object Name, Status, StartType | 
    Sort-Object Name | Select-Object -First 10 | Format-Table -AutoSize

# Create calculated properties
Write-Host "`n=== Process Memory Analysis ===" -ForegroundColor Cyan
Get-Process | Select-Object Name, 
    @{Name='PID';Expression={$_.Id}},
    @{Name='MemoryMB';Expression={[math]::Round($_.WorkingSet/1MB,2)}},
    @{Name='CPUSeconds';Expression={[math]::Round($_.CPU,2)}} |
    Where-Object { $_.MemoryMB -gt 10 } |
    Sort-Object MemoryMB -Descending | 
    Select-Object -First 10 | Format-Table -AutoSize

# Working with file system data
Write-Host "`n=== Large Files in Current Directory ===" -ForegroundColor Cyan
if (Test-Path $PWD) {
    Get-ChildItem -File | Select-Object Name,
        @{Name='SizeKB';Expression={[math]::Round($_.Length/1KB,2)}},
        @{Name='Modified';Expression={$_.LastWriteTime.ToString('yyyy-MM-dd HH:mm')}},
        @{Name='Extension';Expression={$_.Extension}} |
        Where-Object { $_.SizeKB -gt 1 } |
        Sort-Object SizeKB -Descending | Format-Table -AutoSize
}

# Get unique file extensions in current directory
Write-Host "`n=== Unique File Extensions ===" -ForegroundColor Cyan
if (Test-Path $PWD) {
    Get-ChildItem -File | Select-Object -ExpandProperty Extension | 
        Where-Object { $_ } | Select-Object -Unique | Sort-Object
}

Write-Host "`n✅ Step 3 Complete! You can select and transform data properties." -ForegroundColor Green
```

**Key Learning Points:**
- `Select-Object` chooses specific properties from objects
- Calculated properties use hashtables with `Name` and `Expression`
- `-First`, `-Last`, `-Skip` provide data slicing capabilities
- `-ExpandProperty` extracts nested property values
- `-Unique` removes duplicate values from collections

---

## Advanced Examples

### Custom Data Processing Pipeline
```powershell
# Advanced pipeline for system health analysis
$systemReport = Get-Process | 
    Where-Object { $_.WorkingSet -gt 10MB } |
    Select-Object Name, 
        @{Name='MemoryMB';Expression={[math]::Round($_.WorkingSet/1MB,2)}},
        @{Name='HealthStatus';Expression={
            switch ($_.WorkingSet / 1MB) {
                {$_ -gt 500} { 'Critical' }
                {$_ -gt 200} { 'High' }
                {$_ -gt 50} { 'Normal' }
                default { 'Low' }
            }
        }} |
    Group-Object HealthStatus |
    Sort-Object Name

foreach ($group in $systemReport) {
    Write-Host "$($group.Name) Memory Usage: $($group.Count) processes" -ForegroundColor Yellow
    $group.Group | Sort-Object MemoryMB -Descending | Select-Object -First 3 |
        Format-Table Name, MemoryMB, HealthStatus -AutoSize
}
```

### Performance Monitoring Pipeline
```powershell
# Monitor system performance with pipelines
$performanceData = 1..10 | ForEach-Object {
    $processes = Get-Process | Measure-Object WorkingSet -Sum -Average
    [PSCustomObject]@{
        Timestamp = Get-Date
        ProcessCount = $processes.Count
        TotalMemoryGB = [math]::Round($processes.Sum / 1GB, 2)
        AvgMemoryMB = [math]::Round($processes.Average / 1MB, 2)
    }
    Start-Sleep -Seconds 1
}

$performanceData | 
    Select-Object @{Name='Time';Expression={$_.Timestamp.ToString('HH:mm:ss')}}, 
                  ProcessCount, TotalMemoryGB, AvgMemoryMB |
    Format-Table -AutoSize
```

## Best Practices for Pipelines

1. **Object-First Thinking**: Remember that PowerShell passes objects, not text
2. **Filter Early**: Apply `Where-Object` as early as possible to reduce data
3. **Select Wisely**: Only select the properties you need to improve performance
4. **Sort Last**: Apply sorting near the end of your pipeline
5. **Error Handling**: Use `-ErrorAction SilentlyContinue` for robust pipelines
6. **Performance**: Consider the cost of operations in long pipelines

## Common Pipeline Patterns

### Data Collection Pattern
```powershell
Get-Data | Where-Object Condition | Select-Object Properties | Sort-Object Property
```

### Analysis Pattern
```powershell
Get-Data | Group-Object Category | ForEach-Object { Process-Group $_ }
```

### Reporting Pattern  
```powershell
Get-Data | 
    Where-Object Criteria |
    Select-Object Properties |
    Group-Object Category |
    Sort-Object Name |
    Format-Table -AutoSize
```

### Transformation Pattern
```powershell
Import-Data | 
    Select-Object @{Name='NewProperty';Expression={Transform-Data $_}} |
    Export-Data
```
