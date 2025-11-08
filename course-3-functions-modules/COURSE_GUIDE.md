# Course 3: PowerShell Functions & Modules - Course Guide

**Instructor Guide for Course 3: Advanced PowerShell Programming**

## 📖 Course Overview

This course teaches advanced PowerShell programming concepts including function creation, parameter handling, and module development. Students progress through 5 hands-on steps building practical skills for real-world PowerShell development.

## �� Learning Path

### **Step 1: Function Fundamentals (15 minutes)**
**Objective**: Create basic PowerShell functions with proper structure

**Key Concepts**:
- Function definition syntax (`function Name-Verb {}`)
- Parameter blocks with `param()`
- Return statements vs Write-Output
- Function scope and variable isolation
- Naming conventions (Verb-Noun pattern)

**Student Creates**: `step1-function-basics.ps1`
**Validation**: GitHub Actions check for function syntax, parameter usage, and execution

### **Step 2: Parameters & Validation (15 minutes)** 
**Objective**: Add robust parameter handling with validation

**Key Concepts**:
- Typed parameters (`[string]`, `[int]`, `[switch]`)
- Parameter attributes (`[Parameter(Mandatory)]`)
- Validation attributes (`[ValidateSet()]`, `[ValidateRange()]`)
- Default parameter values
- Parameter sets for multiple function behaviors

**Student Creates**: `step2-parameters.ps1`
**Validation**: Parameter validation, type checking, mandatory parameter handling

### **Step 3: Advanced Functions (15 minutes)**
**Objective**: Enable pipeline support and add help documentation

**Key Concepts**:
- `[CmdletBinding()]` attribute for advanced functions
- Pipeline input with `[Parameter(ValueFromPipeline)]`
- `begin{}`, `process{}`, `end{}` blocks
- Comment-based help with `.SYNOPSIS`, `.PARAMETER`
- Advanced parameter attributes

**Student Creates**: `step3-advanced-functions.ps1`
**Validation**: Pipeline functionality, help documentation, advanced attributes

### **Step 4: Module Creation (20 minutes)**
**Objective**: Build a complete PowerShell module

**Key Concepts**:
- Module structure (.psm1 script module)
- Module manifest (.psd1 file)
- Function export with `Export-ModuleMember`
- Module scope and isolation
- Nested modules and dependencies

**Student Creates**: `step4-module.psm1`, `step4-module.psd1`
**Validation**: Module imports correctly, functions are exported, manifest is valid

### **Step 5: Module Distribution (15 minutes)**
**Objective**: Package and distribute modules professionally

**Key Concepts**:
- Module versioning and semantic versioning
- Distribution to PowerShell Gallery
- Module testing and validation
- Enterprise deployment practices
- Module documentation and examples

**Student Creates**: `step5-distribution.ps1`
**Validation**: Module packaging, version management, documentation

## 🛠️ Technical Requirements

### **GitHub Actions Workflows**
- **Cross-platform compatibility**: All tests run on Ubuntu with PowerShell 7+
- **Progressive validation**: Each step builds on previous concepts
- **Comprehensive testing**: Syntax validation, execution tests, concept verification
- **Skills integration**: Uses `skills/action-update-step@v2` for progression

### **PowerShell Features Used**
- Functions and advanced functions
- Parameter attributes and validation
- Module system (.psm1/.psd1)
- Pipeline processing
- Comment-based help
- Scope management

## 🎓 Assessment Criteria

### **Step 1 Success Metrics**:
- ✅ Function uses proper Verb-Noun naming
- ✅ Contains `param()` block
- ✅ Uses return statements appropriately
- ✅ Demonstrates variable scope understanding

### **Step 2 Success Metrics**:
- ✅ Parameters have proper types
- ✅ Uses parameter attributes effectively
- ✅ Implements parameter validation
- ✅ Handles mandatory parameters correctly

### **Step 3 Success Metrics**:
- ✅ Function supports pipeline input
- ✅ Uses `[CmdletBinding()]` attribute
- ✅ Implements process{} blocks
- ✅ Contains comment-based help

### **Step 4 Success Metrics**:
- ✅ Module file (.psm1) is valid
- ✅ Manifest file (.psd1) is correctly structured
- ✅ Functions are properly exported
- ✅ Module imports and functions work

### **Step 5 Success Metrics**:
- ✅ Module follows distribution best practices
- ✅ Implements proper versioning
- ✅ Contains complete documentation
- ✅ Demonstrates enterprise readiness

## 🚀 Teaching Tips

### **Common Student Challenges**:
1. **Function naming**: Emphasize Verb-Noun PowerShell conventions
2. **Parameter validation**: Show practical examples of validation scenarios
3. **Pipeline concepts**: Use visual examples of data flow
4. **Module scope**: Demonstrate public vs private functions
5. **Distribution**: Connect to real-world deployment scenarios

### **Best Practices**:
- **Encourage experimentation**: Let students try different parameter combinations
- **Real-world examples**: Use practical business scenarios for functions
- **Code review**: Emphasize readable, maintainable code
- **Testing mindset**: Show how to validate function behavior
- **Documentation**: Stress importance of help and examples

### **Extension Activities**:
- Create module with multiple related functions
- Implement error handling with try/catch
- Add parameter sets for different use cases
- Create module tests with Pester framework
- Publish module to private repository

## 📋 Troubleshooting Guide

### **Common Issues**:
1. **Function not found**: Check function naming and dot-sourcing
2. **Parameter errors**: Verify parameter types and validation attributes
3. **Pipeline issues**: Ensure ValueFromPipeline is properly configured
4. **Module import fails**: Check manifest file syntax and paths
5. **Distribution problems**: Validate module structure and dependencies

### **Debugging Steps**:
1. Use `Get-Command` to verify function availability
2. Check `$Error[0]` for detailed error information
3. Use `Test-ModuleManifest` for manifest validation
4. Verify PowerShell execution policy settings
5. Check module paths with `$env:PSModulePath`

---

**Total Course Time**: 80-90 minutes  
**Difficulty Level**: Intermediate to Advanced  
**Prerequisites**: PowerShell fundamentals and pipeline knowledge
