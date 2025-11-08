# Step 1: Function Fundamentals Solution
Write-Host "🔧 Step 1: Function Fundamentals Solution" -ForegroundColor Cyan

# 1. Basic function definition with proper naming convention
function Get-SystemInformation {
    param(
        [string]$ComputerName = $env:COMPUTERNAME
    )
    
    Write-Host "Getting system information for: $ComputerName" -ForegroundColor Green
    
    $info = [PSCustomObject]@{
        ComputerName = $ComputerName
        PowerShellVersion = $PSVersionTable.PSVersion.ToString()
        OperatingSystem = [System.Environment]::OSVersion.Platform
        ProcessorCount = [System.Environment]::ProcessorCount
        WorkingDirectory = Get-Location
    }
    
    return $info
}

# 2. Function with multiple parameters and default values
function Format-FileSize {
    param(
        [Parameter(Mandatory = $true)]
        [int64]$Bytes,
        [string]$Unit = "Auto"
    )
    
    switch ($Unit) {
        "KB" { return "$([math]::Round($Bytes/1KB, 2)) KB" }
        "MB" { return "$([math]::Round($Bytes/1MB, 2)) MB" }
        "GB" { return "$([math]::Round($Bytes/1GB, 2)) GB" }
        "Auto" {
            if ($Bytes -gt 1GB) { return "$([math]::Round($Bytes/1GB, 2)) GB" }
            elseif ($Bytes -gt 1MB) { return "$([math]::Round($Bytes/1MB, 2)) MB" }
            elseif ($Bytes -gt 1KB) { return "$([math]::Round($Bytes/1KB, 2)) KB" }
            else { return "$Bytes Bytes" }
        }
    }
}

# 3. Function demonstrating scope and variables
function Test-FunctionScope {
    # Local variable - only exists within this function
    $localMessage = "This is a local variable"
    
    # Accessing global variables
    $Global:FunctionTestResult = "Function executed successfully"
    
    Write-Output $localMessage
    return "Function scope test completed"
}

# 4. Function with Write-Output vs return demonstration
function Show-OutputMethods {
    Write-Output "This goes to output stream"
    Write-Host "This goes to host (console)" -ForegroundColor Yellow
    Write-Verbose "This goes to verbose stream" -Verbose
    
    # Return terminates function execution
    return "Function completed"
    
    # This line will never execute
    Write-Output "This will not appear"
}

# Demonstrate the functions
Write-Host "`n1. System Information:" -ForegroundColor White
$sysInfo = Get-SystemInformation
$sysInfo | Format-List

Write-Host "`n2. File Size Formatting:" -ForegroundColor White
Write-Host "1KB = $(Format-FileSize -Bytes 1024)"
Write-Host "1MB = $(Format-FileSize -Bytes 1048576)"
Write-Host "Custom MB = $(Format-FileSize -Bytes 1048576 -Unit MB)"

Write-Host "`n3. Function Scope Test:" -ForegroundColor White
$result = Test-FunctionScope
Write-Host "Returned: $result"
Write-Host "Global Variable: $Global:FunctionTestResult"

Write-Host "`n4. Output Methods:" -ForegroundColor White
$output = Show-OutputMethods
Write-Host "Captured Output: $output"

Write-Host "`n✅ Step 1 Complete: You understand function fundamentals!" -ForegroundColor Green
