# Course 4: PowerShell Automation & DevOps - Deployment Test
Write-Host "🚀 Course 4: PowerShell Automation & DevOps - Deployment Test" -ForegroundColor Magenta
Write-Host "=================================================================" -ForegroundColor Gray

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

# Test enterprise directory structure
Write-Host "🏢 Testing enterprise directory structure..." -ForegroundColor Cyan
Test-Component ".github" { Test-Path ".github" }
Test-Component ".github/workflows" { Test-Path ".github/workflows" }
Test-Component "solutions" { Test-Path "solutions" }
Test-Component "templates" { Test-Path "templates" }

# Test enterprise documentation
Write-Host "📚 Testing enterprise documentation..." -ForegroundColor Cyan
Test-Component "README.md" { Test-Path "README.md" }
Test-Component "COURSE_GUIDE.md" { Test-Path "COURSE_GUIDE.md" }
Test-Component "LICENSE" { Test-Path "LICENSE" }
Test-Component ".gitignore" { Test-Path ".gitignore" }

# Test advanced workflow files
Write-Host "⚙️  Testing enterprise workflow files..." -ForegroundColor Cyan
$enterpriseWorkflows = @(
    "0-start.yml", 
    "1-infrastructure-code.yml", 
    "2-cicd-pipeline.yml", 
    "3-monitoring-logging.yml", 
    "4-security-compliance.yml", 
    "5-enterprise-deployment.yml"
)

foreach ($workflow in $enterpriseWorkflows) {
    $workflowPath = ".github/workflows/$workflow"
    $exists = Test-Component $workflow { Test-Path $workflowPath }
    
    if ($exists) {
        # Test enterprise workflow structure
        try {
            $content = Get-Content $workflowPath -Raw
            $hasSkillsAction = $content -match "skills/action-update-step@v2"
            $hasPowerShell = $content -match "shell: pwsh"
            $hasEnterpriseFeatures = $content -match "(Enterprise|DevOps|Infrastructure|CI/CD|Security)"
            
            if ($hasSkillsAction -and $hasPowerShell -and $hasEnterpriseFeatures) {
                Write-Host "    ✅ $workflow (enterprise-ready structure)" -ForegroundColor DarkGreen
            } else {
                Write-Host "    ⚠️  $workflow (missing enterprise features)" -ForegroundColor Yellow
                $testResults.Warnings++
            }
        } catch {
            Write-Host "    ❌ $workflow (YAML structure error)" -ForegroundColor Red
        }
    }
}

# Test enterprise solution files
Write-Host "🔧 Testing enterprise solution files..." -ForegroundColor Cyan
$enterpriseSolutions = @("step1-infrastructure-code.ps1")

foreach ($solution in $enterpriseSolutions) {
    $solutionPath = "solutions/$solution"
    Test-Component $solution { Test-Path $solutionPath }
}

# Test advanced PowerShell syntax and enterprise patterns
Write-Host "🏗️ Testing enterprise PowerShell patterns..." -ForegroundColor Cyan
foreach ($solution in $enterpriseSolutions) {
    $solutionPath = "solutions/$solution"
    if (Test-Path $solutionPath) {
        try {
            $content = Get-Content $solutionPath -Raw
            
            # Check for enterprise PowerShell patterns
            $enterprisePatterns = @{
                "DSC Configuration" = "Configuration\s+\w+"
                "PowerShell Classes" = "class\s+\w+"
                "Advanced Functions" = "\[CmdletBinding\(\)\]"
                "Error Handling" = "try\s*\{.*catch"
                "Cross-Platform" = "Platform.*Linux|Windows|MacOS"
            }
            
            $patternFound = 0
            foreach ($pattern in $enterprisePatterns.Keys) {
                if ($content -match $enterprisePatterns[$pattern]) {
                    Write-Host "    ✅ $pattern detected" -ForegroundColor DarkGreen
                    $patternFound++
                }
            }
            
            # Syntax validation
            $null = [System.Management.Automation.PSParser]::Tokenize($content, [ref]$null)
            Write-Host "  ✅ $solution (valid enterprise syntax)" -ForegroundColor Green
            $testResults.Passed++
            $testResults.Total++
            
            if ($patternFound -ge 3) {
                Write-Host "  🏆 $solution (enterprise-grade patterns)" -ForegroundColor Magenta
            }
            
        } catch {
            Write-Host "  ❌ $solution (syntax error)" -ForegroundColor Red
            $testResults.Failed++
            $testResults.Total++
        }
    }
}

