# Step 1: Infrastructure as Code Solution - Enterprise Edition
Write-Host "🏗️ Step 1: Infrastructure as Code Solution" -ForegroundColor Cyan
Write-Host "Enterprise PowerShell Infrastructure Automation" -ForegroundColor Gray

# 1. Enterprise Infrastructure Configuration Class
class EnterpriseInfrastructure {
    [string]$Environment
    [string]$Platform
    [hashtable]$Configuration
    
    EnterpriseInfrastructure([string]$environment) {
        $this.Environment = $environment
        $this.Platform = $this.DetectPlatform()
        $this.Configuration = $this.BuildConfiguration()
    }
    
    [string] DetectPlatform() {
        if ($global:IsWindows) { return "Windows" }
        if ($global:IsLinux) { return "Linux" }
        if ($global:IsMacOS) { return "macOS" }
        return "Unix"
    }
    
    [hashtable] BuildConfiguration() {
        $baseConfig = @{
            WebServer = @{
                Port = if ($this.Environment -eq "Production") { 443 } else { 80 }
                SSL = $this.Environment -in @("Staging", "Production")
                DocumentRoot = "/tmp/enterprise-webapp"
                MaxWorkers = switch ($this.Environment) {
                    "Development" { 5 }
                    "Testing" { 10 }
                    "Staging" { 25 }
                    "Production" { 50 }
                }
            }
            Database = @{
                Type = "PostgreSQL"
                Version = "14"
                MaxConnections = switch ($this.Environment) {
                    "Development" { 20 }
                    "Testing" { 50 }
                    "Staging" { 100 }
                    "Production" { 200 }
                }
                Encrypted = $this.Environment -ne "Development"
                BackupEnabled = $this.Environment -in @("Staging", "Production")
            }
            LoadBalancer = @{
                Enabled = $this.Environment -in @("Staging", "Production")
                Algorithm = "least_connections"
                HealthCheckInterval = 30
                Nodes = switch ($this.Environment) {
                    "Development" { @("web1") }
                    "Testing" { @("web1", "web2") }
                    "Staging" { @("web1", "web2", "web3") }
                    "Production" { @("web1", "web2", "web3", "web4") }
                }
            }
            Security = @{
                FirewallEnabled = $true
                TLSVersion = "1.3"
                AuthenticationMethod = "OAuth2"
                SessionTimeout = if ($this.Environment -eq "Production") { 1800 } else { 3600 }
                AuditLogging = $this.Environment -in @("Staging", "Production")
            }
            Monitoring = @{
                Enabled = $true
                MetricsRetention = switch ($this.Environment) {
                    "Development" { 7 }
                    "Testing" { 14 }
                    "Staging" { 30 }
                    "Production" { 90 }
                }
                AlertingEnabled = $this.Environment -in @("Staging", "Production")
                LogLevel = if ($this.Environment -eq "Development") { "DEBUG" } else { "INFO" }
            }
        }
        
        return $baseConfig
    }
    
    [void] DeployInfrastructure() {
        Write-Host "🚀 Deploying $($this.Environment) infrastructure on $($this.Platform)..." -ForegroundColor Yellow
        
        try {
            $this.CreateDirectories()
            $this.DeployWebServer()
            $this.ConfigureDatabase()
            $this.SetupLoadBalancer()
            $this.ApplySecurity()
            $this.EnableMonitoring()
            $this.ValidateDeployment()
            
            Write-Host "✅ Infrastructure deployment completed successfully!" -ForegroundColor Green
        } catch {
            Write-Host "❌ Infrastructure deployment failed: $($_.Exception.Message)" -ForegroundColor Red
            throw
        }
    }
    
