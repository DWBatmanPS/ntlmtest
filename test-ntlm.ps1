#!/usr/bin/env powershell
# NTLM Test Script for PowerShell
# This script demonstrates testing the NTLM authentication server

param(
    [Parameter(Mandatory=$false)]
    [string]$Username = "testdomain\user1",
    
    [Parameter(Mandatory=$false)]
    [string]$Password = "password1",
    
    [Parameter(Mandatory=$false)]
    [string]$Server = "http://localhost:3000"
)

# Create credentials
Write-Host "🔐 NTLM Authentication Test Script" -ForegroundColor Cyan
Write-Host "`nServer: $Server" -ForegroundColor Yellow
Write-Host "User: $Username`n" -ForegroundColor Yellow

$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential($Username, $SecurePassword)

try {
    # Test 1: Check NTLM Status
    Write-Host "📍 Test 1: Checking NTLM Status..." -ForegroundColor Cyan
    $response = Invoke-WebRequest -Uri "$Server/api/status" -Authentication NTLM -Credential $Credential
    if ($response.StatusCode -eq 200) {
        Write-Host "✓ Success!" -ForegroundColor Green
        Write-Host $response.Content | ConvertFrom-Json | ConvertTo-Json | Out-String
    }
    
    # Test 2: Access Protected Resource
    Write-Host "`n📍 Test 2: Accessing Protected Resource..." -ForegroundColor Cyan
    $response = Invoke-WebRequest -Uri "$Server/api/protected" -Authentication NTLM -Credential $Credential
    if ($response.StatusCode -eq 200) {
        Write-Host "✓ Success!" -ForegroundColor Green
        Write-Host $response.Content | ConvertFrom-Json | ConvertTo-Json | Out-String
    }
    
    # Test 3: List Test Users
    Write-Host "📍 Test 3: Listing Test Users..." -ForegroundColor Cyan
    $response = Invoke-WebRequest -Uri "$Server/api/test-users"
    if ($response.StatusCode -eq 200) {
        Write-Host "✓ Success!" -ForegroundColor Green
        Write-Host $response.Content | ConvertFrom-Json | ConvertTo-Json | Out-String
    }
    
    Write-Host "✅ All tests completed successfully!" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Error: " -ForegroundColor Red
    Write-Host $_.Exception.Message
}
