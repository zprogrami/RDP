<!-- : Begin batch script
@echo off
setLocal EnableExtensions
setlocal EnableDelayedExpansion
cd\
c:
cd\
cd C:\PROGRAM FILES\RDP WRAPPER"

REM -------------------------------------------------------------------
REM ------OVU DATOTEKU POTREBNO JE STAVITI U C:\PROGRAM FILES\RDP WRAPPER I POKRENUTI AS ADMIN----------
REM                        gg_autoupdate.bat
REM
REM Automatic RDP Wrapper installer and updater // zzzzz (11.05.2022, 16:15)
REM -------------------------------------------------------------------
REM Options:
REM   -log        = redirect display output to the file autoupdate.log
REM   -taskadd    = add autorun of autoupdate.bat on startup in schedule task
REM   -taskremove = remove autorun of autoupdate.bat on startup in schedule task
REM
REM Info:
REM   The autoupdater first use and check the official rdpwrap.ini.
REM   If a new termsrv.dll is not supported in the offical rdpwrap.ini,
REM   autoupdater first tries the asmtron rdpwrap.ini (disassembled and
REM   tested by asmtron). The autoupdater will also use rdpwrap.ini files
REM   of other contributors like the one of "saurav-biswas".
REM   Extra rdpwrap.ini sources can also be defined...
REM
REM { Special thak to binarymaster, saurav-biswas and all other contributors }

REM -----------------------------------------
REM Location of new/updated rdpwrap.ini files
REM -----------------------------------------
set rdpwrap_ini_update_github_1="http://smartpos.fiskal.hr//SMARTINSTALL/SKRIPTE/rdpwrap.ini"
set rdpwrap_ini_update_github_2="http://smartpos.fiskal.hr//SMARTINSTALL/SKRIPTE/rdpwrap.ini"
set rdpwrap_ini_update_github_3="http://smartpos.fiskal.hr//SMARTINSTALL/SKRIPTE/RDPWInst.exe"
set rdpwrap_ini_update_github_4="http://smartpos.fiskal.hr//SMARTINSTALL/SKRIPTE/RDPConf.exe"
set rdpwrap_ini_update_github_5="http://smartpos.fiskal.hr//SMARTINSTALL/SKRIPTE/uninstall.bat"
set rdpwrap_ini_update_github_6="http://smartpos.fiskal.hr//SMARTINSTALL/SKRIPTE/rdpwrap.dll"
set rdpwrap_ini_update_github_7="http://smartpos.fiskal.hr//SMARTINSTALL/SKRIPTE/GG_Autoupdate.bat"

REM set rdpwrap_ini_update_github_3="https://raw.githubusercontent.com/....Extra.3...."
REM set rdpwrap_ini_update_github_4="https://raw.githubusercontent.com/....Extra.4...."

set autoupdate_bat="%~dp0GG_Autoupdate.bat"
set autoupdate_bat1="%~dp0GG_Autoupdate.bat"
set autoupdate_log="%~dp0autoupdate.log"
set Fake_File="%~dp0FakeFile.txt"
set RDPWInst_exe="%~dp0RDPWInst.exe"
set RDPConf_exe="%~dp0RDPConf.exe"
set uninstall_bat="%~dp0uninstall.bat"
set rdpwrap_dll="%~dp0rdpwrap.dll"
set RDPWInst_exe_new="%~dp0RDPWInst.exe"
set rdpwrap_ini="%~dp0rdpwrap.ini"
set rdpwrap_ini_check=%rdpwrap_ini%
set rdpwrap_new_ini="%~dp0rdpwrap_new.ini"
set github_location=1

set rdpwrap_exe1_url=!rdpwrap_ini_update_github_3!
set rdpwrap_exe2_url=!rdpwrap_ini_update_github_4!
set rdpwrap_exe3_url=!rdpwrap_ini_update_github_5!
set rdpwrap_exe4_url=!rdpwrap_ini_update_github_6!
set rdpwrap_exe5_url=!rdpwrap_ini_update_github_7!
set naziv_kompa=hostname
set logirani_user=%USERNAME%

