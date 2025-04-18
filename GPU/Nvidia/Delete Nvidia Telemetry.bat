@echo off
rmdir /s /q "%systemdrive%\Windows\System32\drivers\NVIDIA Corporation" >nul 2>&1
cd /d "%systemdrive%\Windows\System32\DriverStore\FileRepository\" >nul 2>&1
dir NvTelemetry64.dll /a /b /s >nul 2>&1
del NvTelemetry64.dll /a /s >nul 2>&1
cd /d "%systemdrive%\Windows\System32\DriverStore\FileRepository\nv_dispig.inf_amd64_20ea7d0c917cde22" >nul 2>&1
del NvTelemetry64.dll /a /s >nul 2>&1
rd /s /q "%systemdrive%\Program Files\NVIDIA Corporation\Display.NvContainer\plugins\LocalSystem\DisplayDriverRAS" >nul 2>&1
rd /s /q "%systemdrive%\Program Files\NVIDIA Corporation\DisplayDriverRAS" >nul 2>&1
rd /s /q "%systemdrive%\ProgramData\NVIDIA Corporation\DisplayDriverRAS" >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f  >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup" /v "SendTelemetryData" /t REG_DWORD /d 0 /f >nul 2>&1
for %%i in (NvTmMon NvTmRep) do (for /f "tokens=1 delims=," %%a in ('schtasks /query /fo csv ^| findstr /v "TaskName" ^| findstr "%%~i" ^| findstr /v "Microsoft\\Windows"') do (schtasks /change /tn %%a /disable))
sc config NvTelemetryContainer start=disabled >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup\SendTelemetryData" /ve /t REG_DWORD /d "0" /f >nul 2>&1
cls
echo Telemetry succesfully deleted
pause