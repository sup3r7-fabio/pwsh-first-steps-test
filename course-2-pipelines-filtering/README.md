# 🔄 PowerShell Pipelines & Filtering

_Master the art of data manipulation with PowerShell pipelines and filtering commands_

## 📚 Course Overview

**Estimated Time:** 60-75 minutes  
**Difficulty Level:** Beginner to Intermediate  
**Prerequisites:** Basic PowerShell commands (Course 1 recommended)

In this interactive course, you'll learn how to harness PowerShell's most powerful feature: the pipeline. You'll discover how to chain commands together, filter data efficiently, and transform objects to get exactly the information you need.

## 🎯 Learning Objectives

By the end of this course, you will:

- ✅ Understand how PowerShell pipelines work with objects
- ✅ Master filtering with `Where-Object` and comparison operators
- ✅ Select specific properties with `Select-Object`
- ✅ Sort and organize data with `Sort-Object`
- ✅ Count, group, and measure data efficiently
- ✅ Build complex data processing chains

## 🛠️ What You'll Build

Throughout this course, you'll create scripts that:
- Process system services and their properties
- Filter running processes by memory usage
- Analyze file system data with custom criteria
- Create formatted reports from raw data

---

## 📖 Course Content

### Step 1: Understanding the Pipeline

The PowerShell pipeline is revolutionary because it passes **objects** (not just text) between commands. This means each command in the pipeline receives rich, structured data that can be easily manipulated.

**Key Concepts:**
- Objects flow through the pipeline, not text
- Each cmdlet can access all properties and methods of objects
- The `|` (pipe) operator connects commands

**Your First Task:**
Create a file called `step1-pipeline-basics.ps1` with the following content:

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

**🎯 Exercise:** Run your script and observe how objects flow through the pipeline. Notice how each command receives the full service objects, not just text.

---

### Step 2: Filtering with Where-Object

`Where-Object` is your data filter. It lets you specify conditions to select only the objects that match your criteria.

**Key Concepts:**
- Use `Where-Object` (alias: `where` or `?`) to filter objects
- Comparison operators: `-eq`, `-ne`, `-lt`, `-gt`, `-le`, `-ge`
- Pattern matching: `-like`, `-notlike`, `-match`, `-notmatch`
- Property testing: `-contains`, `-in`, `-notin`

**Your Task:**
Create `step2-filtering.ps1`:

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

**🎯 Exercise:** Modify the memory threshold to find processes using more than 100MB. Try different service name patterns.

---

### Step 3: Selecting and Transforming Data

`Select-Object` is your data shaper. It lets you choose specific properties, create calculated fields, and transform object structure.

**Key Concepts:**
- Select specific properties with `Select-Object`
- Create calculated properties with hashtables
- Use `-First`, `-Last`, `-Skip` for data slicing
- `-Unique` removes duplicates
- `-ExpandProperty` flattens nested objects

**Your Task:**
Create `step3-selecting.ps1`:

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

**🎯 Exercise:** Create a calculated property that shows the age of files in days.

---

### Step 4: Sorting and Organizing Data

`Sort-Object` organizes your data in meaningful ways. Combined with grouping, you can create powerful data summaries.

**Key Concepts:**
- Sort by single or multiple properties
- Use `-Descending` for reverse order
- `Group-Object` creates data summaries
- `Measure-Object` provides statistics
- Combine sorting with filtering for powerful results

**Your Task:**
Create `step4-sorting.ps1`:

```powershell
# Step 4: Sorting and Organizing Data
# Learn to organize and group your data

# Sort services by multiple criteria
Write-Host "=== Services Sorted by Status and Name ===" -ForegroundColor Cyan
Get-Service | Sort-Object Status, Name | 
    Select-Object Name, Status, StartType | 
    Select-Object -First 15 | Format-Table -AutoSize

# Group services by status
Write-Host "`n=== Services Grouped by Status ===" -ForegroundColor Cyan
$serviceGroups = Get-Service | Group-Object Status
foreach ($group in $serviceGroups) {
    Write-Host "$($group.Name): $($group.Count) services" -ForegroundColor Yellow
}

