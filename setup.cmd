@echo off
setlocal

set __ScriptPath=%~dp0
set mytoolsPath=%__ScriptPath%mytools

for /f "usebackq tokens=2,*" %%A in (`reg query HKCU\Environment /v PATH`) do set my_user_path=%%B
setx PATH "%mytoolsPath%;%my_user_path%"
call :EchoGreen Done

endlocal & exit /b 0

:EchoGreen
    set text=%*
    Powershell.exe write-host -foregroundcolor Green %text%
    if not "%errorlevel%"=="0" (
      echo %text%
    )

    goto :eof