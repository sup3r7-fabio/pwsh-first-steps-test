# PowerShell First Steps

_Learn the basics of PowerShell through hands-on practice in this interactive GitHub Skills course._

## Welcome

PowerShell is a powerful command-line shell and scripting language built for task automation and configuration management. Whether you're managing files, automating repetitive tasks, or building complex scripts, PowerShell gives you the tools to work efficiently across Windows, macOS, and Linux.

In this course, you'll learn fundamental PowerShell concepts through practical, hands-on exercises right here in GitHub. By the end of this course, you'll be comfortable with the PowerShell environment and ready to start building your own scripts.

- **Who is this for**: Beginners new to PowerShell or command-line interfaces
- **What you'll learn**: PowerShell basics, cmdlet structure, help system, and your first scripts
- **What you'll build**: A collection of PowerShell scripts demonstrating core concepts
- **Prerequisites**: Basic computer skills, willingness to learn
- **How long**: Approximately 1 hour (5 steps)

## How to start this course

<!-- For start course, run in JavaScript:
'https://github.com/new?' + new URLSearchParams({
  template_owner: 'sup3r7-fabio',
  template_name: 'pwsh-github-skills-tutorial',
  owner: '@me',
  name: 'pwsh-first-steps',
  description: 'My PowerShell First Steps course',
  visibility: 'private',
}).toString()
-->