# Group processes by company
Write-Host "`n=== Top Process Publishers ===" -ForegroundColor Cyan
Get-Process | Where-Object { $_.Company } | 
    Group-Object Company | 
    Sort-Object Count -Descending | 
    Select-Object -First 10 Name, Count | Format-Table -AutoSize

# File analysis with sorting and grouping
Write-Host "`n=== File Analysis by Extension ===" -ForegroundColor Cyan
if (Test-Path $PWD) {
    Get-ChildItem -Recurse -File -ErrorAction SilentlyContinue | 
        Group-Object Extension | 
        Select-Object Name, Count,
            @{Name='TotalSizeMB';Expression={
                [math]::Round(($_.Group | Measure-Object Length -Sum).Sum / 1MB, 2)
            }} |
        Where-Object { $_.Name } |
        Sort-Object TotalSizeMB -Descending | 
        Select-Object -First 10 | Format-Table -AutoSize
}

# Statistics with Measure-Object
Write-Host "`n=== Process Memory Statistics ===" -ForegroundColor Cyan
$memStats = Get-Process | Measure-Object WorkingSet -Sum -Average -Maximum
Write-Host "Total Memory Used: $([math]::Round($memStats.Sum/1GB,2)) GB"
Write-Host "Average per Process: $([math]::Round($memStats.Average/1MB,2)) MB"
Write-Host "Largest Process: $([math]::Round($memStats.Maximum/1MB,2)) MB"

Write-Host "`n✅ Step 4 Complete! You can sort and organize data effectively." -ForegroundColor Green
```

**🎯 Exercise:** Create a report showing the top 5 directories by total file size.

---

### Step 5: Advanced Pipeline Techniques

Now you'll combine everything into sophisticated data processing chains and learn advanced pipeline patterns.

**Key Concepts:**
- Chain multiple filtering and transformation operations
- Use `ForEach-Object` for complex processing
- Handle errors in pipelines with `-ErrorAction`
- Create reusable pipeline patterns
- Performance considerations for large datasets

**Your Task:**
Create `step5-advanced-pipelines.ps1`:

```powershell
# Step 5: Advanced Pipeline Techniques
# Build sophisticated data processing chains

# Complex service analysis pipeline
Write-Host "=== Comprehensive Service Analysis ===" -ForegroundColor Cyan
$serviceReport = Get-Service | 
    Where-Object { $_.ServiceType -match 'Win32' } |
    Select-Object Name, Status, StartType, ServiceType,
        @{Name='Category';Expression={
            switch ($_.Status) {
                'Running' { 'Active' }
                'Stopped' { 
                    if ($_.StartType -eq 'Automatic') { 'Attention' } 
                    else { 'Inactive' } 
                }
                default { 'Unknown' }
            }
        }} |
    Group-Object Category | 
    Sort-Object Name

foreach ($category in $serviceReport) {
    Write-Host "`n$($category.Name) Services: $($category.Count)" -ForegroundColor Yellow
    $category.Group | Sort-Object Name | Select-Object -First 5 | 
        Format-Table Name, Status, StartType -AutoSize
}

# Advanced process analysis with error handling
Write-Host "`n=== Process Performance Analysis ===" -ForegroundColor Cyan
$processAnalysis = Get-Process -ErrorAction SilentlyContinue | 
    Where-Object { $_.WorkingSet -gt 10MB } |
    Select-Object Name, Id,
        @{Name='MemoryMB';Expression={[math]::Round($_.WorkingSet/1MB,2)}},
        @{Name='CPUTime';Expression={$_.CPU}},
        @{Name='Performance';Expression={
            $mem = $_.WorkingSet / 1MB
            $cpu = if ($_.CPU) { $_.CPU } else { 0 }
            switch ($true) {
                ($mem -gt 500 -or $cpu -gt 100) { 'High Impact' }
                ($mem -gt 100 -or $cpu -gt 50) { 'Medium Impact' }
                default { 'Low Impact' }
            }
        }} |
    Group-Object Performance |
    Sort-Object Name

