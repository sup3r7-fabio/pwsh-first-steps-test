# Course 3: PowerShell Functions & Modules 🛠️

**Master advanced PowerShell programming with functions, modules, and reusable code patterns.**

Welcome to the most comprehensive course in our PowerShell series! You'll learn to create professional-grade PowerShell functions and modules that can be shared, tested, and maintained effectively.

## 🎯 Learning Objectives

By completing this course, you will:

- **Create robust functions** with proper parameters and validation
- **Implement pipeline support** for seamless data processing
- **Build PowerShell modules** with manifests and proper structure
- **Apply best practices** for maintainable and distributable code
- **Understand advanced concepts** like parameter sets and dynamic parameters

## 🏗️ Course Structure

### 📍 **Step 1: Function Fundamentals**
- Create your first PowerShell function
- Understand function scope and return values
- Learn naming conventions and best practices
- **File to create**: `step1-function-basics.ps1`

### 📍 **Step 2: Parameters & Validation** 
- Add typed parameters with validation
- Implement mandatory and optional parameters
- Use parameter attributes for better UX
- **File to create**: `step2-parameters.ps1`

### 📍 **Step 3: Advanced Functions**
- Enable pipeline input with `ValueFromPipeline`
- Create comment-based help documentation
- Implement advanced parameter features
- **File to create**: `step3-advanced-functions.ps1`

### 📍 **Step 4: Module Creation**
- Build a PowerShell module (.psm1 file)
- Create module manifest (.psd1 file)
- Export functions and manage module scope
- **Files to create**: `step4-module.psm1`, `step4-module.psd1`

### 📍 **Step 5: Module Distribution**
- Package modules for distribution
- Implement module versioning
- Apply enterprise-ready best practices
- **File to create**: `step5-distribution.ps1`

## 🚀 Getting Started

1. **Fork or clone** this repository
2. **Start with Step 1** by creating `step1-function-basics.ps1`
3. **Follow each step** - GitHub Actions will validate your progress
4. **Complete all 5 steps** to become a PowerShell function expert!

## 💡 Key Concepts You'll Master

### 🔧 **Functions**
```powershell
# Basic function structure
function Get-SystemInfo {
    param(
        [string]$ComputerName = $env:COMPUTERNAME,
        [switch]$Detailed
    )
    # Function logic here
}
```

### 📦 **Modules**
```powershell
# Module manifest structure
@{
    ModuleVersion = '1.0.0'
    FunctionsToExport = @('Get-Data', 'Set-Configuration')
    Description = 'A powerful utility module'
}
```

### 🔄 **Pipeline Support**
```powershell
# Pipeline-enabled function
function Process-Data {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [string]$InputData
    )
    process {
        # Process each pipeline object
        $InputData | ForEach-Object { "Processed: $_" }
    }
}
```

## 📊 Prerequisites

- ✅ **Basic PowerShell knowledge** (variables, cmdlets, pipelines)
- ✅ **Course 1: PowerShell Fundamentals** (recommended)
- ✅ **Course 2: PowerShell Pipelines** (recommended)
- 🖥️ **PowerShell 7.0+** installed on your system

## ⏱️ Course Details

- **⏰ Duration**: 60-75 minutes
- **📈 Difficulty**: Intermediate to Advanced
- **🎓 Completion**: GitHub Actions validate each step
- **🏆 Certificate**: Completion acknowledgment upon finishing

## 🔧 What You'll Build

Throughout this course, you'll build:

1. **Utility Functions** - Reusable functions for common tasks
2. **Parameter Validators** - Functions with robust input validation
3. **Pipeline Processors** - Functions that work seamlessly in pipelines
4. **PowerShell Module** - A complete, distributable module
5. **Distribution Package** - Enterprise-ready module with best practices

## 🎉 Ready to Begin?

Start your journey to PowerShell mastery! Create your first function file and let's build something amazing together.

**Next Step**: Create `step1-function-basics.ps1` to begin! 🚀

---

*Part of the **PowerShell GitHub Skills** series - Building professional PowerShell expertise step by step.*
