@echo off
REM Runs OpenCode in a docker container and ...
REM Mounts the current-folder as the workspace and working directory
REM Mounts subfolders and files of the the common-folder
REM \share as the tmp directory for opencode to keep logs and session-data
REM \config\opencode.jsonc file
REM \config\agents and other folders , it is expected to be a sibling of the folder of this batch file
REM 
REM the subfolder \cmd (that contains this batch-script) is expected to be a sibling of \config and \share

set "CONFIGFILE=opencode.jsonc"
set "OPENCODE_WORKSPACE=%cd%"

docker --version >nul 2>&1
if errorlevel 1 (
echo Docker is not installed
goto QUIT
)

docker info >nul 2>&1
if errorlevel 1 (
echo Docker is installed but not running
goto QUIT
)

REM The parent-folder of this script is expected to be the folder 
REM for the global common opencode files and folders like config/opencode.jsonc and config/agents
for %%I in ("%~dp0..") do set "OPENCODE_COMMONPATH=%%~fI"

REM Check if the common folder contains a opencode.jsonc
if not exist "%OPENCODE_COMMONPATH%\config\%CONFIGFILE%" (
echo COMMON OPENCODE CONFIG FILE NOT FOUND: "%OPENCODE_COMMONPATH%\config\%CONFIGFILE%"
goto QUIT
)

REM Check if this script can be executed from everywhere on the computer
REM We test from within the Temp folder, if the path to the script is found the environment variable PATH
pushd %TEMP%
where "%~nx0" >nul 2>&1
set "RC=%ERRORLEVEL%"
popd

if %RC% neq 0 (
echo PATH TO COMMAND '%~nx0' NOT FOUND! 
echo Please extend the environment variable PATH with:
for %%I in ("%~dp0.") do echo %%~fI
goto QUIT
)

call :CheckArgs %*

if defined IS_RUNPOD_MODEL (
echo RunPod model detected
if not defined RUNPOD_ID (
echo ERROR: RUNPOD_ID is not defined.
goto QUIT
)
echo Using RUNPOD_ID=%RUNPOD_ID%
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
  ghcr.io/anomalyco/opencode ^
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

