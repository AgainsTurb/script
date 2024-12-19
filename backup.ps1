function Create-Backup {
    param (
        [string]$SourcePath,
        [string]$TargetPath
    )

    # Check if the source path exists
    if (-Not (Test-Path -Path $SourcePath)) {
        Write-Host "Error: The source path does not exist." -ForegroundColor Red
        return
    }

    # Check if the target path exists, if not, create it
    if (-Not (Test-Path -Path $TargetPath)) {
        Write-Host "Target path does not exist. Creating target path..." -ForegroundColor Yellow
        New-Item -Path $TargetPath -ItemType Directory
    }

    # Define the destination folder path by combining the target path with the source folder name
    $destinationFolder = Join-Path -Path $TargetPath -ChildPath (Split-Path -Leaf $SourcePath)

    # Copy the source folder to the target folder (including subfolders and files)
    try {
        Copy-Item -Path $SourcePath -Destination $destinationFolder -Recurse -Force
        Write-Host "Backup completed successfully from '$SourcePath' to '$destinationFolder'" -ForegroundColor Green
    } catch {
        Write-Host "An error occurred while creating the backup: $_" -ForegroundColor Red
    }
}

# Example of how to call the function:
# Create-Backup -SourcePath "C:\path\to\source" -TargetPath "C:\path\to\target"
