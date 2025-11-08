#!/usr/bin/env pwsh
# Course 2 Deployment Test Script
# This script validates the complete Course 2 implementation

param(
    [switch]$Verbose,
    [switch]$RunSolutions
)

Write-Host "🧪 Course 2: PowerShell Pipelines & Filtering - Deployment Test" -ForegroundColor Cyan
Write-Host "================================================================" -ForegroundColor Gray

$testResults = @()

# Test 1: Directory Structure
Write-Host "📂 Testing directory structure..." -ForegroundColor Yellow
$requiredDirs = @(".github", ".github/workflows", "solutions")
foreach ($dir in $requiredDirs) {
    if (Test-Path $dir) {
        Write-Host "  ✅ $dir" -ForegroundColor Green
        $testResults += @{Test="Directory: $dir"; Result="PASS"}
    } else {
        Write-Host "  ❌ $dir" -ForegroundColor Red  
        $testResults += @{Test="Directory: $dir"; Result="FAIL"}
    }
}

# Test 2: Required Files
Write-Host "📄 Testing required files..." -ForegroundColor Yellow
$requiredFiles = @("README.md", "COURSE_GUIDE.md", "LICENSE", ".gitignore")
foreach ($file in $requiredFiles) {
    if (Test-Path $file) {
        Write-Host "  ✅ $file" -ForegroundColor Green
        $testResults += @{Test="File: $file"; Result="PASS"}
    } else {
        Write-Host "  ❌ $file" -ForegroundColor Red
        $testResults += @{Test="File: $file"; Result="FAIL"}
    }
}

# Test 3: Workflow Files
Write-Host "⚙️  Testing workflow files..." -ForegroundColor Yellow
$expectedWorkflows = @("0-start.yml", "1-pipeline-basics.yml", "2-filtering.yml", "3-selecting.yml", "4-sorting.yml", "5-advanced-pipelines.yml")
foreach ($workflow in $expectedWorkflows) {
    $workflowPath = ".github/workflows/$workflow"
    if (Test-Path $workflowPath) {
        # Test workflow content
        $content = Get-Content $workflowPath -Raw
        $hasRequiredSections = ($content -match "name:") -and ($content -match "on:") -and ($content -match "jobs:")
        $hasSkillsAction = $content -match "skills/action-update-step"
        
        if ($hasRequiredSections -and $hasSkillsAction) {
            Write-Host "  ✅ $workflow (valid structure)" -ForegroundColor Green
            $testResults += @{Test="Workflow: $workflow"; Result="PASS"}
        } else {
            Write-Host "  ⚠️  $workflow (invalid structure)" -ForegroundColor Yellow
            $testResults += @{Test="Workflow: $workflow"; Result="WARN"}
        }
    } else {
        Write-Host "  ❌ $workflow" -ForegroundColor Red
        $testResults += @{Test="Workflow: $workflow"; Result="FAIL"}
    }
}

# Test 4: Solution Files
Write-Host "💡 Testing solution files..." -ForegroundColor Yellow
$expectedSolutions = @("step1-pipeline-basics.ps1", "step2-filtering.ps1", "step3-selecting.ps1", "step4-sorting.ps1", "step5-advanced-pipelines.ps1")
foreach ($solution in $expectedSolutions) {
    $solutionPath = "solutions/$solution"
    if (Test-Path $solutionPath) {
        Write-Host "  ✅ $solution" -ForegroundColor Green
        $testResults += @{Test="Solution: $solution"; Result="PASS"}
    } else {
        Write-Host "  ❌ $solution" -ForegroundColor Red
        $testResults += @{Test="Solution: $solution"; Result="FAIL"}
    }
}

# Test 5: PowerShell Syntax Validation
Write-Host "🔍 Testing PowerShell syntax..." -ForegroundColor Yellow
if (Test-Path "solutions") {
    $solutionFiles = Get-ChildItem "solutions/*.ps1"
    foreach ($file in $solutionFiles) {
        try {
            $null = [System.Management.Automation.PSParser]::Tokenize((Get-Content $file.FullName -Raw), [ref]$null)
            Write-Host "  ✅ $($file.Name) (valid syntax)" -ForegroundColor Green
            $testResults += @{Test="Syntax: $($file.Name)"; Result="PASS"}
        } catch {
            Write-Host "  ❌ $($file.Name) (syntax error)" -ForegroundColor Red
            $testResults += @{Test="Syntax: $($file.Name)"; Result="FAIL"}
        }
    }
}

# Optional: Run Solutions
if ($RunSolutions) {
    Write-Host "🚀 Testing solution execution..." -ForegroundColor Yellow
    $solutionFiles = Get-ChildItem "solutions/*.ps1" | Sort-Object Name
    foreach ($file in $solutionFiles) {
        Write-Host "  Running $($file.Name)..." -ForegroundColor Cyan
        try {
            & $file.FullName
            Write-Host "  ✅ $($file.Name) executed successfully" -ForegroundColor Green
            $testResults += @{Test="Execution: $($file.Name)"; Result="PASS"}
        } catch {
            Write-Host "  ❌ $($file.Name) failed: $($_.Exception.Message)" -ForegroundColor Red
            $testResults += @{Test="Execution: $($file.Name)"; Result="FAIL"}
        }
        Write-Host ""
    }
}

# Test Results Summary
Write-Host "📊 Test Results Summary" -ForegroundColor Magenta
Write-Host "======================" -ForegroundColor Gray

$passCount = ($testResults | Where-Object { $_.Result -eq "PASS" }).Count
$failCount = ($testResults | Where-Object { $_.Result -eq "FAIL" }).Count  
$warnCount = ($testResults | Where-Object { $_.Result -eq "WARN" }).Count
$totalTests = $testResults.Count

Write-Host "Total Tests: $totalTests" -ForegroundColor White
Write-Host "✅ Passed: $passCount" -ForegroundColor Green
Write-Host "❌ Failed: $failCount" -ForegroundColor Red
Write-Host "⚠️  Warnings: $warnCount" -ForegroundColor Yellow

$successRate = [math]::Round(($passCount / $totalTests) * 100, 1)
Write-Host "Success Rate: $successRate%" -ForegroundColor $(if($successRate -ge 90) {"Green"} elseif($successRate -ge 75) {"Yellow"} else {"Red"})

if ($Verbose) {
    Write-Host "`nDetailed Results:" -ForegroundColor Gray
    $testResults | ForEach-Object {
        $color = switch ($_.Result) {
            "PASS" { "Green" }
            "FAIL" { "Red" }  
            "WARN" { "Yellow" }
        }
        Write-Host "  $($_.Result): $($_.Test)" -ForegroundColor $color
    }
}

Write-Host ""
if ($failCount -eq 0) {
    Write-Host "🎉 Course 2 is READY FOR DEPLOYMENT!" -ForegroundColor Green
    Write-Host "All tests passed successfully." -ForegroundColor Green
} elseif ($failCount -le 2) {
    Write-Host "⚠️  Course 2 has minor issues that should be addressed." -ForegroundColor Yellow
} else {
    Write-Host "❌ Course 2 has significant issues that must be fixed before deployment." -ForegroundColor Red
}

return @{
    TotalTests = $totalTests
    PassedTests = $passCount
    FailedTests = $failCount
    WarningTests = $warnCount
    SuccessRate = $successRate
}
