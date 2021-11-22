@echo off
if not exist "%~dp0RDPWInst.exe" goto :error
"%~dp0RDPWInst" -i -o
xcopy "%~dp0helper" "C:\Program Files\RDP Wrapper\helper"  /s /I /y
xcopy "%~dp0*" "C:\Program Files\RDP Wrapper\"  /s /I /y
echo ______________________________________________________________
echo.
echo You can check RDP functionality with RDPCheck program.
echo Also you can configure advanced settings with RDPConf program.
echo.
goto :anykey
:error
echo [-] Installer executable not found.
echo Please extract all files from the downloaded package or check your anti-virus.
:anykey
pause
cmd.exe /C start "" "C:\Program Files\RDP Wrapper\RDPConf.exe"
