@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

ECHO.
ECHO [93m:::
ECHO :::        .^^.
ECHO ::: .-----'   `-----.   Star Trek Voyager: Elite Force
ECHO ::: ^| [##'     `##] ^|   Web-connector Script v1.0
ECHO ::: `---'   __  `---'   From efservers.com
ECHO :::    ^| .-'  `. ^|      Join a game directly from
ECHO :::    ^|'       `^|      The website/webapp!
ECHO :::
ECHO ::: Note: This file only works with game clients that will probably
ECHO :::       not be released until 2024 (or maybe even later)
ECHO :::       Use EFwebConnector.bat if this one doesn't work.
ECHO ::: [0m
ECHO.

SET ELITE_FORCE_EXECUTABLE=

SET "EF_EXE_0=%~dp0stvoyhm.exe"
SET "EF_EXE_1=%~dp0iostvoyHM.x86.exe"
SET "EF_EXE_2=%~dp0iostvoyHM.x86_64.exe"
SET "EF_EXE_3=%~dp0liliumvoyhm.x86.exe"
SET "EF_EXE_4=%~dp0liliumvoyhm.x86_64.exe"
SET "EF_EXE_5=%~dp0tulipvoyhm.x86_64.exe"
SET "EF_EXE_6=%~dp0cMod-stvoyHM.exe"
SET "EF_EXE_7=%~dp0ioEF-cMod.x86.exe"
SET "EF_EXE_8=%~dp0ioEF-cMod.x86_64.exe"

IF EXIST "%EF_EXE_0%" (SET "ELITE_FORCE_EXECUTABLE=%EF_EXE_0%")
IF EXIST "%EF_EXE_1%" (SET "ELITE_FORCE_EXECUTABLE=%EF_EXE_1%")
IF EXIST "%EF_EXE_2%" (SET "ELITE_FORCE_EXECUTABLE=%EF_EXE_2%")
IF EXIST "%EF_EXE_3%" (SET "ELITE_FORCE_EXECUTABLE=%EF_EXE_3%")
IF EXIST "%EF_EXE_4%" (SET "ELITE_FORCE_EXECUTABLE=%EF_EXE_4%")
IF EXIST "%EF_EXE_5%" (SET "ELITE_FORCE_EXECUTABLE=%EF_EXE_5%")
IF EXIST "%EF_EXE_6%" (SET "ELITE_FORCE_EXECUTABLE=%EF_EXE_6%")
IF EXIST "%EF_EXE_7%" (SET "ELITE_FORCE_EXECUTABLE=%EF_EXE_7%")
IF EXIST "%EF_EXE_8%" (SET "ELITE_FORCE_EXECUTABLE=%EF_EXE_8%")

IF NOT EXIST "%ELITE_FORCE_EXECUTABLE%" (
  ECHO Warning: Could not find elite force executable.
  ECHO If this file was not placed in your elite force directory
  ECHO then please close this window and move the file.
  ECHO.
  ECHO You can download the game from the LINKS page at https://efservers.com
  ECHO.
  ECHO If your game client executable is not recognized then enter the
  ECHO executable file name here, including ".exe".
  ECHO.
  SET /P EF_EXE="Enter executable filename: "
  ECHO.
  SET ELITE_FORCE_EXECUTABLE=%~dp0!EF_EXE!
  IF NOT EXIST "!ELITE_FORCE_EXECUTABLE!" (
    ECHO Still can't find the file. Sorry.
    ECHO %ELITE_FORCE_EXECUTABLE%
    ECHO.
    PAUSE
    EXIT /B 1
  )
)

REG ADD "HKCU\Software\Classes\stvef" /v "CustomUrlApplication" /t REG_SZ /d "%ELITE_FORCE_EXECUTABLE%" /F
REG ADD "HKCU\Software\Classes\stvef" /v "CustomUrlArguments"   /t REG_SZ /d "\"%%1\"" /F
REG ADD "HKCU\Software\Classes\stvef" /v "URL Protocol"         /t REG_SZ /d "" /F
REG ADD "HKCU\Software\Classes\stvef\DefaultIcon"               /t REG_SZ /d "%ELITE_FORCE_EXECUTABLE%,0" /F
REG ADD "HKCU\Software\Classes\stvef\shell\open\command"        /t REG_SZ /d "\"%ELITE_FORCE_EXECUTABLE%\" +set logfile 2 --uri \"%%1\"" /F

ECHO.
ECHO [93m:::
ECHO ::: If you saw five successful operations above then that
ECHO ::: means that the URI protocol was registered successfully.
ECHO :::
ECHO ::: Now open https://efservers.com and join a server.
ECHO ::: See you out there, commander^^!
ECHO ::: [0m
ECHO.

PAUSE
