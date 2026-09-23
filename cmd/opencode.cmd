@echo off
setlocal
REM Runs OpenCode in a docker container and ...
REM Mounts the current-folder as the workspace and working directory
REM Mounts subfolders and files of the the common-folder
REM \share as the tmp directory for opencode to keep logs and session-data
REM \config\opencode.jsonc file
REM \config\agents and other folders , it is expected to be a sibling of the folder of this batch file
REM 
REM the subfolder \cmd (that contains this batch-script) is expected to be a sibling of \config and \share

REM Docker-Image File versions, add new version to the end, latest is the active one

if not defined OPENCODE_IMAGE (
set OPENCODE_IMAGE=ghcr.io/anomalyco/opencode
set OPENCODE_IMAGE=ghcr.io/anomalyco/opencode@sha256:05469d6677f41be0255fe660fddcf2c19040ef6789083c0b48094938c4d1ed9d
set OPENCODE_IMAGE=ghcr.io/anomalyco/opencode@sha256:0d3c9551ea2522fcfd23fbc2e302fc87218d6c198bff277e8ab44d93a3bd6d3d
)

REM -----------------------------------------------
set "CONFIGFILE=opencode.jsonc"
set "OPENCODE_WORKSPACE=%cd%"

REM Escape-Sequences for error output
for /f %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"
set RED=%ESC%[31m
set OFF=%ESC%[0m

docker --version >nul 2>&1
if errorlevel 1 (
echo %RED%Docker is not installed%OFF%
goto QUIT
)

docker info >nul 2>&1
if errorlevel 1 (
echo %RED%Docker is installed but not running%OFF%
goto QUIT
)

echo Image: %OPENCODE_IMAGE%

REM The parent-folder of this script is expected to be the folder 
REM for the global common opencode files and folders like config/opencode.jsonc and config/agents
for %%I in ("%~dp0..") do set "OPENCODE_COMMONPATH=%%~fI"

REM Check if the common folder contains a opencode.jsonc
if not exist "%OPENCODE_COMMONPATH%\config\%CONFIGFILE%" (
echo %RED%COMMON OPENCODE CONFIG FILE NOT FOUND: "%OPENCODE_COMMONPATH%\config\%CONFIGFILE%"%OFF%
goto QUIT
)

REM Check if this script can be executed from everywhere on the computer
REM We test from within the Temp folder, if the path to the script is found in the environment variable PATH
pushd %TEMP%
where "%~nx0" >nul 2>&1
set "RC=%ERRORLEVEL%"
popd

if %RC% neq 0 (
echo %RED%PATH TO COMMAND '%~nx0' NOT FOUND.%OFF%
echo Please extend the environment variable PATH with:
for %%I in ("%~dp0.") do echo %%~fI
goto QUIT
)

call :CheckArgs %*

if defined IS_RUNPOD_MODEL (
echo RunPod model detected, using RUNPOD_ID=%RUNPOD_ID%
if not defined RUNPOD_ID (
echo %RED%Missing RUNPOD_ID%OFF%
goto QUIT
)
if not defined RUNPOD_POD_API_KEY (
echo %RED%Missing RUNPOD_POD_API_KEY%OFF%
goto QUIT
)
)

docker run -it --rm ^
  --security-opt=no-new-privileges:true ^
  --cap-drop ALL ^
  -e RUNPOD_ID=%RUNPOD_ID% ^
  -e RUNPOD_POD_API_KEY=%RUNPOD_POD_API_KEY% ^
  -v "%OPENCODE_WORKSPACE%:/workspace" ^
  -w /workspace ^
  -v "%OPENCODE_COMMONPATH%\share:/root/.local/share/opencode" ^
  -v "%OPENCODE_COMMONPATH%\config\%CONFIGFILE%:/root/.config/opencode/%CONFIGFILE%:ro" ^
  -v "%OPENCODE_COMMONPATH%\config\agents:/root/.config/opencode/agents:ro" ^
  -v "%OPENCODE_COMMONPATH%\config\tools:/root/.config/opencode/tools:ro" ^
  %OPENCODE_IMAGE% ^
  %*

goto :eof

REM Subroutines
---------------
:CheckArgs
if "%~1"=="" goto :eof
if /I "%~1"=="--model" (
    echo.%~2 | findstr /I /B /C:"runpod-pod/" >nul
	if not errorlevel 1 set "IS_RUNPOD_MODEL=1"
)
shift
goto CheckArgs





:QUIT
pause

