@ECHO OFF
REM     This Script will allow you to connect to Elite Force servers by clicking on the 'Join' buttons on https://efservers.com
REM ----------------------------------------------------------------------------------------------------------------------------------------
REM     This code decides which game EXE to use (%EF_EXE%), order of preference is cmod, lilium, ioef, fallback to stvoyHM.exe
REM     (Original) if none of the others are present.  You can remove or edit any of these lines to force your choice.
REM ----------------------------------------------------------------------------------------------------------------------------------------

REM ----------------------------------------------------------------------------------------------------------------------------------------
SET ELITE_FORCE_EXECUTABLE=%~dp0stvoyhm.exe

REM     The last executable in this list (that exists in the same folder as this batch file) is the one that will be loaded
REM     If you want to specify the executable, edit the 'SET' line above and remove all the indented 'SET' and 'IF' lines in the block below 
    SET "EF_EXE_1=%~dp0iostvoyHM.x86.exe"
    SET "EF_EXE_2=%~dp0iostvoyHM.x86_64.exe"
    SET "EF_EXE_3=%~dp0liliumvoyhm.x86.exe"
    SET "EF_EXE_4=%~dp0liliumvoyhm.x86_64.exe"
    SET "EF_EXE_5=%~dp0tulipvoyhm.x86_64.exe"
    SET "EF_EXE_6=%~dp0ioEF-cMod.x86.exe"
    SET "EF_EXE_7=%~dp0ioEF-cMod.x86_64.exe"
    

    IF EXIST "%EF_EXE_1%" (SET "ELITE_FORCE_EXECUTABLE=%EF_EXE_1%")
    IF EXIST "%EF_EXE_2%" (SET "ELITE_FORCE_EXECUTABLE=%EF_EXE_2%") 
    IF EXIST "%EF_EXE_3%" (SET "ELITE_FORCE_EXECUTABLE=%EF_EXE_3%") 
    IF EXIST "%EF_EXE_4%" (SET "ELITE_FORCE_EXECUTABLE=%EF_EXE_4%") 
    IF EXIST "%EF_EXE_5%" (SET "ELITE_FORCE_EXECUTABLE=%EF_EXE_5%") 
    IF EXIST "%EF_EXE_6%" (SET "ELITE_FORCE_EXECUTABLE=%EF_EXE_6%") 
    IF EXIST "%EF_EXE_7%" (SET "ELITE_FORCE_EXECUTABLE=%EF_EXE_7%")

IF NOT EXIST "%ELITE_FORCE_EXECUTABLE%" (GOTO ERROR_NO_EF_IN_FOLDER) 
REM ----------------------------------------------------------------------------------------------------------------------------------------

    REM ----------------------------------------------------------------------------------------------------------------------------------------
    REM     If this file is not loaded by the URI Handler (You double clicked this file) Then register the URI Handler
    IF "%~1"=="" GOTO SHOW_LOGO
    REM ----------------------------------------------------------------------------------------------------------------------------------------
REM *****************************************************************************************************************************************


:LAUNCH_ELITE_FORCE
REM *****************************************************************************************************************************************
REM     If this file was loaded by the URI Handler (You clicked 'Join' on efservers.com)
REM     Then the information for joining the chosen server is extracted from the passed aruments
REM     and put in a format that the Elite Force executable can understand
  
SET ARGUMENTS=%1
SET "ARGUMENTS=%ARGUMENTS:stvef:=%"
FOR /f "tokens=1,2,3,4 delims=; " %%a IN ("%ARGUMENTS%") DO SET "SERVER_IP=%%a"&SET "SERVER_PORT=%%b"&SET "SERVER_NAME=%%c"&SET "MAP_NAME=%%d"

    REM ----------------------------------------------------------------------------------------------------------------------------------------
    REM     THIS BLOCK IS OPTIONAL - Pauses the script before launching the game, while displaying the
    REM     name of the chosen server and the name of the map currently running on that server, so you can close (cancel)
    REM     or continue to load Elite Force.  Most of these lines convert any symbols in the server name back into a readable format
    REM     ----- Remove the 'REM' from the line below ('GOTO SKIP_PAUSE') to disable the pause window and go straight into the game.

