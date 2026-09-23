@echo off
REM usage
REM call preset




SET /p RUNPOD_POD_API_KEY=RunPod Api-Key:
SET /p RUNPOD_ID=RunPod      Id:
SET    OPENCODE_IMAGE=opencode-dotnet10sdk
SET    OPENCODE_MODEL=runpod-pod/Qwen3.8-27B-UD-Q4_K_XL


SET ANSWER=
SET /p ANSWER="opencode --model %OPENCODE_MODEL% [Y/n]: "

if not defined ANSWER set ANSWER=Y
if /i "%ANSWER%"=="Y" (
    opencode --model %OPENCODE_MODEL%
) else (
    opencode
)
