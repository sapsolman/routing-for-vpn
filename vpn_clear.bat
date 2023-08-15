@echo off
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
cls

route print -4
netsh interface ip show interfaces

set /p VPNIFnum="Enter VPN interface ID (number) to apply script: "
netsh interface ip show config %VPNIFnum%

for /F "skip=1 tokens=2" %%a in ('nslookup mskxdag.region.vtb.ru ^| findstr "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*"') do set ipadr1=%%a
for /F "tokens=1,2,3 delims=." %%a in ("%ipadr1%") do set ipadr1=%%a.%%b.%%c.0
for /F "skip=1 tokens=2" %%a in ('nslookup view-urm.msk.vtb24.ru ^| findstr "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*"') do set ipadr2=%%a
for /F "tokens=1,2,3 delims=." %%a in ("%ipadr2%") do set ipadr2=%%a.%%b.%%c.0

echo Delete routes
for /F "tokens=1,4" %%a in ('route print -4 ^| findstr "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*"') do call :delroute %%a %%b

echo Add route to mskxdag.region.vtb.ru (%ipadr1%)
route add %ipadr1% MASK 255.255.255.0 0.0.0.0 METRIC 1 IF %VPNIFnum%
echo Add route to view-urm.msk.vtb24.ru (%ipadr2%)
route add %ipadr2% MASK 255.255.255.0 0.0.0.0 METRIC 1 IF %VPNIFnum%

pause
exit /B

:delroute
    if [%2] EQU [] exit /B
    set gate=%2
    set dest=%1
    if "%gate:~0,3%" EQU "10." if "%dest:~0,3%" NEQ "10." route delete %dest% IF %VPNIFnum%
    exit /B