    [void] CreateDirectories() {
        Write-Host "  📁 Creating directory structure..." -ForegroundColor Cyan
        
        $directories = @(
            $this.Configuration.WebServer.DocumentRoot,
            "$($this.Configuration.WebServer.DocumentRoot)/api",
            "$($this.Configuration.WebServer.DocumentRoot)/assets",
            "/tmp/enterprise-logs",
            "/tmp/enterprise-config"
        )
        
        foreach ($dir in $directories) {
            if (-not (Test-Path $dir)) {
                New-Item -ItemType Directory -Path $dir -Force | Out-Null
            }
        }
    }
    
    [void] DeployWebServer() {
        Write-Host "  🌐 Deploying web server..." -ForegroundColor Cyan
        
        $webConfig = $this.Configuration.WebServer
        
        # Create enterprise index page
        $indexContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enterprise Infrastructure - $($this.Environment)</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white; min-height: 100vh; padding: 20px;
        }
        .container { max-width: 1200px; margin: 0 auto; }
        .header { text-align: center; margin-bottom: 40px; }
        .status-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; }
        .card { 
            background: rgba(255,255,255,0.1); 
            backdrop-filter: blur(10px); 
            border-radius: 15px; 
            padding: 25px; 
            border: 1px solid rgba(255,255,255,0.2);
        }
        .status { 
            display: inline-block; 
            padding: 8px 16px; 
            background: #4CAF50; 
            border-radius: 20px; 
            font-size: 0.9em; 
            font-weight: bold;
        }
        .metric { margin: 10px 0; display: flex; justify-content: space-between; }
        .metric-label { opacity: 0.8; }
        .metric-value { font-weight: bold; }
        h1 { font-size: 2.5em; margin-bottom: 10px; }
        h2 { color: #FFD700; margin-bottom: 15px; }
        .footer { text-align: center; margin-top: 40px; opacity: 0.8; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🏢 Enterprise Infrastructure Portal</h1>
            <div class="status">✅ OPERATIONAL</div>
            <p style="margin-top: 15px; font-size: 1.2em;">Environment: <strong>$($this.Environment)</strong> | Platform: <strong>$($this.Platform)</strong></p>
        </div>
        
        <div class="status-grid">
            <div class="card">
                <h2>🌐 Web Server</h2>
                <div class="metric">
                    <span class="metric-label">Port:</span>
                    <span class="metric-value">$($webConfig.Port)</span>
                </div>
                <div class="metric">
                    <span class="metric-label">SSL Enabled:</span>
                    <span class="metric-value">$($webConfig.SSL)</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Max Workers:</span>
                    <span class="metric-value">$($webConfig.MaxWorkers)</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Document Root:</span>
                    <span class="metric-value">$($webConfig.DocumentRoot)</span>
                </div>
            </div>
            
            <div class="card">
                <h2>🗄️ Database</h2>
                <div class="metric">
                    <span class="metric-label">Type:</span>
                    <span class="metric-value">$($this.Configuration.Database.Type)</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Version:</span>
                    <span class="metric-value">$($this.Configuration.Database.Version)</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Max Connections:</span>
                    <span class="metric-value">$($this.Configuration.Database.MaxConnections)</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Encryption:</span>
                    <span class="metric-value">$($this.Configuration.Database.Encrypted)</span>
                </div>
            </div>
            
            <div class="card">
                <h2>⚖️ Load Balancer</h2>
                <div class="metric">
                    <span class="metric-label">Status:</span>
                    <span class="metric-value">$(if ($this.Configuration.LoadBalancer.Enabled) { "Active" } else { "Disabled" })</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Algorithm:</span>
                    <span class="metric-value">$($this.Configuration.LoadBalancer.Algorithm)</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Nodes:</span>
                    <span class="metric-value">$($this.Configuration.LoadBalancer.Nodes.Count)</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Health Check:</span>
                    <span class="metric-value">30s</span>
                </div>
            </div>
            
            <div class="card">
                <h2>🔐 Security</h2>
                <div class="metric">
                    <span class="metric-label">Firewall:</span>
                    <span class="metric-value">$($this.Configuration.Security.FirewallEnabled)</span>
                </div>
                <div class="metric">
                    <span class="metric-label">TLS Version:</span>
                    <span class="metric-value">$($this.Configuration.Security.TLSVersion)</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Authentication:</span>
                    <span class="metric-value">$($this.Configuration.Security.AuthenticationMethod)</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Audit Logging:</span>
                    <span class="metric-value">$($this.Configuration.Security.AuditLogging)</span>
                </div>
            </div>
            
            <div class="card">
                <h2>📊 Monitoring</h2>
                <div class="metric">
                    <span class="metric-label">Status:</span>
                    <span class="metric-value">$($this.Configuration.Monitoring.Enabled)</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Log Level:</span>
                    <span class="metric-value">$($this.Configuration.Monitoring.LogLevel)</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Retention:</span>
                    <span class="metric-value">90 days</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Alerting:</span>
                    <span class="metric-value">$($this.Configuration.Monitoring.AlertingEnabled)</span>
                </div>
            </div>
            
            <div class="card">
                <h2>🚀 Deployment Info</h2>
                <div class="metric">
                    <span class="metric-label">Deployed:</span>
                    <span class="metric-value">$(Get-Date -Format 'yyyy-MM-dd HH:mm')</span>
                </div>
                <div class="metric">
                    <span class="metric-label">PowerShell:</span>
                    <span class="metric-value">$($global:PSVersionTable.PSVersion)</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Method:</span>
                    <span class="metric-value">Infrastructure as Code</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Automation:</span>
                    <span class="metric-value">PowerShell Classes</span>
                </div>
            </div>
        </div>
        
        <div class="footer">
            <p><strong>🏆 Enterprise PowerShell Infrastructure Automation</strong></p>
            <p>Powered by Infrastructure as Code | DevOps Best Practices | Zero Downtime Deployment</p>
        </div>
    </div>
</body>
</html>
"@
        
        $indexPath = "$($webConfig.DocumentRoot)/index.html"
        $indexContent | Out-File -FilePath $indexPath -Encoding utf8
        
        # Create health check endpoint
        $healthCheck = @{
            status = "healthy"
            environment = $this.Environment
            platform = $this.Platform
            timestamp = (Get-Date -Format 'yyyy-MM-ddTHH:mm:ssZ')
            version = "1.0.0"
            services = @{
                web = "active"
                database = "active"
                loadbalancer = if ($this.Configuration.LoadBalancer.Enabled) { "active" } else { "disabled" }
                monitoring = "active"
            }
        }
        
        $healthPath = "$($webConfig.DocumentRoot)/api/health.json"
        $healthCheck | ConvertTo-Json -Depth 3 | Out-File -FilePath $healthPath -Encoding utf8
    }
    
    [void] ConfigureDatabase() {
        Write-Host "  🗄️ Configuring database..." -ForegroundColor Cyan
        
        $dbConfig = $this.Configuration.Database
        $configPath = "/tmp/enterprise-config/database.json"
        
        $dbConfig | ConvertTo-Json -Depth 2 | Out-File -FilePath $configPath -Encoding utf8
    }
    
    [void] SetupLoadBalancer() {
        Write-Host "  ⚖️ Setting up load balancer..." -ForegroundColor Cyan
        
        $lbConfig = $this.Configuration.LoadBalancer
        $configPath = "/tmp/enterprise-config/loadbalancer.json"
        
        $lbConfig | ConvertTo-Json -Depth 2 | Out-File -FilePath $configPath -Encoding utf8
    }
    
    [void] ApplySecurity() {
        Write-Host "  🔐 Applying security configuration..." -ForegroundColor Cyan
        
        $secConfig = $this.Configuration.Security
        $configPath = "/tmp/enterprise-config/security.json"
        
        $secConfig | ConvertTo-Json -Depth 2 | Out-File -FilePath $configPath -Encoding utf8
    }
    
    [void] EnableMonitoring() {
        Write-Host "  📊 Enabling monitoring..." -ForegroundColor Cyan
        
        $monConfig = $this.Configuration.Monitoring
        $configPath = "/tmp/enterprise-config/monitoring.json"
        
        $monConfig | ConvertTo-Json -Depth 2 | Out-File -FilePath $configPath -Encoding utf8
    }
    
    [void] ValidateDeployment() {
        Write-Host "  ✅ Validating deployment..." -ForegroundColor Cyan
        
        $validationResults = @{
            WebServer = (Test-Path "$($this.Configuration.WebServer.DocumentRoot)/index.html")
            API = (Test-Path "$($this.Configuration.WebServer.DocumentRoot)/api/health.json")
            Database = (Test-Path "/tmp/enterprise-config/database.json")
            LoadBalancer = (Test-Path "/tmp/enterprise-config/loadbalancer.json")
            Security = (Test-Path "/tmp/enterprise-config/security.json")
            Monitoring = (Test-Path "/tmp/enterprise-config/monitoring.json")
        }
        
        $allValid = $validationResults.Values -notcontains $false
        
        if ($allValid) {
            Write-Host "    ✅ All components validated successfully" -ForegroundColor Green
        } else {
            $failed = $validationResults.Keys | Where-Object { -not $validationResults[$_] }
            throw "Validation failed for components: $($failed -join ', ')"
        }
    }
    
    [hashtable] GetInfrastructureStatus() {
        return @{
            Environment = $this.Environment
            Platform = $this.Platform
            Configuration = $this.Configuration
            DeploymentTime = Get-Date
            Status = "Deployed"
        }
    }
}

