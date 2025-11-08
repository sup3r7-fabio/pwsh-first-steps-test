# Course 2: PowerShell Pipelines & Filtering

## 📋 Course Structure

This course teaches PowerShell pipeline and filtering concepts through 5 progressive steps:

### Step 0: Course Introduction
- **File**: Automatic (GitHub Actions)
- **Concept**: Welcome and course overview
- **Time**: 2-3 minutes

### Step 1: Pipeline Basics 
- **File**: `step1-pipeline-basics.ps1`
- **Concepts**: Object flow, pipeline fundamentals, `Get-Member`, `Measure-Object`
- **Time**: 10-12 minutes

### Step 2: Filtering with Where-Object
- **File**: `step2-filtering.ps1`
- **Concepts**: Comparison operators, pattern matching, logical operators
- **Time**: 15-18 minutes

### Step 3: Selecting and Transforming Data
- **File**: `step3-selecting.ps1`
- **Concepts**: Property selection, calculated fields, data slicing
- **Time**: 15-18 minutes

### Step 4: Sorting and Organizing Data
- **File**: `step4-sorting.ps1`
- **Concepts**: Sorting, grouping, statistical analysis
- **Time**: 12-15 minutes

### Step 5: Advanced Pipeline Techniques
- **File**: `step5-advanced-pipelines.ps1`
- **Concepts**: Complex chains, performance, error handling
- **Time**: 15-20 minutes

---

## 🎯 Learning Objectives

### Knowledge Objectives
Students will understand:
- How PowerShell pipelines pass objects (not text)
- The role of each major pipeline cmdlet
- When to use filtering vs. selection vs. sorting
- Performance implications of pipeline operations

### Skill Objectives  
Students will be able to:
- Build multi-stage data processing pipelines
- Filter data with complex conditions
- Transform object properties and create calculated fields
- Sort and group data for analysis
- Handle errors gracefully in pipelines
- Measure and optimize pipeline performance

### Application Objectives
Students will create:
- System monitoring scripts using pipelines
- Data analysis reports from raw system information
- Performance measurement tools
- Custom object transformation workflows

---

## 🛠️ Technical Requirements

### PowerShell Version
- **Minimum**: PowerShell 5.1
- **Recommended**: PowerShell 7.x or later
- **Cross-Platform**: Windows, macOS, Linux

### System Requirements
- Access to system services and processes for examples
- File system read permissions for file analysis exercises
- Minimum 512MB RAM for large data set exercises

### Prerequisites
- Basic PowerShell command execution
- Understanding of variables and basic data types
- Familiarity with PowerShell console/ISE
- Completion of Course 1 (PowerShell Fundamentals) recommended

---

## 📚 Key Commands Covered

### Core Pipeline Commands
- `Get-Service` - Retrieve system services
- `Get-Process` - Retrieve running processes  
- `Get-ChildItem` - File system navigation
- `Where-Object` - Object filtering
- `Select-Object` - Property selection and transformation
- `Sort-Object` - Data sorting
- `Group-Object` - Data grouping
- `Measure-Object` - Statistical analysis
- `ForEach-Object` - Individual object processing

### Supporting Commands
- `Get-Member` - Object structure inspection
- `Format-Table` - Tabular output formatting
- `Out-File` - File output
- `Test-Path` - Path validation

### Advanced Techniques
- Calculated properties with hashtables
- Pipeline error handling with `-ErrorAction`
- Performance measurement with `[System.Diagnostics.Stopwatch]`
- Custom object creation with `[PSCustomObject]`

---

## 🎓 Assessment Criteria

### Automatic Validation
Each step includes automated validation that checks for:
- Required script file existence
- Presence of key PowerShell commands
- Successful script execution
- Correct syntax and structure

### Manual Assessment Points
Instructors should evaluate:
- **Code Quality**: Clean, readable, well-commented scripts
- **Concept Understanding**: Proper use of pipeline concepts
- **Problem Solving**: Creative solutions to exercises
- **Best Practices**: Following PowerShell conventions

### Proficiency Indicators
- **Beginner**: Can execute basic pipelines with guidance
- **Intermediate**: Creates multi-step pipelines independently
- **Advanced**: Optimizes pipelines for performance and handles edge cases

---

## 🔄 Course Flow and Progression

### Validation Triggers
Each step validates when the student creates the required script file and pushes to the repository. GitHub Actions automatically:

1. Checks for file existence
2. Validates required commands are present
3. Executes the script to ensure it works
4. Tests specific pipeline concepts
5. Advances to the next step on success

### Error Handling
If validation fails:
- Clear error messages guide the student
- Specific missing elements are identified
- Students can retry without penalty
- Help resources are provided

### Completion Recognition
Upon course completion:
- Automatic generation of completion certificate
- Badge creation with skills summary
- Guidance for next course recommendations

---

## 📖 Additional Resources

### Microsoft Learn Paths
- [PowerShell Pipeline Basics](https://docs.microsoft.com/learn/modules/powershell-pipeline/)
- [Working with Objects in PowerShell](https://docs.microsoft.com/learn/modules/powershell-objects/)
- [PowerShell Scripting Performance](https://docs.microsoft.com/learn/modules/optimize-powershell/)

### Community Resources
- [PowerShell.org Community](https://powershell.org/)
- [PowerShell Gallery](https://powershellgallery.com/)
- [Reddit PowerShell Community](https://reddit.com/r/PowerShell/)

### Advanced Topics
After completing this course, consider:
- Course 3: PowerShell Functions & Modules
- Course 4: PowerShell Error Handling & Debugging  
- Course 5: PowerShell File & Registry Operations

---

## 🤝 Contributing

This course is designed to be:
- **Interactive**: Hands-on exercises with real system data
- **Progressive**: Each step builds on previous knowledge
- **Practical**: Real-world scenarios and use cases
- **Validated**: Automatic checking ensures learning objectives are met

For suggestions or improvements, please open an issue or submit a pull request.
