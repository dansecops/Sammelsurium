:: Information gathering tool for windows
@ECHO OFF

REG ADD "HKCU\Software\Sysinternals\AccessChk" /v EulaAccepted /t REG_DWORD /d 1 /f > NUL 2>&1
REG ADD "HKCU\Software\Sysinternals\ListDLLs" /v EulaAccepted /t REG_DWORD /d 1 /f > NUL 2>&1
REG ADD "HKCU\Software\Sysinternals\PipeList" /v EulaAccepted /t REG_DWORD /d 1 /f > NUL 2>&1
REG ADD "HKCU\Software\Sysinternals\Plink" /v EulaAccepted /t REG_DWORD /d 1 /f > NUL 2>&1

echo System Information (use windows-exploit-suggester.py to check for local exploits):
echo.
systeminfo 2>NUL
echo.
echo ----------------------------------------------------------------------------
echo.
echo Environment variables:
echo.
set 2>NUL
echo.
echo %PATH% 2>NUL
echo.
echo ----------------------------------------------------------------------------
echo.
echo Information about users:
echo.
hostname 2>NUL
echo.
echo %USERNAME% 2>NUL
echo.
net user %USERNAME% 2>NUL
echo.
net user %USERNAME% /domain 2>NUL
echo.
net users 2>NUL
echo.
net localgroup 2>NUL
echo.
net localgroup Administrators 2>NUL
echo.
echo ----------------------------------------------------------------------------
echo.
echo Network information:
echo.
ipconfig /all 2>NUL
echo.
route print 2>NUL
echo.
arp -A 2>NUL
echo.
netstat -ano 2>NUL
echo.
echo ----------------------------------------------------------------------------
echo.
echo Running processes:
echo.
tasklist /SVC 2>NUL
echo.
echo ----------------------------------------------------------------------------
echo.
echo Installed software:
echo.
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall 2>NUL
dir "%PROGRAMFILES%" 2>NUL
dir "%ProgramFiles(x86)%" 2>NUL
echo.
echo ----------------------------------------------------------------------------
echo.
echo Startup programs:
echo.
dir "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup" 2>NUL
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run 2>NUL
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce 2>NUL
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run 2>NUL
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce 2>NUL
echo.
echo ----------------------------------------------------------------------------
echo.
echo Temp files:
echo.
dir "%TEMP%" 2>NUL
echo.
echo ----------------------------------------------------------------------------
echo.
echo Startup services:
echo.
net start 2>NUL
echo.
echo ----------------------------------------------------------------------------
echo.
echo Files that may contain Administrator password - you know what to do with this one:
type %SystemDrive%\sysprep.inf 2>NUL
type %SystemDrive%\sysprep\sysprep.xml 2>NUL
type "%WINDIR%\Panther\Unattend\Unattended.xml" 2>NUL
type "%WINDIR%\Panther\Unattended.xml" 2>NUL
findstr /S cpassword \\127.0.0.1\sysvol\*.xml
echo.
echo ----------------------------------------------------------------------------
echo.
echo Checking AlwaysInstallElevated - install *.msi files as NT AUTHORITY\SYSTEM
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated 2>NUL
reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated 2>NUL
echo.
echo ----------------------------------------------------------------------------
echo.
echo "Services"
wmic service get name,displayname,pathname,startmode |findstr /i "Auto" |findstr /i /v "C:\Windows\\" |findstr /i /v """
echo.
wmic service get name,pathname | findstr /i /v "c:\\windows\\" 
echo.
wmic service get pathname,startname | findstr /i /v "c:\\windows\\" 
echo.
echo ----------------------------------------------------------------------------
echo.
echo Program Listening on Port
FOR /F "usebackq tokens=5 delims= " %%i IN (`netstat -ano`) DO @tasklist /fi "pid eq %%i" | find "%%i"
echo.