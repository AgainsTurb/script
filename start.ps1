function Start-Program {
    param (
        [string]$ProgramPath,  # Path to the program to execute
        [string]$WorkingDir    # Working directory for the program
    )

    # Check if the program path exists
    if (-Not (Test-Path $ProgramPath)) {
        Write-Host "The specified program path does not exist." -ForegroundColor Red
        return
    }

    # Check if the working directory exists
    if (-Not (Test-Path $WorkingDir)) {
        Write-Host "The specified working directory does not exist." -ForegroundColor Red
        return
    }

    # Start a new hidden PowerShell window and execute the program with the given working directory
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = "powershell.exe"
    $psi.Arguments = "-NoProfile -ExecutionPolicy Bypass -Command `"Start-Process '$ProgramPath' -WorkingDirectory '$WorkingDir'`""
    $psi.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden  # Hide the PowerShell window

    try {
        # Start the process
        [System.Diagnostics.Process]::Start($psi)
        Write-Host "Program started successfully in a hidden PowerShell window."
    } catch {
        Write-Host "An error occurred while starting the program: $_" -ForegroundColor Red
    }
}

# Example usage:
# Start-Program -ProgramPath "C:\path\to\your\program.exe" -WorkingDir "C:\path\to\working\directory"
