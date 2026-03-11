@echo off
cd /d "%~dp0"
npm run auto-start
@echo off
title AI Astrologer - Auto Start
color 0B

echo.
echo ========================================
echo   AI ASTROLOGER - AUTO START
echo ========================================
echo.
echo This will start the server automatically
echo and keep it running.
echo.
echo Choose port:
echo   1. Port 3000 (Default - Recommended)
echo   2. Port 8080 (Alternative)
echo.
set /p port="Enter choice (1 or 2): "

if "%port%"=="1" set SERVER_PORT=3000
if "%port%"=="2" set SERVER_PORT=8080
if not defined SERVER_PORT (
    echo Invalid choice. Using port 3000.
    set SERVER_PORT=3000
)

echo.
echo Starting server on port %SERVER_PORT%...
echo.

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Node.js not found!
    echo Please install Node.js from https://nodejs.org
    pause
    exit /b 1
)

REM Install dependencies
if not exist "node_modules" (
    echo [SETUP] Installing dependencies (first time only)...
    call npm install
    echo.
)

REM Create env file
if not exist ".env.local" (
    if exist ".env.example" (
        copy ".env.example" ".env.local" >nul
    )
)

echo [START] Starting local server...
echo [INFO] Server will be at: http://localhost:%SERVER_PORT%
echo [INFO] Browser will open automatically
echo.

REM Start server in new window
if "%SERVER_PORT%"=="3000" (
    start "AI Astrologer Server" cmd /k "npm run dev"
) else (
    start "AI Astrologer Server" cmd /k "npm run dev:8080"
)

REM Wait for server to start
echo [WAIT] Waiting for server to be ready...
timeout /t 8 /nobreak >nul

REM Open browser
echo [OPEN] Opening browser...
start http://localhost:%SERVER_PORT%

echo.
echo ========================================
echo   Server started!
echo   URL: http://localhost:%SERVER_PORT%
echo ========================================
echo.
echo The server window is open separately.
echo Close that window to stop the server.
echo.
echo Press any key to exit this window...
pause >nul
