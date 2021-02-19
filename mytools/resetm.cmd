@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
set masterbranch=%~1

REM if branch sepcficied in parameter, use it, otherwise check master and then main
if not "!masterbranch!"=="" (
   git rev-parse --verify !masterbranch! > nul 2> nul
   if not "!errorlevel!"=="0" (
	 call :EchoRed branch does not exist: !masterbranch!, try again after git fetch if the branch exists in remote
   )
) else (
	set masterbranch=master
	git rev-parse --verify !masterbranch! > nul 2> nul
	if not "!errorlevel!"=="0" (
	   set masterbranch=main
	   git rev-parse --verify !masterbranch! > nul 2> nul
	   if not "!errorlevel!"=="0" (
		 call :EchoRed master/main branch does not exist, specify the main branch name and try again: resetm [branch]
	   )
	)
)

for /f %%i in ('git rev-parse --abbrev-ref HEAD') do (
    if not %%i==!masterbranch! (
      Call :EchoCyan git checkout !masterbranch!
      git checkout !masterbranch!      
      if not !errorlevel!==0 (
          call :EchoRed Failed to checkout !masterbranch! branch
          endlocal & exit /b 1
      )
    )
)

Call :EchoCyan git fetch
git fetch
Call :EchoCyan git reset origin/!masterbranch! --hard 
git reset origin/!masterbranch! --hard 

endlocal & exit /b 0


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