# 2. Demonstration: Enterprise Multi-Environment Deployment
Write-Host "`n🌍 Enterprise Multi-Environment Infrastructure Deployment" -ForegroundColor White
Write-Host "=========================================================" -ForegroundColor Gray

$environments = @("Development", "Testing", "Staging", "Production")
$deploymentResults = @()

foreach ($environment in $environments) {
    Write-Host "`n--- $environment Environment ---" -ForegroundColor Yellow
    
    try {
        $infrastructure = [EnterpriseInfrastructure]::new($environment)
        $infrastructure.DeployInfrastructure()
        
        $status = $infrastructure.GetInfrastructureStatus()
        $deploymentResults += $status
        
        Write-Host "    Environment: $($status.Environment)" -ForegroundColor Gray
        Write-Host "    Platform: $($status.Platform)" -ForegroundColor Gray
        Write-Host "    Status: $($status.Status)" -ForegroundColor Green
        
    } catch {
        Write-Host "    ❌ Failed: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# 3. Enterprise Infrastructure Summary
Write-Host "`n📊 Enterprise Infrastructure Deployment Summary" -ForegroundColor Magenta
Write-Host "===============================================" -ForegroundColor Gray

Write-Host "Successfully Deployed Environments: $($deploymentResults.Count)" -ForegroundColor Green
Write-Host "Target Platform: $($deploymentResults[0].Platform)" -ForegroundColor Green
Write-Host "Infrastructure Components: Web Server, Database, Load Balancer, Security, Monitoring" -ForegroundColor Green
Write-Host "Deployment Method: PowerShell Classes + Infrastructure as Code" -ForegroundColor Green

# Display environment configurations
foreach ($result in $deploymentResults) {
    $env = $result.Environment
    $webPort = $result.Configuration.WebServer.Port
    $dbConnections = $result.Configuration.Database.MaxConnections
    $lbEnabled = $result.Configuration.LoadBalancer.Enabled
    
    Write-Host "$env : Port $webPort, DB Connections $dbConnections, LB $(if ($lbEnabled) { 'Enabled' } else { 'Disabled' })" -ForegroundColor Cyan
}

Write-Host "`n✅ Step 1 Complete: Enterprise Infrastructure as Code mastery achieved!" -ForegroundColor Green
Write-Host "🏢 You can now deploy scalable enterprise infrastructure across any environment!" -ForegroundColor Cyan
Write-Host "🚀 Ready for CI/CD pipelines, monitoring, and production deployment!" -ForegroundColor Yellow