cacls "c:\Program Files\RDP Wrapper" /t /e /g Everyone:f

attrib -R %rdpwrap_ini%
"%~dp0RDPWInst" -u

REM ren GG_Autoupdate.bat GG_Autoupdate.old

REM schtasks /create /f /sc ONSTART /tn "RDP Auto Update" /tr "C:\Program Files\RDP Wrapper\GG_Autoupdate.bat" /np /delay 001:00 /rl HIGHEST
REM ------------------------------
REM 4) SKINI NOVI AUTOUPDATE exists
REM ------------------------------
if exist %Fake_File% (
    echo [+] Found file: %autoupdate_bat1%.

) else (
    echo [-] File NOT found: %autoupdate_bat1%^^!
   echo [*] Download latest version of autoupdate_bat1 from GG...
echo     -^> %rdpwrap_exe5_url%
for /f "tokens=* usebackq" %%a in (
    `cscript //nologo "%~f0?.wsf" //job:fileDownload %rdpwrap_exe5_url% %autoupdate_bat1%`
) do (
   set "download_status=%%99"
)
)
REM if not exist %autoupdate_bat%. ren GG_Autoupdate.old GG_Autoupdate.bat

REM ------------------------------
REM 4) check if RDPWInst.exe exists
REM ------------------------------
if exist %Fake_File% (
    echo [+] Found file: %RDPWInst_exe%.

) else (
    echo [-] File NOT found: %RDPWInst_exe%^^!
   echo [*] Download latest version of rdpwinst.EXE from GG...
echo     -^> %rdpwrap_exe1_url%
for /f "tokens=* usebackq" %%a in (
    `cscript //nologo "%~f0?.wsf" //job:fileDownload %rdpwrap_exe1_url% %RDPWInst_exe%`
) do (
   set "download_status=%%99"
)
)


REM ------------------------------
REM 4) check if RDPConf.exe exists
REM ------------------------------
if exist %Fake_File% (
    echo [+] Found file: %RDPConf_exe%.

) else (
    echo [-] File NOT found: %RDPConf_exe%^^!
   echo [*] Download latest version of RDPCheck_exe from GG...
echo     -^> %rdpwrap_exe2_url%
for /f "tokens=* usebackq" %%a in (
    `cscript //nologo "%~f0?.wsf" //job:fileDownload %rdpwrap_exe2_url% %RDPConf_exe%`
) do (
    set "download_status=%%99"
)
)

REM ------------------------------
REM 4) check if uninstall.bat exists
REM ------------------------------
if exist %Fake_File% (
    echo [+] Found file: %uninstall_bat%.

) else (
    echo [-] File NOT found: %uninstall_bat%^^!
   echo [*] Download latest version of uninstall_bat from GG...
echo     -^> %rdpwrap_exe3_url%
for /f "tokens=* usebackq" %%a in (
    `cscript //nologo "%~f0?.wsf" //job:fileDownload %rdpwrap_exe3_url% %uninstall_bat%`
) do (
   set "download_status=%%99"
)
)
REM ------------------------------
REM 4) check if rdpwrap_dll exists
REM ------------------------------
if exist %Fake_File% (
    echo [+] Found file: %rdpwrap_dll%.

) else (
    echo [-] File NOT found: %rdpwrap_dll%^^!
   echo [*] Download latest version of rdpwrap_dll from GG...
echo     -^> %rdpwrap_exe4_url%
for /f "tokens=* usebackq" %%a in (
    `cscript //nologo "%~f0?.wsf" //job:fileDownload %rdpwrap_exe4_url% %rdpwrap_dll%`
) do (
   set "download_status=%%99"
)
)