[![start-course](https://user-images.githubusercontent.com/1221423/235727646-4a590299-ffe5-4be8-8cd8-8cce05a8ca12.svg)](https://github.com/new?template_owner=sup3r7-fabio&template_name=pwsh-github-skills-tutorial&owner=%40me&name=pwsh-first-steps&description=My+PowerShell+First+Steps+course&visibility=private)

1. Right-click **Start course** and open the link in a new tab.
2. In the new tab, most of the prompts will automatically fill in for you.
   - For owner, choose your personal account or an organization to host the repository.
   - We recommend creating a public repository, as private repositories will [use Actions minutes](https://docs.github.com/en/billing/managing-billing-for-github-actions/about-billing-for-github-actions).
   - Scroll down and click the **Create repository** button at the bottom of the form.
3. After your new repository is created, wait about 20 seconds, then refresh the page. Follow the step-by-step instructions in the new repository's README.

<details id=0>
<summary><h2>Step 1: Your PowerShell environment</h2></summary>

_Welcome to PowerShell First Steps! :wave:_

**What is PowerShell?** PowerShell is a cross-platform task automation solution made up of a command-line shell, a scripting language, and a configuration management framework. PowerShell runs on Windows, Linux, and macOS.

Unlike traditional command-line interfaces that work with text, PowerShell works with objects. This means you can access properties and methods of data, making complex tasks much simpler.

### :keyboard: Activity: Check your PowerShell version

Let's start by verifying your PowerShell installation and learning your first cmdlet.

1. Open a PowerShell terminal on your computer
   - **Windows**: Search for "PowerShell" in the Start menu
   - **macOS**: Open Terminal and type `pwsh` (requires PowerShell installation)
   - **Linux**: Open terminal and type `pwsh` (requires PowerShell installation)

2. Run your first PowerShell command to check the version:
   ```powershell
   $PSVersionTable
   ```

3. Create a new file in your repository called `my-first-script.ps1`
4. Add the following PowerShell code to document your environment:
   ```powershell
   # My First PowerShell Script
   # This script displays basic system information
   
   Write-Host "Welcome to PowerShell!" -ForegroundColor Green
   Write-Host "PowerShell Version: $($PSVersionTable.PSVersion)" -ForegroundColor Cyan
   Write-Host "Current Date and Time: $(Get-Date)" -ForegroundColor Yellow
   Write-Host "Current Location: $(Get-Location)" -ForegroundColor Magenta
   ```

5. Commit your new file with the message "Add my first PowerShell script"

Wait about 20 seconds then refresh this page (the one you're following instructions from). [GitHub Actions](https://docs.github.com/en/actions) will automatically update to the next step.

</details>

<details id=1>
<summary><h2>Step 2: Understanding cmdlets</h2></summary>

_Great job adding your first PowerShell script! :tada:_

**What are cmdlets?** Cmdlets (pronounced "command-lets") are the building blocks of PowerShell. They follow a consistent Verb-Noun naming convention, making them intuitive to use and remember.

### Common cmdlet patterns:
- `Get-*`: Retrieves information (Get-Date, Get-Location, Get-Process)
- `Set-*`: Changes configuration (Set-Location, Set-ExecutionPolicy)
- `New-*`: Creates something new (New-Item, New-Directory)
- `Remove-*`: Deletes something (Remove-Item, Remove-Variable)

### :keyboard: Activity: Explore essential cmdlets

1. Create a new file called `cmdlet-exploration.ps1`
2. Add the following PowerShell code to practice with essential cmdlets:
   ```powershell
   # Cmdlet Exploration Script
   # Learning the fundamental PowerShell cmdlets
   
   Write-Host "=== PowerShell Cmdlet Exploration ===" -ForegroundColor Green
   Write-Host ""
   
   # Get current date and time
   Write-Host "1. Current Date and Time:" -ForegroundColor Cyan
   Get-Date
   Write-Host ""
   
   # Get current working directory
   Write-Host "2. Current Directory:" -ForegroundColor Cyan
   Get-Location
   Write-Host ""
   
   # List files in current directory
   Write-Host "3. Files in Current Directory:" -ForegroundColor Cyan
   Get-ChildItem
   Write-Host ""
   
   # Get system information
   Write-Host "4. Computer Information:" -ForegroundColor Cyan
   Get-ComputerInfo | Select-Object WindowsProductName, TotalPhysicalMemory, CsProcessors
   Write-Host ""
   
   # Display running processes (top 5 by CPU)
   Write-Host "5. Top 5 Processes by CPU:" -ForegroundColor Cyan
   Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 Name, CPU, WorkingSet
   ```

3. Commit your changes with the message "Add cmdlet exploration script"

Wait about 20 seconds then refresh this page for the next step.

</details>

<details id=2>
<summary><h2>Step 3: Getting help</h2></summary>

_Excellent work exploring cmdlets! :rocket:_

**PowerShell's built-in help system** is one of its most powerful features. You can get detailed information about any cmdlet, including syntax, parameters, and examples.

### Help system basics:
- `Get-Help <cmdlet>`: Basic help information
- `Get-Help <cmdlet> -Examples`: See practical examples
- `Get-Help <cmdlet> -Full`: Complete documentation
- `Get-Help <cmdlet> -Online`: Open web-based help

### :keyboard: Activity: Master the help system

1. Create a new file called `help-system-demo.ps1`
2. Add this PowerShell code to demonstrate the help system:
   ```powershell
   # PowerShell Help System Demonstration
   # Learning to find information about cmdlets
   
   Write-Host "=== PowerShell Help System Demo ===" -ForegroundColor Green
   Write-Host ""
   
   # Demonstrate Get-Help basics
   Write-Host "Getting help for Get-Process cmdlet:" -ForegroundColor Cyan
   Write-Host "Syntax: Get-Help Get-Process" -ForegroundColor Yellow
   Write-Host ""
   
   # Show cmdlet syntax
   Write-Host "Command Syntax:" -ForegroundColor Cyan
   Get-Command Get-Process | Select-Object Name, Definition
   Write-Host ""
   
   # Find commands with wildcards
   Write-Host "Finding all 'Get-*' commands related to files:" -ForegroundColor Cyan
   Get-Command Get-*Item* | Select-Object Name, Source
   Write-Host ""
   
   # Demonstrate parameter information
   Write-Host "Parameters for Get-ChildItem:" -ForegroundColor Cyan
   (Get-Command Get-ChildItem).Parameters.Keys | Sort-Object
   Write-Host ""
   
   Write-Host "💡 Pro Tip: Use Tab completion!" -ForegroundColor Green
   Write-Host "Type 'Get-' and press Tab to cycle through available cmdlets" -ForegroundColor Yellow
   ```

3. Commit your changes with the message "Add help system demonstration"

Wait about 20 seconds then refresh this page for the next step.

</details>

<details id=3>
<summary><h2>Step 4: Working with objects</h2></summary>

_You're mastering the help system! :brain:_

**PowerShell objects** are the key to PowerShell's power. Unlike text-based shells, PowerShell works with rich .NET objects that have properties and methods. This makes data manipulation much more powerful and precise.

### Object concepts:
- **Properties**: Data stored in the object (like Name, Size, CreationTime)
- **Methods**: Actions you can perform on the object (like Delete(), CopyTo())
- **Get-Member**: Shows you what properties and methods are available

### :keyboard: Activity: Explore PowerShell objects

1. Create a new file called `object-exploration.ps1`
2. Add this PowerShell code to work with objects:
   ```powershell
   # PowerShell Objects Exploration
   # Understanding properties, methods, and object manipulation
   
   Write-Host "=== PowerShell Objects Exploration ===" -ForegroundColor Green
   Write-Host ""
   
   # Get file objects and explore their properties
   Write-Host "1. File Object Properties:" -ForegroundColor Cyan
   $files = Get-ChildItem -File | Select-Object -First 3
   foreach ($file in $files) {
       Write-Host "File: $($file.Name)" -ForegroundColor Yellow
       Write-Host "  Size: $($file.Length) bytes" -ForegroundColor White
       Write-Host "  Created: $($file.CreationTime)" -ForegroundColor White
       Write-Host "  Extension: $($file.Extension)" -ForegroundColor White
       Write-Host ""
   }
   
   # Working with date objects
   Write-Host "2. Date Object Manipulation:" -ForegroundColor Cyan
   $now = Get-Date
   Write-Host "Current time: $($now.ToString('yyyy-MM-dd HH:mm:ss'))" -ForegroundColor White
   Write-Host "Day of week: $($now.DayOfWeek)" -ForegroundColor White
   Write-Host "Day of year: $($now.DayOfYear)" -ForegroundColor White
   Write-Host "Tomorrow: $($now.AddDays(1).ToString('yyyy-MM-dd'))" -ForegroundColor White
   Write-Host ""
   
   # Working with process objects
   Write-Host "3. Process Object Analysis:" -ForegroundColor Cyan
   $processes = Get-Process | Where-Object {$_.WorkingSet -gt 50MB} | Select-Object -First 5
   foreach ($proc in $processes) {
       $memoryMB = [math]::Round($proc.WorkingSet / 1MB, 2)
       Write-Host "Process: $($proc.Name)" -ForegroundColor Yellow
       Write-Host "  Memory: $memoryMB MB" -ForegroundColor White
       Write-Host "  ID: $($proc.Id)" -ForegroundColor White
       Write-Host ""
   }
   
   Write-Host "💡 Try this: Get-Process | Get-Member" -ForegroundColor Green
   Write-Host "This shows all properties and methods available on process objects!" -ForegroundColor Yellow
   ```

3. Commit your changes with the message "Add object exploration script"

Wait about 20 seconds then refresh this page for the next step.

</details>

<details id=4>
<summary><h2>Step 5: Your first automation script</h2></summary>

_Amazing! You understand PowerShell objects! :sparkles:_

Now let's put everything together and create a practical automation script that demonstrates all the concepts you've learned.

### :keyboard: Activity: Build your first automation script

1. Create a new file called `system-report.ps1`
2. Add this comprehensive PowerShell automation script:
   ```powershell
   # System Report Generator
   # A comprehensive script demonstrating PowerShell fundamentals
   
   # Script header with information
   Write-Host "================================" -ForegroundColor Green
   Write-Host "   PowerShell System Report" -ForegroundColor Green
   Write-Host "   Generated: $(Get-Date)" -ForegroundColor Green
   Write-Host "================================" -ForegroundColor Green
   Write-Host ""
   
   # 1. System Information
   Write-Host "SYSTEM INFORMATION" -ForegroundColor Cyan
   Write-Host "==================" -ForegroundColor Cyan
   $computerInfo = Get-ComputerInfo
   Write-Host "Computer Name: $($computerInfo.CsName)" -ForegroundColor White
   Write-Host "Operating System: $($computerInfo.WindowsProductName)" -ForegroundColor White
   Write-Host "PowerShell Version: $($PSVersionTable.PSVersion)" -ForegroundColor White
   Write-Host "Total RAM: $([math]::Round($computerInfo.TotalPhysicalMemory / 1GB, 2)) GB" -ForegroundColor White
   Write-Host ""
   
   # 2. Disk Space Information
   Write-Host "DISK SPACE REPORT" -ForegroundColor Cyan
   Write-Host "=================" -ForegroundColor Cyan
   $drives = Get-WmiObject -Class Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3}
   foreach ($drive in $drives) {
       $freeSpaceGB = [math]::Round($drive.FreeSpace / 1GB, 2)
       $totalSpaceGB = [math]::Round($drive.Size / 1GB, 2)
       $percentFree = [math]::Round(($drive.FreeSpace / $drive.Size) * 100, 1)
       
       Write-Host "Drive $($drive.DeviceID)" -ForegroundColor Yellow
       Write-Host "  Total Space: $totalSpaceGB GB" -ForegroundColor White
       Write-Host "  Free Space: $freeSpaceGB GB ($percentFree%)" -ForegroundColor White
       Write-Host ""
   }
   
   # 3. Running Services (top 10 by status)
   Write-Host "TOP RUNNING SERVICES" -ForegroundColor Cyan
   Write-Host "===================" -ForegroundColor Cyan
   $services = Get-Service | Where-Object {$_.Status -eq 'Running'} | Select-Object -First 10
   foreach ($service in $services) {
       Write-Host "$($service.Name) - $($service.DisplayName)" -ForegroundColor White
   }
   Write-Host ""
   
   # 4. Network Information
   Write-Host "NETWORK CONFIGURATION" -ForegroundColor Cyan
   Write-Host "====================" -ForegroundColor Cyan
   $networkAdapters = Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}
   foreach ($adapter in $networkAdapters) {
       Write-Host "Adapter: $($adapter.Name)" -ForegroundColor Yellow
       Write-Host "  Status: $($adapter.Status)" -ForegroundColor White
       Write-Host "  Speed: $($adapter.LinkSpeed)" -ForegroundColor White
       Write-Host ""
   }
   
   # 5. Recent System Events (last 24 hours)
   Write-Host "RECENT SYSTEM EVENTS" -ForegroundColor Cyan
   Write-Host "===================" -ForegroundColor Cyan
   $yesterday = (Get-Date).AddDays(-1)
   $events = Get-EventLog -LogName System -After $yesterday -EntryType Error, Warning | Select-Object -First 5
   
   if ($events.Count -gt 0) {
       foreach ($event in $events) {
           Write-Host "[$($event.TimeGenerated)] $($event.EntryType): $($event.Message.Substring(0, [Math]::Min(80, $event.Message.Length)))..." -ForegroundColor White
       }
   } else {
       Write-Host "No recent errors or warnings found." -ForegroundColor Green
   }
   
   Write-Host ""
   Write-Host "Report completed successfully!" -ForegroundColor Green
   Write-Host "You now know PowerShell fundamentals! 🎉" -ForegroundColor Yellow
   ```

3. Create a simple runner script called `run-report.ps1`:
   ```powershell
   # Simple script to demonstrate execution
   Write-Host "Running PowerShell System Report..." -ForegroundColor Green
   
   # Check if system-report.ps1 exists
   if (Test-Path "system-report.ps1") {
       . .\system-report.ps1
   } else {
       Write-Host "Error: system-report.ps1 not found!" -ForegroundColor Red
   }
   ```

4. Commit your changes with the message "Add comprehensive system report automation script"

Wait about 20 seconds then refresh this page for the completion!

</details>

<details id=X>
<summary><h2>Finish</h2></summary>

_Congratulations! You've completed PowerShell First Steps! :trophy:_

<img src="https://octodex.github.com/images/constructocat2.jpg" alt="Celebration" width="300" align="right">

## What you accomplished

In this course, you've learned the fundamental building blocks of PowerShell:

- ✅ **PowerShell Environment**: You learned how to launch PowerShell and check your installation
- ✅ **Cmdlet Structure**: You mastered the Verb-Noun naming convention and essential commands
- ✅ **Help System**: You discovered how to find information about any PowerShell cmdlet
- ✅ **Object Understanding**: You learned that PowerShell works with rich .NET objects, not just text
- ✅ **Practical Automation**: You built a comprehensive system reporting script

## What you built

You created several PowerShell scripts demonstrating core concepts:
- `my-first-script.ps1` - Your introduction to PowerShell
- `cmdlet-exploration.ps1` - Essential cmdlet practice
- `help-system-demo.ps1` - Mastering PowerShell help
- `object-exploration.ps1` - Working with PowerShell objects
- `system-report.ps1` - A complete automation script

## What's next?

Now that you have PowerShell fundamentals, you're ready for intermediate topics:

### 🚀 **Recommended Next Courses:**
- **PowerShell Pipelines & Filtering** - Learn to chain commands effectively
- **Variables & Data Structures** - Master PowerShell data handling  
- **Functions & Modules** - Build reusable PowerShell code
- **File System Automation** - Automate file and folder operations
- **Error Handling & Debugging** - Write robust, production-ready scripts

### 📚 **Additional Resources:**
- [Microsoft PowerShell Documentation](https://docs.microsoft.com/en-us/powershell/)
- [PowerShell Gallery](https://www.powershellgallery.com/) - Community modules and scripts
- [PowerShell Community](https://github.com/PowerShell/PowerShell) - Join the conversation

### 💡 **Keep Learning:**
- Practice daily with small automation tasks
- Join PowerShell communities and forums
- Build scripts to solve real problems you face
- Explore PowerShell modules for your specific needs

## Feedback

We'd love to hear about your experience! Your feedback helps us improve these courses.

- **Share your success** on social media with #PowerShellSkills
- **Report issues** in this repository's Issues tab
- **Suggest improvements** via Pull Requests

Thank you for completing PowerShell First Steps! You're now ready to harness the power of automation with PowerShell. 🎉

</details>

## Get help

If you feel stuck, or are experiencing other problems, you can:

- [Review the GitHub status page](https://www.githubstatus.com/)
- [Ask for help in GitHub Community](https://github.community/)
- [Contact GitHub Support](https://support.github.com/)

---

&copy; 2025 GitHub &bull; [Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct/code_of_conduct.md) &bull; [MIT License](https://gh.io/mit)
