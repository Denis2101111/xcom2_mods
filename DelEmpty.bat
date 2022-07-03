goto start
:REFcmd
for /d %%i in ("%~1\*") do (call :REFcmd "%%i" & rd /q "%%i")
exit /b
:start
call :REFcmd "L:\Games\XCOM 2 Files"
