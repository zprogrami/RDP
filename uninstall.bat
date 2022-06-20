@echo off
if not exist "%~dp0RDPWInst.exe" goto :error
"%~dp0RDPWInst" -u
schtasks /delete /f /tn "RDP Auto Update"
del rdpwrap_new.ini
del RDPWInst.exe
del RDPConf.exe
echo.
goto :anykey
:error
echo [-] Installer executable not found.
echo Please extract all files from the downloaded package or check your anti-virus.
:anykey
pause
del uninstall.bat