function Add-Startup {
    param (
        [string]$ProgramPath
    )

    # Check if the provided program path is valid
    if (-Not (Test-Path $ProgramPath)) {
        Write-Host "The specified program path does not exist." -ForegroundColor Red
        return
    }

    # Get the name of the program (file name without extension)
    $programName = [System.IO.Path]::GetFileNameWithoutExtension($ProgramPath)

    # Define the registry path for HKCU startup
    $registryKey = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"

    # Check if the program is already in the registry
    if (Test-Path "$registryKey\$programName") {
        Write-Host "The program is already in the startup registry." -ForegroundColor Yellow
    } else {
        # Add the program to the registry to run at startup
        Set-ItemProperty -Path $registryKey -Name $programName -Value $ProgramPath
        Write-Host "The program has been added to startup." -ForegroundColor Green
    }
}

# Example of how to call the function:
# Add-Startup -ProgramPath "C:\path\to\your\program.exe"
