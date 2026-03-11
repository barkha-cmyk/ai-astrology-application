@echo off
title Install Auto-Start on Windows Boot
color 0B
cls

echo.
echo   ╔═══════════════════════════════════════════════════╗
echo   ║   INSTALL AUTO-START ON WINDOWS BOOT             ║
echo   ╚═══════════════════════════════════════════════════╝
echo.
echo   This will add AI Astrologer to Windows startup
echo   so it starts automatically when you boot your computer.
echo.
echo   WARNING: This requires administrator privileges.
echo.
set /p confirm="Continue? (Y/N): "

if /i not "%confirm%"=="Y" (
    echo   Installation cancelled.
    pause
    exit /b 0
)

REM Get current directory
set "CURRENT_DIR=%~dp0"
set "BATCH_FILE=%CURRENT_DIR%AUTO_START.bat"

REM Create VBS script to run batch file silently
set "VBS_FILE=%TEMP%\AI_Astrologer_Startup.vbs"
echo Set WshShell = CreateObject^("WScript.Shell"^) > "%VBS_FILE%"
echo WshShell.Run chr^(34^) ^& "%BATCH_FILE%" ^& chr^(34^), 0 >> "%VBS_FILE%"
echo Set WshShell = Nothing >> "%VBS_FILE%"

REM Copy to startup folder
set "STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
copy "%VBS_FILE%" "%STARTUP_FOLDER%\AI_Astrologer_Startup.vbs" >nul 2>&1

if %ERRORLEVEL% EQU 0 (
    echo.
    echo   ╔═══════════════════════════════════════════════════╗
    echo   ║   ✓ AUTO-START INSTALLED!                       ║
    echo   ╚═══════════════════════════════════════════════════╝
    echo.
    echo   AI Astrologer will now start automatically
    echo   when you boot your computer.
    echo.
    echo   To disable: Delete the file from:
    echo   %STARTUP_FOLDER%
    echo.
) else (
    echo.
    echo   [ERROR] Failed to install auto-start
    echo   You may need to run this as Administrator
    echo.
)

pause
