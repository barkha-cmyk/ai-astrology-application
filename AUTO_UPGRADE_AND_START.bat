@echo off
title AI Astrologer - Auto Upgrade & Start
color 0E
cls

echo.
echo   ╔═══════════════════════════════════════════════════╗
echo   ║   AI ASTROLOGER - AUTO UPGRADE & START           ║
echo   ╚═══════════════════════════════════════════════════╝
echo.
echo   This will:
echo   1. Upgrade all packages to latest versions
echo   2. Install any missing dependencies
echo   3. Start the application automatically
echo   4. Open browser when ready
echo.
echo   Press any key to begin...
pause >nul
cls

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   [ERROR] Node.js not installed!
    echo   Install from: https://nodejs.org
    pause
    exit /b 1
)

echo   [STEP 1] Upgrading packages...
echo.
call npm update
echo.

echo   [STEP 2] Installing/updating dependencies...
echo.
call npm install
if %ERRORLEVEL% NEQ 0 (
    echo   [ERROR] Installation failed!
    pause
    exit /b 1
)

echo.
echo   [STEP 3] Starting application...
echo.
call AUTO_START.bat
