@echo off
cls
echo Cleaning Useless Device Data...
chcp 437 > nul
powershell -Command "$Devices = Get-PnpDevice | ? Status -eq 'Unknown'; foreach ($Device in $Devices) { pnputil /remove-device $Device.InstanceId }"
chcp 65001 > nul
timeout /t 1 /nobreak > NUL
echo Limpando arquivos de log, arquivos temp e lixo do computador...

echo Limpando arquivos de log...
del /q /s C:\Windows\*.log
for /f "tokens=*" %%G in ('wevtutil.exe el') DO (wevtutil.exe cl "%%G")
echo Arquivos de log limpos.

echo Limpando arquivos temporarios...
del /q /s C:\Windows\Temp\*.*
del /q /s C:\Users\%USERNAME%\AppData\Temp
echo Arquivos temporários limpos.

echo Limpando arquivos da lixeira...
rd /s /q C:\$Recycle.bin
echo Arquivos da lixeira limpos.

echo Limpando arquivos temporarios da internet...
RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 8
echo Arquivos temporários da internet limpos.

echo Limpando arquivos temporarios do sistema...
RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 4351
echo Arquivos temporários do sistema limpos.

echo Limpeza concluida.
PAUSE