$ErrorActionPreference = "Stop"
$HostDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "============================================" -ForegroundColor Cyan
Write-Host " YT Downloader - Native Host Installer (EXE)" -ForegroundColor Cyan
Write-Host "============================================"
Write-Host ""

# Find host.exe
$HostExe = Join-Path $HostDir "host.exe"
if (-not (Test-Path $HostExe)) {
    Write-Host "[ERROR] host.exe not found. Please extract all files correctly." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host "[OK] Native Host: host.exe detected." -ForegroundColor Green

# Extension ID input
Write-Host ""
Write-Host "--------------------------------------------------------" -ForegroundColor Yellow
Write-Host " STEP 2: Register the extension in your browser" -ForegroundColor Yellow
Write-Host "--------------------------------------------------------"
Write-Host "1. Open chrome://extensions/ in Chrome."
Write-Host "2. Turn ON 'Developer mode' in the top right."
Write-Host "3. Drag and drop the 'extension' folder into the browser."
Write-Host "4. Copy the 'ID' (e.g., abcdefg...) and paste it below."
Write-Host "--------------------------------------------------------"
Write-Host ""
$ExtId = Read-Host "Enter your Extension ID"
if ($null -ne $ExtId) { $ExtId = $ExtId.Trim() }

if ([string]::IsNullOrWhiteSpace($ExtId) -or $ExtId.Length -lt 20) {
    Write-Host "[ERROR] Invalid Extension ID. Please try again." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Generate host_manifest_installed.json
Write-Host "Generating manifest file..." -ForegroundColor Yellow
$ManifestOut = Join-Path $HostDir "host_manifest_installed.json"
$HostExeFwd = $HostExe -replace [regex]::Escape("\"), "\\\\"
$json = "{`n  `"name`": `"com.ytdownloader.host`",`n  `"description`": `"YT Downloader Native Messaging Host`",`n  `"path`": `"$HostExeFwd`",`n  `"type`": `"stdio`",`n  `"allowed_origins`": [`n    `"chrome-extension://$ExtId/`"`n  ]`n}"
[System.IO.File]::WriteAllText($ManifestOut, $json, [System.Text.Encoding]::UTF8)
Write-Host "[OK] Manifest: $ManifestOut" -ForegroundColor Green

# Register in Windows registry
$RegPath = "HKCU:\Software\Google\Chrome\NativeMessagingHosts\com.ytdownloader.host"
Write-Host "Registering in Windows Registry..." -ForegroundColor Yellow
try {
    if (-not (Test-Path $RegPath)) {
        New-Item -Path $RegPath -Force | Out-Null
    }
    Set-ItemProperty -Path $RegPath -Name "(default)" -Value $ManifestOut
    Write-Host "[OK] Registry registered successfully!" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Failed to register registry: $($_.Exception.Message)" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Setup Complete! ✨" -ForegroundColor Cyan
Write-Host "============================================"
Write-Host "  1. Restart your browser."
Write-Host "  2. Open YouTube and enjoy the extension!"
Write-Host ""
Read-Host "Press Enter to exit"