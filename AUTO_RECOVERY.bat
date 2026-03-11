@echo off
title AI Astrologer - Auto Recovery
color 0C
cls

echo.
echo   ╔═══════════════════════════════════════════════════╗
echo   ║   AI ASTROLOGER - AUTO RECOVERY                  ║
echo   ╚═══════════════════════════════════════════════════╝
echo.
echo   This will automatically fix common issues:
echo   ✓ Stop crashed servers
echo   ✓ Clean up processes
echo   ✓ Reinstall dependencies if corrupted
echo   ✓ Restart the application
echo.

REM Stop all Node processes
echo   [STEP 1] Stopping all Node.js processes...
taskkill /F /IM node.exe >nul 2>&1
timeout /t 2 /nobreak >nul
echo   [OK] All processes stopped
echo.

REM Clean npm cache
echo   [STEP 2] Cleaning npm cache...
call npm cache clean --force >nul 2>&1
echo   [OK] Cache cleaned
echo.

REM Remove node_modules if corrupted
echo   [STEP 3] Checking dependencies...
if exist "node_modules" (
    echo   [INFO] Dependencies exist, verifying...
    call npm list --depth=0 >nul 2>&1
    if %ERRORLEVEL% NEQ 0 (
        echo   [WARNING] Dependencies may be corrupted
        echo   [FIX] Reinstalling dependencies...
        rmdir /s /q node_modules >nul 2>&1
        call npm install
    ) else (
        echo   [OK] Dependencies are valid
    )
) else (
    echo   [FIX] Installing dependencies...
    call npm install
)
echo.

REM Fix environment file
if not exist ".env.local" (
    if exist ".env.example" (
        copy ".env.example" ".env.local" >nul
        echo   [OK] Environment file created
    )
)

echo   [STEP 4] Restarting application...
echo.
call AUTO_START.bat
