@echo off
title AI Astrologer - Start Here (Auto)
color 0E
cls

echo.
echo   ╔═══════════════════════════════════════════════════╗
echo   ║   AI ASTROLOGER - AUTO MODE                       ║
echo   ╚═══════════════════════════════════════════════════╝
echo.
echo   Choose an option:
echo.
echo   1. Auto Upgrade & Start (Recommended)
echo   2. Just Start Application
echo   3. Just Upgrade Packages
echo   4. Install Auto-Start on Boot
echo   5. Auto Recovery (Fix Issues)
echo   6. Exit
echo.
set /p choice="Enter choice (1-6): "

if "%choice%"=="1" (
    call AUTO_UPGRADE_AND_START.bat
    goto end
)

if "%choice%"=="2" (
    call AUTO_START.bat
    goto end
)

if "%choice%"=="3" (
    call AUTO_UPGRADE.bat
    goto end
)

if "%choice%"=="4" (
    call INSTALL_AUTO_START.bat
    goto end
)

if "%choice%"=="5" (
    call AUTO_RECOVERY.bat
    goto end
)

if "%choice%"=="6" (
    exit /b 0
)

echo   Invalid choice!
timeout /t 2 /nobreak >nul
goto end

:end
pause