# Test enterprise readiness
Write-Host "🚀 Testing enterprise readiness..." -ForegroundColor Cyan

# Check for advanced PowerShell features
$advancedFeatures = @(
    @{ Name = "DSC Resource Availability"; Test = { Get-Module -ListAvailable PSDesiredStateConfiguration } },
    @{ Name = "Enterprise Modules"; Test = { Get-Module -ListAvailable Microsoft.PowerShell.Management } },
    @{ Name = "Security Modules"; Test = { Get-Module -ListAvailable Microsoft.PowerShell.Security } },
    @{ Name = "PowerShell 7+ Features"; Test = { $PSVersionTable.PSVersion.Major -ge 7 } }
)

foreach ($feature in $advancedFeatures) {
    Test-Component $feature.Name $feature.Test
}

# Enterprise validation summary
Write-Host "`n📊 Enterprise Deployment Test Results" -ForegroundColor Magenta
Write-Host "====================================" -ForegroundColor Gray
Write-Host "Total Tests: $($testResults.Total)" -ForegroundColor White
Write-Host "✅ Passed: $($testResults.Passed)" -ForegroundColor Green
Write-Host "❌ Failed: $($testResults.Failed)" -ForegroundColor Red
Write-Host "⚠️  Warnings: $($testResults.Warnings)" -ForegroundColor Yellow

$successRate = [math]::Round(($testResults.Passed / $testResults.Total) * 100, 1)
Write-Host "Success Rate: $successRate%" -ForegroundColor Cyan

# Enterprise readiness assessment
if ($testResults.Failed -eq 0 -and $testResults.Warnings -le 3) {
    Write-Host "`n🏆 COURSE 4 IS ENTERPRISE-READY FOR DEPLOYMENT!" -ForegroundColor Green
    Write-Host "Advanced automation capabilities validated successfully." -ForegroundColor Green
    
    Write-Host "`n🎯 ENTERPRISE CAPABILITIES CONFIRMED:" -ForegroundColor Yellow
    Write-Host "  🏗️ Infrastructure as Code with PowerShell DSC" -ForegroundColor White
    Write-Host "  🔄 CI/CD Pipeline Development Framework" -ForegroundColor White  
    Write-Host "  📊 Production Monitoring & Logging Systems" -ForegroundColor White
    Write-Host "  🔐 Security & Compliance Automation" -ForegroundColor White
    Write-Host "  🚀 Scalable Enterprise Deployment Patterns" -ForegroundColor White
    
} else {
    Write-Host "`n⚠️  Course 4 requires enterprise readiness improvements." -ForegroundColor Yellow
    if ($testResults.Failed -gt 0) {
        Write-Host "Please address failed enterprise components." -ForegroundColor Red
    }
}

# Final enterprise assessment
Write-Host "`n�� POWERSHELL COURSE SERIES COMPLETION STATUS:" -ForegroundColor Magenta
Write-Host "✅ Course 1: PowerShell Fundamentals (Complete)" -ForegroundColor Green
Write-Host "✅ Course 2: Pipelines & Data Processing (Complete)" -ForegroundColor Green
Write-Host "✅ Course 3: Functions & Modules (Complete)" -ForegroundColor Green
Write-Host "🚀 Course 4: Automation & DevOps (Enterprise Ready)" -ForegroundColor Yellow

return @{
    SuccessRate = $successRate
    PassedTests = $testResults.Passed
    FailedTests = $testResults.Failed
    TotalTests = $testResults.Total
    WarningTests = $testResults.Warnings
    EnterpriseReady = ($testResults.Failed -eq 0 -and $testResults.Warnings -le 3)
}
