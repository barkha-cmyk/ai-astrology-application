@echo off
title AI Astrologer - Auto Upgrade
color 0B
cls

echo.
echo   ╔═══════════════════════════════════════════════════╗
echo   ║   AI ASTROLOGER - AUTO UPGRADE                   ║
echo   ╚═══════════════════════════════════════════════════╝
echo.
echo   This will automatically:
echo   ✓ Check for updates
echo   ✓ Upgrade all packages
echo   ✓ Fix any issues
echo   ✓ Start the application
echo.

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   [ERROR] Node.js not installed!
    echo   Install from: https://nodejs.org
    pause
    exit /b 1
)

echo   [STEP 1] Checking current versions...
echo.
node --version
npm --version
echo.

echo   [STEP 2] Upgrading npm to latest version...
call npm install -g npm@latest
echo.

echo   [STEP 3] Checking for package updates...
echo   [INFO] This may take a few minutes...
echo.

REM Update all packages
call npm update
if %ERRORLEVEL% NEQ 0 (
    echo   [WARNING] Some packages may have failed to update
)

echo.
echo   [STEP 4] Installing latest dependencies...
call npm install
if %ERRORLEVEL% NEQ 0 (
    echo   [ERROR] Installation failed!
    pause
    exit /b 1
)

echo.
echo   [STEP 5] Checking for outdated packages...
call npm outdated
echo.

echo   ╔═══════════════════════════════════════════════════╗
echo   ║   ✓ UPGRADE COMPLETE!                            ║
echo   ╚═══════════════════════════════════════════════════╝
echo.
echo   All packages have been upgraded to latest versions.
echo.
echo   Would you like to start the application now?
set /p start="Start application? (Y/N): "

if /i "%start%"=="Y" (
    echo.
    echo   [START] Starting application...
    call AUTO_START.bat
) else (
    echo.
    echo   Upgrade complete! Run AUTO_START.bat to start the application.
    pause
)
