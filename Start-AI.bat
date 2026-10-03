@echo off
setlocal enabledelayedexpansion
title Portable Offline AI Launcher

:: Detect the exact drive letter and directory of the USB drive
set "ROOT_DIR=%~dp0"
set "ENGINE_DIR=%ROOT_DIR%Engine\llama"
set "MODELS_DIR=%ROOT_DIR%Models"

cls
echo =======================================================
echo              PORTABLE OFFLINE AI DRIVE
echo =======================================================
echo.
echo Scanning models in: %MODELS_DIR%
echo.

if not exist "%ENGINE_DIR%\llama-server.exe" (
    echo [ERROR] llama-server.exe not found in %ENGINE_DIR%!
    echo Please run setup.bat first to download the engine and model.
    echo.
    pause
    exit /b
)

:: List available models
set count=0
for %%f in ("%MODELS_DIR%\*.gguf") do (
    set /a count+=1
    set "model[!count!]=%%~nxf"
    echo   [!count!] %%~nxf
)

if %count%==0 (
    echo [ERROR] No .gguf models found in %MODELS_DIR%!
    echo Please run setup.bat or copy your GGUF model files into the Models folder.
    echo.
    pause
    exit /b
)

echo.
if %count%==1 (
    echo Only one model detected. Auto-selecting model [1].
    set "SELECTED_MODEL=!model[1]!"
) else (
    set /p choice="Select model number to load [1-%count%]: "
    if not defined model[!choice!] (
        echo Invalid selection. Launching model 1 by default.
        set "SELECTED_MODEL=!model[1]!"
    ) else (
        set "SELECTED_MODEL=!model[!choice!]!"
    )
)

echo.
echo -------------------------------------------------------
echo Loading: !SELECTED_MODEL!
echo Server running at: http://127.0.0.1:8080
echo -------------------------------------------------------
echo Close this terminal window to stop the AI and unload RAM.
echo Loading model from USB into RAM (takes ~20-30 seconds)...
echo The browser will open automatically once loading is complete!
echo.

:: Automatically open browser as soon as server finishes loading
start "" cmd /c "for /l %%i in (1,1,90) do (curl.exe -s http://127.0.0.1:8080/props >nul && (start http://127.0.0.1:8080 & exit) || timeout /t 1 >nul)"

:: Start the llama server using relative paths
cd /d "%ENGINE_DIR%"
llama-server.exe -m "%MODELS_DIR%\!SELECTED_MODEL!" -c 8192 -np 1 --chat-template-file "template.jinja" --ui-config-file "ui-config.json" --port 8080 --host 127.0.0.1

pause
