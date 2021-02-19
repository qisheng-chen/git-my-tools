@echo off
setlocal
for /f "delims=" %%i in ('git remote get-url origin') do (
    call :EchoInline "Opening "
    call :EchoGreen %%i
    start %%i
)

endlocal & exit /b 0

:EchoInline
  set text=%*
  echo | set /p dummyName=%text%
  goto :eof

:EchoRed
    set text=%*
    Powershell.exe write-host -foregroundcolor Red %text%
    if not "%errorlevel%"=="0" (
      echo [Error] %text%
    )

    goto :eof

:EchoGreen
    set text=%*
    Powershell.exe write-host -foregroundcolor Green %text%
    if not "%errorlevel%"=="0" (
      echo %text%
    )

    goto :eof

:EchoBlue
    set text=%*
    Powershell.exe write-host -foregroundcolor Blue %text%
    if not "%errorlevel%"=="0" (
      echo %text%
    )

    goto :eof

:EchoCyan
    set text=%*
    Powershell.exe write-host -foregroundcolor Cyan %text%
    if not "%errorlevel%"=="0" (
      echo %text%
    )

    goto :eof