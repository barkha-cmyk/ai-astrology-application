@echo off
title AI Astrologer - Start Menu
color 0B
cls

:menu
cls
echo.
echo   ╔═══════════════════════════════════════════════════╗
echo   ║   AI ASTROLOGER - START MENU                      ║
echo   ╚═══════════════════════════════════════════════════╝
echo.
echo   Choose how you want to start the application:
echo.
echo   ┌─────────────────────────────────────────────────┐
echo   │  1. Start on Port 3000 (Default - Recommended)  │
echo   │  2. Start on Port 8080 (Alternative)            │
echo   │  3. Fix Connection Error                        │
echo   │  4. Complete Setup (Install Everything)         │
echo   │  5. Check Server Status                         │
echo   │  6. Exit                                        │
echo   └─────────────────────────────────────────────────┘
echo.
set /p choice="Enter your choice (1-6): "

if "%choice%"=="1" goto start_3000
if "%choice%"=="2" goto start_8080
if "%choice%"=="3" goto fix_error
if "%choice%"=="4" goto complete_setup
if "%choice%"=="5" goto check_status
if "%choice%"=="6" goto exit
goto invalid

:start_3000
cls
echo.
echo   [INFO] Starting server on port 3000...
echo.
call start.bat
goto menu

:start_8080
cls
echo.
echo   [INFO] Starting server on port 8080...
echo.
call start-8080.bat
goto menu

:fix_error
cls
echo.
echo   [INFO] Running connection error fix...
echo.
call FIX_NOW.bat
goto menu

:complete_setup
cls
echo.
echo   [INFO] Running complete setup...
echo.
if exist "RUN_ALL.bat" (
    call RUN_ALL.bat
) else (
    echo   [INFO] Complete setup script not found
    echo   Running standard start instead...
    call start.bat
)
goto menu

:check_status
cls
echo.
echo   ╔═══════════════════════════════════════════════════╗
echo   ║   SERVER STATUS CHECK                             ║
echo   ╚═══════════════════════════════════════════════════╝
echo.
echo   Checking if servers are running...
echo.

REM Check port 3000
curl -s http://localhost:3000 >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   ✓ Port 3000: RUNNING
    echo   ✓ URL: http://localhost:3000
) else (
    echo   ✗ Port 3000: NOT RUNNING
    echo   ✗ URL: http://localhost:3000 (not accessible)
)

echo.

REM Check port 8080
curl -s http://localhost:8080 >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   ✓ Port 8080: RUNNING
    echo   ✓ URL: http://localhost:8080
) else (
    echo   ✗ Port 8080: NOT RUNNING
    echo   ✗ URL: http://localhost:8080 (not accessible)
)

echo.
echo   ┌─────────────────────────────────────────────────┐
echo   │  Quick Actions:                                   │
echo   │                                                  │
echo   │  • If port 3000 is running:                     │
echo   │    Open: http://localhost:3000                  │
echo   │                                                  │
echo   │  • If port 8080 is running:                     │
echo   │    Open: http://localhost:8080                  │
echo   │                                                  │
echo   │  • If neither is running:                       │
echo   │    Choose option 1 or 2 from main menu          │
echo   └─────────────────────────────────────────────────┘
echo.
pause
goto menu

:invalid
echo.
echo   [ERROR] Invalid choice. Please enter 1-6.
timeout /t 2 /nobreak >nul
goto menu

:exit
cls
echo.
echo   Thank you for using AI Astrologer!
echo   Goodbye!
echo.
timeout /t 2 /nobreak >nul
exit /b 0