echo ___________________________________________
echo Automatic RDP Wrapper installer and updater
echo.
echo ^<check if the RDP Wrapper is up-to-date and working^>
echo.
REM check if admin
fsutil dirty query %systemdrive% >nul
if not %errorlevel% == 0 goto :not_admin
REM check for arguments
if /i "%~1"=="-log" (
    echo %autoupdate_bat% output from %date% at %time% > %autoupdate_log%
    call %autoupdate_bat% >> %autoupdate_log%
    goto :finish
)
if /i "%~1"=="-taskadd" (
    echo [+] add autorun of %autoupdate_bat% on startup in the schedule task.
    schtasks /create /f /sc ONSTART /tn "RDP Auto Update" /tr "C:\Program Files\RDP Wrapper\GG_Autoupdate.bat" /np /delay 0001:00 /rl HIGHEST
    goto :finish
)
if /i "%~1"=="-taskremove" (
    echo [-] remove autorun of %autoupdate_bat% on startup in the schedule task^^!
    schtasks /delete /f /tn "RDP Auto Update"
    goto :finish
)
if /i not "%~1"=="" (
    echo [x] Unknown argument specified: "%~1"
    echo [*] Supported argments/options are:
    echo     -log         =  redirect display output to the file autoupdate.log
    echo     -taskadd     =  add autorun of autoupdate.bat on startup in the schedule task
    echo     -taskremove  =  remove autorun of autoupdate.bat on startup in the schedule task
    goto :finish
)
REM check if file "RDPWInst.exe" exist
if not exist %RDPWInst_exe% goto :error_install
goto :start_check

:not_admin
echo [-] This script must be run as administrator to work properly^^!
echo     ^<Please use 'right click' on this batch file and select "Run As Administrator"^>
echo.
goto :finish
:error_install
echo [-] RDP Wrapper installer executable (RDPWInst.exe) not found^^!
echo Please extract all files from the downloaded RDP Wrapper package or check your Antivirus.
echo.
goto :finish

:start_check
set rdpwrap_installed="0"
REM ----------------------------------
REM 1) check if TermService is running
REM ----------------------------------
sc queryex "TermService"|find "STATE"|find /v "RUNNING" >nul&&(
    echo [-] TermService NOT running^^!
    call :install
)||(
    echo [+] TermService running.
)
REM ------------------------------------------
REM 2) check if listener session rdp-tcp exist
REM ------------------------------------------
set rdp_tcp_session=""
for /f "tokens=1-2* usebackq" %%a in (
    `query session rdp-tcp`
) do (
    set rdp_tcp_session=%%a
    set rdp_tcp_session_id=%%b
)
if %rdp_tcp_session%=="" (
    echo [-] Listener session rdp-tcp NOT found^^!
    call :install
) else (
    echo [+] Found listener session: %rdp_tcp_session% ^(ID: %rdp_tcp_session_id%^).
)
REM -----------------------------------------
REM 3) check if rdpwrap.dll exist in registry
REM -----------------------------------------
reg query "HKLM\SYSTEM\CurrentControlSet\Services\TermService\Parameters" /f "rdpwrap.dll" >nul&&(
    echo [+] Found windows registry entry for "rdpwrap.dll".
)||(
    echo [-] NOT found windows registry entry for "rdpwrap.dll"^^!
    if %rdpwrap_installed%=="0" (
        call :install
    )
)
REM ------------------------------
REM 4) check if rdpwrap.ini exists
REM ------------------------------
if exist %rdpwrap_ini% (
    echo [+] Found file: %rdpwrap_ini%.

) else (
    echo [-] File NOT found: %rdpwrap_ini%^^!
    if %rdpwrap_installed%=="0" (
        call :install
    )
)


