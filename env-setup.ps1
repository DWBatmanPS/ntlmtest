
# Define the download URL and the destination
$nodeJsUrl = "https://nodejs.org/dist/v24.12.0/node-v24.12.0-x64.msi"
$destination = "$env:TEMP\nodejs_installer.msi"

# Download NodeJS installer
Invoke-WebRequest -Uri $nodeJsUrl -OutFile $destination

# Install NodeJS silently
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i $env:TEMP\nodejs_installer.msi /qn" -Wait

$githubInstallerUrl = "https://github.com/git-for-windows/git/releases/download/v2.52.0.windows.1/Git-2.52.0-64-bit.exe"
$destinationGit = "$env:TEMP\GitInstaller.exe"

Invoke-WebRequest -Uri $githubInstallerUrl -OutFile $destinationGit

Start-Process -FilePath $destinationGit -ArgumentList "/VERYSILENT", "/NORESTART",  -Wait
