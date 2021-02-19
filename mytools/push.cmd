@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
set options=%*

REM make sure options has -u/--set-upstream

REM add leading/ending space before checking
if defined options (
  set "options= !options! "
) else (
  set "options= "
)

if /i "!options: -u =!"=="!options!" (
  if /i "!options: --set-upstream =!"=="!options!" (
     set "options=!options!--set-upstream "
  )
)

REM remove leading/ending space after checking
set options=!options:~1,-1!

REM run command
for /f %%i in ('git rev-parse --abbrev-ref HEAD') do (
	Call :EchoCyan "git push !options! origin %%i"
	git push !options! origin %%i
)

endlocal & exit /b 0

:EchoInline
  set text=%*
  echo | set /p dummyName=%text%
  goto :eof

:EchoRed
    set text=%*
    Powershell.exe write-host -foregroundcolor Red '%text%'
    if not "%errorlevel%"=="0" (
      echo [Error] %text%
    )

    goto :eof

:EchoGreen
    set text=%*
    Powershell.exe write-host -foregroundcolor Green '%text%'
    if not "%errorlevel%"=="0" (
      echo %text%
    )

    goto :eof

:EchoBlue
    set text=%*
    Powershell.exe write-host -foregroundcolor Blue '%text%'
    if not "%errorlevel%"=="0" (
      echo %text%
    )

    goto :eof

:EchoCyan
    set text=%*
    Powershell.exe write-host -foregroundcolor Cyan '%text%'
    if not "%errorlevel%"=="0" (
      echo %text%
    )

    goto :eof