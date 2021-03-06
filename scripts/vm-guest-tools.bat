if not exist "C:\Windows\Temp\7z920-x64.msi" (
    echo "If clause: downloading 7zip"  1> C:\Windows\Temp\error1.msg 2>&1 
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://www.7-zip.org/a/7z920-x64.msi', 'C:\Windows\Temp\7z920-x64.msi')" <NUL
)
msiexec /qb /i C:\Windows\Temp\7z920-x64.msi 1> C:\Windows\Temp\error9.msg 2>&1

if "%PACKER_BUILDER_TYPE%" equ "vmware-iso" goto :vmware
if "%PACKER_BUILDER_TYPE%" equ "virtualbox-iso" goto :virtualbox
if "%PACKER_BUILDER_TYPE%" equ "parallels-iso" goto :parallels
goto :done

:vmware

if exist "C:\Users\vagrant\windows.iso" (
    move /Y C:\Users\vagrant\windows.iso C:\Windows\Temp
)

if not exist "C:\Windows\Temp\windows.iso" (
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://softwareupdate.vmware.com/cds/vmw-desktop/ws/12.0.0/2985596/windows/packages/tools-windows.tar', 'C:\Windows\Temp\vmware-tools.tar')" <NUL
    cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\vmware-tools.tar -oC:\Windows\Temp"
    FOR /r "C:\Windows\Temp" %%a in (VMware-tools-windows-*.iso) DO REN "%%~a" "windows.iso"
    rd /S /Q "C:\Program Files (x86)\VMWare"
)

cmd /c ""C:\Program Files\7-Zip\7z.exe" x "C:\Windows\Temp\windows.iso" -oC:\Windows\Temp\VMWare"
cmd /c C:\Windows\Temp\VMWare\setup.exe /S /v"/qn REBOOT=R\"

goto :done

:virtualbox
echo "in virtualbox section"  1> C:\Windows\Temp\error2.msg 2>&1
:: There needs to be Oracle CA (Certificate Authority) certificates installed in order
:: to prevent user intervention popups which will undermine a silent installation.
cmd /c certutil -addstore -f "TrustedPublisher" A:\oracle-cert.cer 1> C:\Windows\Temp\error3.msg 2>&1

move /Y C:\Users\vagrant\VBoxGuestAdditions_4.3.34.iso C:\Windows\Temp 1> C:\Windows\Temp\error4.msg 2>&1
cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\VBoxGuestAdditions_4.3.34.iso -oC:\Windows\Temp\virtualbox" 1> C:\Windows\Temp\error5.msg 2>&1
cmd /c C:\Windows\Temp\virtualbox\VBoxWindowsAdditions.exe /S 1> C:\Windows\Temp\error6.msg 2>&1
goto :done

:parallels
if exist "C:\Users\vagrant\prl-tools-win.iso" (
	move /Y C:\Users\vagrant\prl-tools-win.iso C:\Windows\Temp
	cmd /C "C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\prl-tools-win.iso -oC:\Windows\Temp\parallels
	cmd /C C:\Windows\Temp\parallels\PTAgent.exe /install_silent
	rd /S /Q "c:\Windows\Temp\parallels"
)

:done
msiexec /qb /x C:\Windows\Temp\7z920-x64.msi 1> C:\Windows\Temp\error7.msg 2>&1
echo "script finished"  1> C:\Windows\Temp\error8.msg 2>&1