REM ---------------------------------------------------------------
REM 5) get file version of %windir%\System32\termsrv.dll
REM ---------------------------------------------------------------
for /f "tokens=* usebackq" %%a in (
    `cscript //nologo "%~f0?.wsf" //job:fileVersion "%windir%\System32\termsrv.dll"`
) do (
    set termsrv_dll_ver=%%a
)
if "%termsrv_dll_ver%"=="" (
    echo [x] Error on getting the file version of "%windir%\System32\termsrv.dll"^^!
    goto :finish
) else (
    echo [+] Installed "termsrv.dll" version: %termsrv_dll_ver%.
)
REM ----------------------------------------------------------------------------------------
REM 6) check if installed fileversion is different to the last saved fileversion in registry
REM ----------------------------------------------------------------------------------------
echo [*] Read last "termsrv.dll" version from the windows registry...
for /f "tokens=2* usebackq" %%a in (
    `reg query "HKEY_LOCAL_MACHINE\SOFTWARE\RDP-Wrapper\Autoupdate" /v "termsrv.dll" 2^>nul`
) do (
    set last_termsrv_dll_ver=%%b
)
if "%last_termsrv_dll_ver%"=="%termsrv_dll_ver%" (
    echo [+] Current "termsrv.dll v.%termsrv_dll_ver%" same as last "termsrv.dll v.%last_termsrv_dll_ver%".
) else (
    echo [-] Current "termsrv.dll v.%termsrv_dll_ver%" different from last "termsrv.dll v.%last_termsrv_dll_ver%"^^!
    echo [*] Update current "termsrv.dll" version to the windows registry...
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\RDP-Wrapper\Autoupdate" /v "termsrv.dll" /t REG_SZ /d "%termsrv_dll_ver%" /f
    if %rdpwrap_installed%=="0" (
        call :install
    )
)
REM ---------------------------------------------------------------
REM 7) check if installed termsrv.dll version exists in rdpwrap.ini
REM ---------------------------------------------------------------
:check_update
if exist %rdpwrap_ini_check% (
    echo [*] Start searching [%termsrv_dll_ver%] version entry in file %rdpwrap_ini_check%...
    findstr /c:"[%termsrv_dll_ver%]" %rdpwrap_ini_check% >nul&&(
        echo [+] Found "termsrv.dll" version entry [%termsrv_dll_ver%] in file %rdpwrap_ini_check%.
        echo [*] RDP Wrapper seems to be up-to-date and working...
    )||(
        echo [-] NOT found "termsrv.dll" version entry [%termsrv_dll_ver%] in file %rdpwrap_ini_check%^^!
        if not "!rdpwrap_ini_update_github_%github_location%!" == "" (
            set rdpwrap_ini_url=!rdpwrap_ini_update_github_%github_location%!
            call :update
            goto :check_update
        )
        goto :finish
    )
) else (
    echo [-] File NOT found: %rdpwrap_ini_check%.
    echo [*] Give up - Please check if Antivirus/Firewall blocks the file %rdpwrap_ini_check%^^!
    goto :finish
)
goto :finish

REM -----------------------------------------------------
REM Install RDP Wrapper (exactly uninstall and reinstall)
REM -----------------------------------------------------
:install
echo.
echo [*] Uninstall and reinstall RDP Wrapper...
echo.
set rdpwrap_installed="1"
%RDPWInst_exe% -u
%RDPWInst_exe% -i -o
schtasks /create /f /sc ONSTART /tn "RDP Auto Update" /tr "C:\Program Files\RDP Wrapper\GG_Autoupdate.bat" /np /delay 0001:00 /rl HIGHEST
call :setNLA
goto :eof

REM -------------------
REM Restart RDP Wrapper
REM -------------------
:restart
if %rdpwrap_installed%=="0" (
    call :install
)
REM NOTE - normal copy of the file "rdpwrap_new.ini" to "rdpwrap.ini" will not work (file locked)
REM        we need to stream the data from "rdpwrap_new.ini" to "rdpwrap.ini"
if exist %rdpwrap_new_ini% (
    echo [*] Start streaming %rdpwrap_new_ini% to %rdpwrap_ini%...
    (
        for /f "usebackq delims=" %%a in (
            `findstr /n "^" %rdpwrap_new_ini%`
        ) do (
            if "!%%a!"=="" (
                echo.
            ) else (
                echo !%%a!
            )
        )
    )>%rdpwrap_ini%
    echo [+] Update of %rdpwrap_ini% finished successfully.
)
echo.
echo [*] Restart RDP Wrapper...
echo.
%RDPWInst_exe% -r
call :setNLA
goto :eof

