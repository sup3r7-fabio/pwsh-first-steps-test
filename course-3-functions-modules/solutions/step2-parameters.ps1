# Step 2: Parameters & Validation Solution
Write-Host "🔧 Step 2: Parameters & Validation Solution" -ForegroundColor Cyan

# 1. Function with typed parameters and validation
function New-UserAccount {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateLength(3, 20)]
        [string]$Username,
        
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^\w+@\w+\.\w+$')]
        [string]$Email,
        
        [ValidateRange(18, 120)]
        [int]$Age = 25,
        
        [ValidateSet("Admin", "User", "Guest")]
        [string]$Role = "User",
        
        [switch]$SendWelcomeEmail
    )
    
    Write-Host "Creating user account..." -ForegroundColor Green
    
    $user = [PSCustomObject]@{
        Username = $Username
        Email = $Email
        Age = $Age
        Role = $Role
        Created = Get-Date
        WelcomeEmailSent = $SendWelcomeEmail.IsPresent
    }
    
    if ($SendWelcomeEmail) {
        Write-Host "📧 Welcome email would be sent to $Email" -ForegroundColor Yellow
    }
    
    return $user
}

# 2. Function with parameter sets for different behaviors
function Get-ProcessInformation {
    [CmdletBinding(DefaultParameterSetName = "ByName")]
    param(
        [Parameter(ParameterSetName = "ByName", Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$ProcessName,
        
        [Parameter(ParameterSetName = "ById", Mandatory = $true)]
        [ValidateRange(1, 99999)]
        [int]$ProcessId,
        
        [Parameter(ParameterSetName = "All")]
        [switch]$All,
        
        [ValidateSet("Name", "Id", "CPU", "Memory")]
        [string]$SortBy = "Name"
    )
    
    switch ($PSCmdlet.ParameterSetName) {
        "ByName" {
            $processes = Get-Process -Name "*$ProcessName*" -ErrorAction SilentlyContinue
            Write-Host "Found $($processes.Count) processes matching '$ProcessName'" -ForegroundColor Green
        }
        "ById" {
            $processes = Get-Process -Id $ProcessId -ErrorAction SilentlyContinue
            Write-Host "Found process with ID: $ProcessId" -ForegroundColor Green
        }
        "All" {
            $processes = Get-Process | Select-Object -First 10
            Write-Host "Showing first 10 processes" -ForegroundColor Green
        }
    }
    
    if ($processes) {
        switch ($SortBy) {
            "Name" { $processes = $processes | Sort-Object Name }
            "Id" { $processes = $processes | Sort-Object Id }
            "CPU" { $processes = $processes | Sort-Object CPU -Descending }
            "Memory" { $processes = $processes | Sort-Object WorkingSet -Descending }
        }
        
        return $processes | Select-Object Name, Id, 
            @{Name="MemoryMB"; Expression={[math]::Round($_.WorkingSet/1MB, 2)}},
            @{Name="Status"; Expression={"Running"}}
    } else {
        Write-Warning "No processes found with specified criteria"
        return $null
    }
}

# 3. Function with complex validation and error handling
function Set-ConfigurationValue {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript({
            if (Test-Path $_) { $true }
            else { throw "Configuration file '$_' does not exist" }
        })]
        [string]$ConfigFile,
        
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Key,
        
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [string]$Value,
        
        [ValidateSet("String", "Integer", "Boolean", "Array")]
        [string]$Type = "String",
        
        [switch]$Force
    )
    
    Write-Host "Setting configuration: $Key = $Value (Type: $Type)" -ForegroundColor Green
    
    # Simulate configuration update
    $config = @{
        File = $ConfigFile
        Key = $Key
        Value = $Value
        Type = $Type
        Timestamp = Get-Date
        UpdatedBy = $env:USERNAME
    }
    
    if ($Force) {
        Write-Host "⚠️  Force mode: Overwriting existing value" -ForegroundColor Yellow
    }
    
    return $config
}

# Demonstrate the functions
Write-Host "`n1. Creating User Account:" -ForegroundColor White
try {
    $user1 = New-UserAccount -Username "johnsmith" -Email "john@company.com" -Age 30 -Role "Admin" -SendWelcomeEmail
    $user1 | Format-List
} catch {
    Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n2. Getting Process Information:" -ForegroundColor White
$processes = Get-ProcessInformation -ProcessName "pwsh" -SortBy "Memory"
if ($processes) {
    $processes | Format-Table -AutoSize
}

Write-Host "`n3. Configuration Management:" -ForegroundColor White
# Create a dummy config file for demonstration
$dummyConfig = "dummy-config.txt"
"# Configuration File" | Out-File $dummyConfig -Encoding utf8

try {
    $configResult = Set-ConfigurationValue -ConfigFile $dummyConfig -Key "MaxRetries" -Value "5" -Type "Integer" -Force
    $configResult | Format-List
} catch {
    Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
} finally {
    # Clean up dummy file
    if (Test-Path $dummyConfig) { Remove-Item $dummyConfig -Force }
}

Write-Host "`n✅ Step 2 Complete: You can create robust functions with validation!" -ForegroundColor Green
