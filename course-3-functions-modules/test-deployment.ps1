# Course 3: PowerShell Functions & Modules - Deployment Test
Write-Host "🧪 Course 3: PowerShell Functions & Modules - Deployment Test" -ForegroundColor Magenta
Write-Host "================================================================" -ForegroundColor Gray

$testResults = @{
    Passed = 0
    Failed = 0
    Total = 0
    Warnings = 0
}

function Test-Component {
    param(
        [string]$Name,
        [scriptblock]$Test
    )
    $testResults.Total++
    try {
        $result = & $Test
        if ($result) {
            Write-Host "  ✅ $Name" -ForegroundColor Green
            $testResults.Passed++
        } else {
            Write-Host "  ❌ $Name" -ForegroundColor Red
            $testResults.Failed++
        }
        return $result
    } catch {
        Write-Host "  ❌ $Name - Error: $($_.Exception.Message)" -ForegroundColor Red
        $testResults.Failed++
        return $false
    }
}

# Test directory structure
Write-Host "📂 Testing directory structure..." -ForegroundColor Cyan
Test-Component ".github" { Test-Path ".github" }
Test-Component ".github/workflows" { Test-Path ".github/workflows" }
Test-Component "solutions" { Test-Path "solutions" }

# Test required files
Write-Host "📄 Testing required files..." -ForegroundColor Cyan
Test-Component "README.md" { Test-Path "README.md" }
Test-Component "COURSE_GUIDE.md" { Test-Path "COURSE_GUIDE.md" }
Test-Component "LICENSE" { Test-Path "LICENSE" }
Test-Component ".gitignore" { Test-Path ".gitignore" }

# Test workflow files
Write-Host "⚙️  Testing workflow files..." -ForegroundColor Cyan
$workflows = @("0-start.yml", "1-function-basics.yml", "2-parameters.yml", "3-advanced-functions.yml", "4-module-creation.yml", "5-distribution.yml")

foreach ($workflow in $workflows) {
    $workflowPath = ".github/workflows/$workflow"
    $exists = Test-Component $workflow { Test-Path $workflowPath }
    
    if ($exists) {
        # Test YAML structure
        try {
            $content = Get-Content $workflowPath -Raw
            if ($content -match "skills/action-update-step@v2" -and $content -match "shell: pwsh") {
                Write-Host "    ✅ $workflow (valid structure)" -ForegroundColor DarkGreen
            } else {
                Write-Host "    ⚠️  $workflow (invalid structure)" -ForegroundColor Yellow
                $testResults.Warnings++
            }
        } catch {
            Write-Host "    ❌ $workflow (YAML error)" -ForegroundColor Red
        }
    }
}

# Test solution files
Write-Host "💡 Testing solution files..." -ForegroundColor Cyan
$solutions = @("step1-function-basics.ps1", "step2-parameters.ps1")

foreach ($solution in $solutions) {
    $solutionPath = "solutions/$solution"
    Test-Component $solution { Test-Path $solutionPath }
}

# Test PowerShell syntax
Write-Host "🔍 Testing PowerShell syntax..." -ForegroundColor Cyan
foreach ($solution in $solutions) {
    $solutionPath = "solutions/$solution"
    if (Test-Path $solutionPath) {
        try {
            $null = [System.Management.Automation.PSParser]::Tokenize((Get-Content $solutionPath -Raw), [ref]$null)
            Write-Host "  ✅ $solution (valid syntax)" -ForegroundColor Green
            $testResults.Passed++
        } catch {
            Write-Host "  ❌ $solution (syntax error)" -ForegroundColor Red
            $testResults.Failed++
        }
        $testResults.Total++
    }
}

# Summary
Write-Host "`n📊 Test Results Summary" -ForegroundColor Magenta
Write-Host "======================" -ForegroundColor Gray
Write-Host "Total Tests: $($testResults.Total)" -ForegroundColor White
Write-Host "✅ Passed: $($testResults.Passed)" -ForegroundColor Green
Write-Host "❌ Failed: $($testResults.Failed)" -ForegroundColor Red
Write-Host "⚠️  Warnings: $($testResults.Warnings)" -ForegroundColor Yellow

$successRate = [math]::Round(($testResults.Passed / $testResults.Total) * 100, 1)
Write-Host "Success Rate: $successRate%" -ForegroundColor Cyan

if ($testResults.Failed -eq 0 -and $testResults.Warnings -le 2) {
    Write-Host "`n🎉 Course 3 is READY FOR DEPLOYMENT!" -ForegroundColor Green
    Write-Host "All tests passed successfully." -ForegroundColor Green
} else {
    Write-Host "`n⚠️  Course 3 needs attention before deployment." -ForegroundColor Yellow
    if ($testResults.Failed -gt 0) {
        Write-Host "Please fix the failed tests." -ForegroundColor Red
    }
}

return @{
    SuccessRate = $successRate
    PassedTests = $testResults.Passed
    FailedTests = $testResults.Failed
    TotalTests = $testResults.Total
    WarningTests = $testResults.Warnings
}
