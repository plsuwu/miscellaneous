#Requires -RunAsAdministrator

# -------------------------------
# NOT NECESSARILY WORKING :))
# -------------------------------

# run with `Invoke-RestMethod` & `Invoke-Expression` directly from GitHub:
# ----------------------------------------------------------------------------------------------------------------
# iex "& { $(irm raw.githubusercontent.com/plsuwu/miscellaneous/main/install-scripts/vm_windows.ps1) } -<args?>"
# ----------------------------------------------------------------------------------------------------------------

# fresh VMs can likely run the script without args:
# ----------------------------------------------------------------------------------------------------------------
# irm raw.githubusercontent.com/plsuwu/miscellaneous/main/install-scripts/vm_windows.ps1 | iex
# ----------------------------------------------------------------------------------------------------------------



param (
    [switch] $NoPyverInstall = $false,
    [switch] $NoOfficeInstall = $false
)

Set-ExecutionPolicy Bypass -Scope CurrentUser;
$chocoPath = "C:\ProgramData\chocolatey\bin\"

# -- pyenv & python vers --
Write-Host " "

# if pyenv isnt on PATH (which it likely isn't if this is a fresh machine), the script will break after pyenv installation:
# -------------------------------------------------------------------------------------------------------------------------

# before installing pyenv --> 
# 1. check for $PROFILE, (create with `New-Item $PROFILE` if not present), 
# 2. source with `. $PROFILE`, 
# 3. install pyenv, 
# 4. finally run `. $PROFILE` once more after install.

# -------------------------------------------------------------------------------------------------------------------------

Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1"; # . $PROFILE;

# -------------------------------------------------------------------------------------------------------------------------

$pyvers = @(
    "3.12.1",
    "3.11.6",
    "3.10.6",
    "3.6.8",
    "2.7.18"
)

if (!($NoPyverInstall)) {
    foreach ($v in $pyvers) {
        pyenv install $v
    }
    Write-Host "setting global python to 3.12.1..."
    "pyenv global 3.12.1" | Invoke-Expression
    Write-Host " "
}

# -- ms office & [redacted] --
$OfficeUri="https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365ProPlusRetail&platform=x64&language=en-us&version=O16GA"

# if (!($NoOfficeInstall)) {
#    Set-Location $env:USERPROFILE\Desktop; Invoke-WebRequest -Uri $OfficeUri -MaximumRedirection 20 -OutFile "OfficeSetup.exe"; .\OfficeSetup.exe;
    
    # will have to manually do keypresses for now but im sure this can be automated
#     (Invoke-RestMethod https://massgrave.dev/get | Invoke-Expression) # 2 -> 1. 
# }

# -- choco & packages --
If (!(Test-Path $chocoPath)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')); 
} 
# this actually is kind of a stupid idea lol
# ------------------------------------
# else {
#     Write-Host "--------------------------------------------------------------------------------------------------"
#     Write-Host "[!] WARN: Chocolatey path found - assuming invalid installing and removing from machine. " -ForegroundColor Red
#     Write-Host "[!] WARN: Kill the session with `^C` in the next 3 seconds to cancel." -ForgroundColor Red
#     Write-Host "--------------------------------------------------------------------------------------------------`n"
#     Start-Sleep 1; Write-Host "3..."; Start-Sleep 1; Write-Host "2..."; Start-Sleep 1; Write-Host "1..."; Start-Sleep 1;
#     Write-Host "[*] Removing directory..."
#     Remove-Item -Recurse $chocoPath;
#     Write-Host "[*] Directory erased. Moving to clean-install choco:"
#     Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')); 
# }

$binaries = @(
    "chromium",
    "systeminformer-nightlybuilds",
    "microsoft-windows-terminal",
    "neovim",
    "neovide",
    "vscode",
    "ghidra",
    "radare2",
    "cutter",
    "ida-free",
    "7zip",
    "cyberchef",
    "git",
    "netcat",
    "sysinternals",
    "powershell",
    "powershell-core",
    "adobereader",
    "vcredist140",
    "dotnetfx",
    "dnspyex",
    "ilspy",
    "upx",
    "ollydbg",
    "x64dbg.portable",
    "pestudio",
    "osquery",
    "sleuthkit",
    "volatility3",
    "floss",
    "yara",
    "capa",
    "checksum"
    )

Foreach ($bin in $binaries) {
    Invoke-Expression "choco install $bin -y"
} 

# -- manual downloads (will have to be installed by hand for now) --
$SleuthkitUri="https://github.com/sleuthkit/sleuthkit/releases/download/sleuthkit-4.12.1/sleuthkit-4.12.1-win32.zip"
Set-Location $env:USERPROFILE\Desktop; Invoke-WebRequest -Uri $SleuthkitUri -MaximumRedirection 20 -OutFile "sleuthkit.zip"; Invoke-Expression "7z x .\sleuthkit.zip"
$AutopsyUri="https://github.com/sleuthkit/autopsy/releases/download/autopsy-4.21.0/autopsy-4.21.0-64bit.msi" 
Set-Location $env:USERPROFILE\Desktop; Invoke-WebRequest -Uri $AutopsyUri -MaximumRedirection 20 -OutFile "Autopsy-4.21.0-64bit.msi"; ".\Autopsy-4.21.0-64bit.msi"
$OLEDumpUri="https://didierstevens.com/files/software/oledump_V0_0_75.zip"
Set-Location $env:USERPROFILE\Desktop; Invoke-WebRequest -Uri $OLEDumpUri -MaximumRedirection 20 -OutFile "OLEDump.zip"; Invoke-Expression "7z x .\OLEDump.zip"

# very necessary
$ImgZipUri="https://storage.googleapis.com/plsuwu_pub/img.zip"
Invoke-WebRequest -Uri $ImgZipUri -MaximumRedirection 20 -OutFile "img.zip"; Invoke-Expression "7z x .\img.zip"