REM GOTO SKIP_PAUSE 
    
        GOTO SHOW_LOGO
        :PAUSE_BEFORE_LAUNCH
        SETLOCAL ENABLEDELAYEDEXPANSION
        SET "SERVER_NAME=!SERVER_NAME:%%20= !"
        SET "SERVER_NAME=!SERVER_NAME:%%5C=\!"
        SET "SERVER_NAME=!SERVER_NAME:%%7B={!"
        SET "SERVER_NAME=!SERVER_NAME:%%7D=}!"
        SET "SERVER_NAME=!SERVER_NAME:%%3C=^<!"
        SET "SERVER_NAME=!SERVER_NAME:%%7C=^|!"
        ECHO [92m Joining %SERVER_NAME%  Map:   %MAP_NAME% [0m
        ECHO 
        ECHO [93m PRESS ANY KEY TO JOIN
        ECHO 
        PAUSE
    REM ----------------------------------------------------------------------------------------------------------------------------------------

:SKIP_PAUSE
REM *****************************************************************************************************************************************
REM     This starts EF with the CONNECT command with the selected server IP and Port
    START "" /D "%~dp0 " "%ELITE_FORCE_EXECUTABLE%" +CONNECT %SERVER_IP%:%SERVER_PORT%
EXIT 0
REM *****************************************************************************************************************************************


:REGISTER_URI_HANDLER
REM *****************************************************************************************************************************************
    REM     This code adds Windows registry values that allow the cusom URI (STVEF:\\ hyperlinks)
    REM     to be intercepted and passed to this batch file in future.

    ECHO [101;93m REGISTERING THE STVEF: URI HANDLER [0m
    SET THIS_BATCH_FILE=%~dpnx0
    REG ADD "HKCU\Software\Classes\STVEF" /v "CustomUrlApplication" /t REG_SZ /d "%THIS_BATCH_FILE% ""%%1""" /F
    REG ADD "HKCU\Software\Classes\STVEF" /v "CustomUrlArguments"   /t REG_SZ /d "%%1\\" /F
    REG ADD "HKCU\Software\Classes\STVEF" /v "URL Protocol"         /t REG_SZ /d "" /F
    REG ADD "HKCU\Software\Classes\STVEF\DefaultIcon"               /t REG_SZ /d "%ELITE_FORCE_EXECUTABLE%,0" /F
    REG ADD "HKCU\Software\Classes\STVEF\shell\open\command"        /t REG_SZ /d "%THIS_BATCH_FILE% ""%%1""" /F
    ECHO [101;93m This batch file needs to stay in the same folder as your Elite Force Executable for this to work! - DON'T DELETE IT!  [0m

    PAUSE
    EXIT 0
REM *****************************************************************************************************************************************

:ERROR_NO_EF_IN_FOLDER
REM *****************************************************************************************************************************************
    ECHO [101;93m No Elite Force executable found!
    ECHO This batch file needs to be placed in the same folder as your Elite Force Executable!
    ECHO You can download the game from the LINKS page at https://efservers.com [0m

    PAUSE
    EXIT 1
REM *****************************************************************************************************************************************

REM *****************************************************************************************************************************************
:SHOW_LOGO
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
IF "%~1"=="" GOTO REGISTER_URI_HANDLER
GOTO PAUSE_BEFORE_LAUNCH


:::[93m
:::        .^.
::: .-----'   `-----.   Star Trek Voyager: Elite Force
::: | [##'     `##] |   Web-connector Script v0.9
::: `---'   __  `---'   From efservers.com
:::    | .-'  `. |      Join a game directly from
:::    |'       `|      The website/webapp!
::: [0m
::: 
:::  Edit this file to stop from pausing before joining!       
:::         
REM *****************************************************************************************************************************************
