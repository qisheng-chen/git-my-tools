@echo off
setlocal
set "currentbranch="
for /f %%i in ('git rev-parse --abbrev-ref HEAD') do (
	set "currentbranch=%%i"
)
set /a boolResult=0

echo Branches:
for /f %%i in ('git branch') do (
  if not %%i==* (
    if not %%i==master (
		if not %%i==main (
		  call :EchoInline %%i
		  call :EchoRed "[To be deleted]"
		  set /a boolResult=1
		) else (
		  call :EchoInline %%i
		  call :EchoGreen "[main branch will not be deleted]"
		)
    ) else (
	  call :EchoInline %%i
	  call :EchoGreen "[master branch will not be deleted]"
	)
  ) else (
	 call :EchoInline %currentbranch%
	 call :EchoGreen "[current branch will not be deleted]"
  )
)

if "%boolResult%"=="0" (
  call :EchoGreen "No branch to be deleted"
  endlocal & exit /b 0
)

CHOICE /M "Do yo want to continue deletion"
if not "%errorlevel%"=="1" (
   echo Abort
   endlocal & exit /b 0
)


for /f %%i in ('git branch') do (
  if not %%i==* (
    if not %%i==master (
    	if not %%i==main (
		  echo Deleting branch: %%i
		  git branch -D %%i
		)      
    )
  )
)

endlocal

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