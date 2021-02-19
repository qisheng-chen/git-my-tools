@echo off
setlocal

dir /b %~dp0

REM start %~dp0
endlocal & exit /b 0

:EchoCmdGreen
    set text=%*
    Powershell.exe write-host -NoNewline -foregroundcolor Green %text%
    if not "%errorlevel%"=="0" (
      echo %text%
    )

    goto :eof

