@echo off

:: Main Menu
echo Artifact-Sweeper
echo =====================================
echo Select the tool artifacts to clean:
echo 1. AnyDesk
echo 2. Atera
echo 3. Splashtop
echo 4. ConnectWise
echo 5. TeamViewer
echo 6. Ngrok
echo 7. Remote Utilities
echo 8. Supremo
echo 9. FileZilla
echo 10. Rclone
echo 11. TightVNC
echo 12. LogMeIn
echo 13. WinSCP
echo 14. Exit
set /p choice="Enter your choice: "

if "%choice%"=="1" call :clean_anydesk
if "%choice%"=="2" call :clean_atera
if "%choice%"=="3" call :clean_splashtop
if "%choice%"=="4" call :clean_connectwise
if "%choice%"=="5" call :clean_teamviewer
if "%choice%"=="6" call :clean_ngrok
if "%choice%"=="7" call :clean_remote_utilities
if "%choice%"=="8" call :clean_supremo
if "%choice%"=="9" call :clean_filezilla
if "%choice%"=="10" call :clean_rclone
if "%choice%"=="11" call :clean_tightvnc
if "%choice%"=="12" call :clean_logmein
if "%choice%"=="13" call :clean_winscp
if "%choice%"=="14" exit

goto :EOF

:: Function to confirm event viewer log removal
:confirm_event_log
echo Removing logs from Event Viewer might trigger security alerts.
set /p confirm="Do you want to continue? (y/n): "
if "%confirm%" NEQ "y" exit /b
exit /b

:: AnyDesk Module
:clean_anydesk
echo Cleaning AnyDesk artifacts...
rmdir /s /q "%ProgramFiles(x86)%\AnyDesk"
rmdir /s /q "%ProgramData%\AnyDesk"
rmdir /s /q "%APPDATA%\AnyDesk"
reg delete "HKLM\System\CurrentControlSet\Services\AnyDesk" /f
call :confirm_event_log
wevtutil cl System
echo AnyDesk cleaned.
goto :EOF

:: Atera Module
:clean_atera
echo Cleaning Atera artifacts...
rmdir /s /q "%ProgramFiles%\Atera Networks"
del /f "%windir%\Temp\AteraSetupLog.txt"
del /f "%ProgramFiles%\ATERA Networks\AteraAgent\Packages\AgentPackageRunCommandInteractive\log.txt"
reg delete "HKLM\Software\Atera Networks" /f
reg delete "HKLM\System\CurrentControlSet\Services\AteraAgent" /f
call :confirm_event_log
wevtutil cl Application
echo Atera cleaned.
goto :EOF

:: Splashtop Module
:clean_splashtop
echo Cleaning Splashtop artifacts...
rmdir /s /q "%ProgramFiles(x86)%\Splashtop"
rmdir /s /q "%ProgramData%\Splashtop"
reg delete "HKLM\SOFTWARE\WOW6432Node\Splashtop Inc." /f
reg delete "HKLM\System\CurrentControlSet\Services\SplashtopRemoteService" /f
call :confirm_event_log
wevtutil cl Application
echo Splashtop cleaned.
goto :EOF

:: ConnectWise Module
:clean_connectwise
echo Cleaning ConnectWise artifacts...
for /d %%G in ("%ProgramFiles(x86)%\ScreenConnect Client*") do rmdir /s /q "%%G"
del /f /q "%SystemRoot%\TEMP\ScreenConnect\*\*.ps1"
reg delete "HKLM\System\CurrentControlSet\Services\ScreenConnect Client*" /f
call :confirm_event_log
wevtutil cl Application
echo ConnectWise cleaned.
goto :EOF

:: TeamViewer Module
:clean_teamviewer
echo Cleaning TeamViewer artifacts...
rmdir /s /q "%ProgramFiles(x86)%\TeamViewer"
rmdir /s /q "%ProgramFiles%\TeamViewer"
reg delete "HKLM\SOFTWARE\WOW6432Node\TeamViewer" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\TeamViewer" /f
call :confirm_event_log
wevtutil cl Application
echo TeamViewer cleaned.
goto :EOF

:: Ngrok Module
:clean_ngrok
echo Cleaning Ngrok artifacts...
rmdir /s /q "%LOCALAPPDATA%\ngrok"
del /f "%LOCALAPPDATA%\ngrok\ngrok.yml"
echo Ngrok cleaned.
goto :EOF

:: Remote Utilities Module
:clean_remote_utilities
echo Cleaning Remote Utilities artifacts...
rmdir /s /q "%ProgramFiles(x86)%\Remote Utilities - Host"
rmdir /s /q "%APPDATA%\Remote Utilities Agent"
del /f /q "%APPDATA%\Remote Utilities Agent\Logs\rut_log_*.html"
del /f /q "%ProgramFiles(x86)%\Remote Utilities - Host\Logs\rut_log_*.html"
reg delete "HKCU\Software\Usoris\Remote Utilities" /f
reg delete "HKLM\Software\Usoris\Remote Utilities" /f
reg delete "HKLM\System\CurrentControlSet\Services\RManService" /f
echo Remote Utilities cleaned.
goto :EOF

:: Supremo Module
:clean_supremo
echo Cleaning Supremo artifacts...
rmdir /s /q "%ProgramFiles(x86)%\Supremo"
rmdir /s /q "%ProgramData%\SupremoRemoteDesktop"
del /f /q "%ProgramData%\SupremoRemoteDesktop\Log\Supremo.*.log"
reg delete "HKLM\System\CurrentControlSet\Services\SupremoService" /f
echo Supremo cleaned.
goto :EOF

:: WinSCP Module
:clean_winscp
echo Cleaning WinSCP artifacts...
rmdir /s /q "%ProgramFiles(x86)%\WinSCP"
rmdir /s /q "%USERPROFILE%\AppData\Local\Programs\WinSCP"
del /f "%USERPROFILE%\AppData\Roaming\WinSCP.ini"
reg delete "HKCU\Software\Martin Prikryl\WinSCP 2" /f
reg delete "HKLM\SOFTWARE\WOW6432Node\Martin Prikryl\WinSCP 2" /f
reg delete "HKCR\winscp-*" /f
call :confirm_event_log
wevtutil cl Application
echo WinSCP cleaned.
goto :EOF
