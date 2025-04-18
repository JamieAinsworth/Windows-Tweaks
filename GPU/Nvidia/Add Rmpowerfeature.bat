@echo off
echo Adding rmpowerfeature will increase your powerdraw a lot, check your temperatures after that.
pause
for /L %%i in (0,1,9) do (
    for /F "tokens=2* skip=2" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\000%%i" /v "ProviderName" 2^>nul') do (
	if /i "%%b"=="NVIDIA" (
		set G=000%%i
		)
	)
)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\%G%" /v "RmPowerFeature" /t REG_DWORD /d "1413829973" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\%G%" /v "RmPowerFeature2" /t REG_DWORD /d "89478485" /f
cls
echo Rmpowerfeature successfully added, reboot your pc.
pause