foreach ($perfGroup in $processAnalysis) {
    Write-Host "`n$($perfGroup.Name) Processes:" -ForegroundColor Magenta
    $perfGroup.Group | Sort-Object MemoryMB -Descending | 
        Select-Object -First 3 | Format-Table Name, MemoryMB, Performance -AutoSize
}

# File system deep analysis
Write-Host "`n=== File System Intelligence Report ===" -ForegroundColor Cyan
if (Test-Path $PWD) {
    $fileIntel = Get-ChildItem -Recurse -File -ErrorAction SilentlyContinue |
        Where-Object { $_.Length -gt 0 } |
        Select-Object Name, Length, Extension, LastWriteTime,
            @{Name='AgeCategory';Expression={
                $days = (Get-Date) - $_.LastWriteTime
                switch ($true) {
                    ($days.Days -lt 7) { 'Recent' }
                    ($days.Days -lt 30) { 'Current' }
                    ($days.Days -lt 365) { 'Older' }
                    default { 'Archive' }
                }
            }},
            @{Name='SizeCategory';Expression={
                $sizeMB = $_.Length / 1MB
                switch ($true) {
                    ($sizeMB -gt 100) { 'Large' }
                    ($sizeMB -gt 10) { 'Medium' }
                    ($sizeMB -gt 1) { 'Small' }
                    default { 'Tiny' }
                }
            }} |
        Group-Object AgeCategory, SizeCategory |
        Sort-Object Name

    $fileIntel | ForEach-Object {
        $totalSize = ($_.Group | Measure-Object Length -Sum).Sum
        Write-Host "$($_.Name): $($_.Count) files, $([math]::Round($totalSize/1MB,2)) MB" -ForegroundColor Cyan
    }
}

# Performance pipeline example
Write-Host "`n=== Pipeline Performance Demonstration ===" -ForegroundColor Cyan
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

$result = 1..1000 | 
    ForEach-Object { 
        [PSCustomObject]@{
            Number = $_
            Square = $_ * $_
            IsEven = ($_ % 2) -eq 0
        }
    } |
    Where-Object { $_.IsEven } |
    Select-Object -First 10

$stopwatch.Stop()
Write-Host "Processed 1000 objects in $($stopwatch.ElapsedMilliseconds) ms"
$result | Format-Table -AutoSize

Write-Host "`n🎉 Course Complete! You've mastered PowerShell pipelines and filtering!" -ForegroundColor Green
Write-Host "You can now:" -ForegroundColor Yellow
Write-Host "- Chain commands with confidence" -ForegroundColor White
Write-Host "- Filter data with complex conditions" -ForegroundColor White
Write-Host "- Transform objects with calculated properties" -ForegroundColor White
Write-Host "- Sort and group data for insights" -ForegroundColor White
Write-Host "- Build sophisticated data processing pipelines" -ForegroundColor White
```

**🎯 Final Exercise:** Create a comprehensive system health report that combines services, processes, and disk usage into a single pipeline.

---

## 🎯 Next Steps

Ready to continue your PowerShell journey? Check out these recommended next courses:

- **Course 3:** PowerShell Functions & Modules
- **Course 4:** PowerShell Error Handling & Debugging
- **Course 5:** PowerShell File & Registry Operations

## 📚 Additional Resources

- [Microsoft Learn: PowerShell Pipeline](https://docs.microsoft.com/learn/modules/powershell-pipeline/)
- [PowerShell Documentation: About Pipelines](https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_pipelines)
- [PowerShell Gallery: Popular Modules](https://powershellgallery.com/)

---

## 🆘 Need Help?

- **Issues?** Open an issue in this repository
- **Questions?** Check the discussions section
- **Community:** Join the PowerShell community forums

---

_Happy scripting! 🚀_
