@echo off
setlocal enabledelayedexpansion
title Offline AI Pendrive - Automated Setup

set "ROOT_DIR=%~dp0"
set "ENGINE_DIR=%ROOT_DIR%Engine\llama"
set "MODELS_DIR=%ROOT_DIR%Models"

echo =======================================================
echo          OFFLINE AI PENDRIVE - SETUP WIZARD
echo =======================================================
echo.
echo This script will set up your USB drive by downloading:
echo  1. Portable llama.cpp engine (~18 MB)
echo  2. Llama 3.2 3B Instruct model (~1.88 GB)
echo  3. Clean chat template to prevent tool hallucinations
echo.
echo Note: Internet connection is only required during this setup.
echo After setup, everything runs 100%% offline!
echo.
pause

:: Create directories
echo.
echo [1/3] Creating directory structure...
if not exist "%ENGINE_DIR%" mkdir "%ENGINE_DIR%"
if not exist "%MODELS_DIR%" mkdir "%MODELS_DIR%"

:: Copy template.jinja to Engine/llama
if exist "%ROOT_DIR%template.jinja" (
    copy /y "%ROOT_DIR%template.jinja" "%ENGINE_DIR%\template.jinja" >nul
)

:: Download and extract llama.cpp if not present
echo.
if exist "%ENGINE_DIR%\llama-server.exe" (
    echo [2/3] llama.cpp engine already exists. Skipping download.
) else (
    echo [2/3] Downloading portable llama.cpp engine (~18 MB)...
    powershell -NoProfile -Command ^
        "$zip = '$env:TEMP\llama-cpu.zip'; " ^
        "$url = 'https://github.com/ggml-org/llama.cpp/releases/download/b11346/llama-b11346-bin-win-cpu-x64.zip'; " ^
        "Write-Host 'Downloading engine package...'; " ^
        "curl.exe -L -o $zip $url; " ^
        "Write-Host 'Extracting to Engine\llama...'; " ^
        "Expand-Archive -Path $zip -DestinationPath '%ENGINE_DIR%' -Force; " ^
        "Remove-Item $zip -Force;"
)

:: Download model if not present
echo.
set "MODEL_FILE=%MODELS_DIR%\Llama-3.2-3B-Instruct-Q4_K_M.gguf"
if exist "%MODEL_FILE%" (
    echo [3/3] Model already exists. Skipping download.
) else (
    echo [3/3] Downloading Llama 3.2 3B Instruct (Q4_K_M) (~1.88 GB)...
    echo Depending on your internet speed, this may take a few minutes.
    curl.exe -L -C - --progress-bar -o "%MODEL_FILE%" "https://huggingface.co/bartowski/Llama-3.2-3B-Instruct-GGUF/resolve/main/Llama-3.2-3B-Instruct-Q4_K_M.gguf"
)

echo.
echo =======================================================
echo                 SETUP COMPLETE!
echo =======================================================
echo.
echo Your Offline AI Pendrive is ready to use!
echo Double-click 'Start-AI.bat' anytime to start the AI.
echo.
pause