REM --------------------------------------------------------------------
REM Download up-to-date (alternative) version of rdpwrap.ini from GitHub
REM --------------------------------------------------------------------
:update
set /a github_location=github_location+1
echo.
echo [*] Download latest version of rdpwrap.ini from GitHub...
echo     -^> %rdpwrap_ini_url%
for /f "tokens=* usebackq" %%a in (
    `cscript //nologo "%~f0?.wsf" //job:fileDownload %rdpwrap_ini_url% %rdpwrap_new_ini%`
) do (
    set "download_status=%%a"
)
if "%download_status%"=="-1" (
    echo [+] Successfully download from GitHhub latest version to %rdpwrap_new_ini%.
    set rdpwrap_ini_check=%rdpwrap_new_ini%
    call :restart
) else (
    echo [-] FAILED to download from GitHub latest version to %rdpwrap_new_ini%^^!
    echo [*] Please check you internet connection/firewall and try again^^!
)
goto :eof

REM --------------------------------
REM Set Network Level Authentication
REM --------------------------------
:setNLA
echo [*] Set Network Level Authentication in the windows registry...
reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v SecurityLayer /t reg_dword /d 0x1 /f
reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v MinEncryptionLevel /t reg_dword /d 0x2 /f
goto :eof

:finish
echo.
exit /b


--- Begin wsf script --- fileVersion/fileDownload --->
<package>
  <job id="fileVersion"><script language="VBScript">
    set args = WScript.Arguments
    Set fso = CreateObject("Scripting.FileSystemObject")
    WScript.Echo fso.GetFileVersion(args(0))
    Wscript.Quit
  </script></job>
  <job id="fileDownload"><script language="VBScript">
    set args = WScript.Arguments
    WScript.Echo SaveWebBinary(args(0), args(1))
    Wscript.Quit
    Function SaveWebBinary(strUrl, strFile) 'As Boolean
        Const adTypeBinary = 1
        Const adSaveCreateOverWrite = 2
        Const ForWriting = 2
        Dim web, varByteArray, strData, strBuffer, lngCounter, ado
        On Error Resume Next
        'Download the file with any available object
        Err.Clear
        Set web = Nothing
        Set web = CreateObject("WinHttp.WinHttpRequest.5.1")
        If web Is Nothing Then Set web = CreateObject("WinHttp.WinHttpRequest")
        If web Is Nothing Then Set web = CreateObject("MSXML2.ServerXMLHTTP")
        If web Is Nothing Then Set web = CreateObject("Microsoft.XMLHTTP")
        web.Open "GET", strURL, False
        web.Send
        If Err.Number <> 0 Then
            SaveWebBinary = False
            Set web = Nothing
            Exit Function
        End If
        If web.Status <> "200" Then
            SaveWebBinary = False
            Set web = Nothing
            Exit Function
        End If
        varByteArray = web.ResponseBody
        Set web = Nothing
        'Now save the file with any available method
        On Error Resume Next
        Set ado = Nothing
        Set ado = CreateObject("ADODB.Stream")
        If ado Is Nothing Then
            Set fs = CreateObject("Scripting.FileSystemObject")
            Set ts = fs.OpenTextFile(strFile, ForWriting, True)
            strData = ""
            strBuffer = ""
            For lngCounter = 0 to UBound(varByteArray)
                ts.Write Chr(255 And Ascb(Midb(varByteArray,lngCounter + 1, 1)))
            Next
            ts.Close
        Else
            ado.Type = adTypeBinary
            ado.Open
            ado.Write varByteArray
            ado.SaveToFile strFile, adSaveCreateOverWrite
            ado.Close
        End If
        SaveWebBinary = True
    End Function
  </script></job>
</package>
pause
