@echo off
setlocal
set "branchkeyword=user/%username%/"
echo Branches:
for /f %%i in ('git remote show origin ^| findstr /ic:%branchkeyword%') do (
  call :EchoInline %%i
  call :EchoRed "[To be deleted]"
)

CHOICE /M "Do yo want to continue deletion"
if not "%errorlevel%"=="1" (
   echo Abort
   endlocal & exit /b 0
)

for /f %%i in ('git remote show origin ^| findstr /ic:%branchkeyword%') do (
  call :EchoCyan git push origin --delete %%i
  git push origin --delete %%i
)

endlocal


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