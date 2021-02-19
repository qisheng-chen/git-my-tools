@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

set "prUrl="
set "url="
for /f "delims=" %%i in ('git remote get-url origin') do (
	REM default for Azure devops
	set "prUrl=%%i/pullrequests"
	set "url=%%i"
)

REM if from github, correct it	
set "subString=https://github.com"
set /a boolResult=0
call :startWith "!url!" "!subString!" boolResult
if "!boolResult!"=="1" (
	REM trim end .git
	set "trimEnd=.git"
	set trimResult=
	call :trimEnd "!url!" "!trimEnd!" trimResult
	set "prUrl=!trimResult!/pulls"
) 
	
call :EchoInline "Opening "
call :EchoGreen !prUrl!
start !prUrl!

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
    

REM Check if a text starts with specified text
REM It requires :getStringLength
REM Parameter1: [IN] target text
REM                    1. Best practice: add " at the begining and end of the string when you pass the parameter to the procedure                       
REM                    2. The string itself could not contain "
REM Parameter2: [IN] start with text
REM                    1. Best practice: add " at the begining and end of the string when you pass the parameter to the procedure                       
REM                    2. The string itself could not contain "
REM Parameter3: [OUT] start with result, 0 - NO  1 - Yes
REM
:startWith
    set _sw_targetText=%~1
    set _sw_startWith=%~2
    set /a _sw_startWithResult=0
    set _sw_tmpStart=
    set _sw_num=
    
    call :getStringLength "!_sw_startWith!" _sw_num
    set _sw_tmpStart=!_sw_targetText:~0,%_sw_num%!
    if /I "!_sw_tmpStart!"=="!_sw_startWith!" (set /a _sw_startWithResult=1 )
    
    REM set out parameter
    set /a %3=!_sw_startWithResult!
    
    REM clean up local variables
    set _sw_targetText=
    set _sw_startWith=
    set _sw_startWithResult=
    set _sw_tmpStart=
    set _sw_num=
    
goto :eof

REM Trim specified text from end of target text
REM It requires :getStringLength
REM Parameter1: [IN] target text
REM                    1. Best practice: add " at the begining and end of the string when you pass the parameter to the procedure                       
REM                    2. The string itself could not contain "
REM Parameter2: [IN] trim text
REM                    1. Best practice: add " at the begining and end of the string when you pass the parameter to the procedure                       
REM                    2. The string itself could not contain "
REM Parameter3: [OUT] trim end result
REM
:trimEnd
    set _te_stringToTrim=%~1
    set _te_trim=%~2
    set _te_trimResult=
    
    call :getStringLength "!_te_trim!" __num
    set _te_trimResult=!_te_stringToTrim:~0,-%__num%!
    if /i not "!_te_trimResult!!_te_trim!"=="!_te_stringToTrim!" (
        set _te_trimResult=!_te_stringToTrim!
    )

    REM set out parameter
    set %3=!_te_trimResult!
    
    REM clean up local variables
    set _te_stringToTrim=
    set _te_trim=
    set _te_trimResult=
    
goto :eof

REM Get length of a string
REM parameter1: [IN] string
REM                    1. Best practice: add " at the begining and end of the string when you pass the parameter to the procedure                       
REM                    2. The string itself could not contain "
REM parameter2: [OUT] length
REM
:getStringLength
    set _gsl_str=%~1
    set _gsl_num=
    
    :_gsl_getLen
    if not "!_gsl_str!"=="" (
        set /a _gsl_num+=1
        set "_gsl_str=!_gsl_str:~1!"
        goto :_gsl_getLen
    )
    
    REM set out parameter
    set /a %2=!_gsl_num!
    
    REM clean up local variables
    set _gsl_str=
    set _gsl_num=
 
goto :eof


:Pass   
    endlocal & exit /B 0