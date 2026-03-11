@echo off
title AI Astrologer - Host Local Server
color 0B
cls

echo.
echo   ╔═══════════════════════════════════════╗
echo   ║   HOSTING LOCAL SERVER                ║
echo   ╚═══════════════════════════════════════╝
echo.

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   [ERROR] Node.js not installed!
    echo   Install from: https://nodejs.org
    pause
    exit /b 1
)

echo   [CHECK] Node.js version:
node --version
echo.

REM Install dependencies if needed
if not exist "node_modules" (
    echo   [SETUP] Installing dependencies...
    echo   This may take 2-3 minutes (first time only)
    echo.
    call npm install
    if %ERRORLEVEL% NEQ 0 (
        echo   [ERROR] Installation failed!
        pause
        exit /b 1
    )
    echo   [SUCCESS] Dependencies installed
    echo.
)

REM Environment file
if not exist ".env.local" (
    if exist ".env.example" (
        copy ".env.example" ".env.local" >nul
    )
)

REM Stop any existing servers
echo   [CLEANUP] Stopping existing servers...
taskkill /F /IM node.exe >nul 2>&1
timeout /t 1 /nobreak >nul

REM Choose port
set SERVER_PORT=8080
set NPM_SCRIPT=dev:8080

echo   [START] Starting local server on port %SERVER_PORT%...
echo   [INFO] Server URL: http://localhost:%SERVER_PORT%
echo   [INFO] Server window will open separately
echo.

REM Start server in separate window
start "AI Astrologer Server - Port %SERVER_PORT%" cmd /k "title AI Astrologer Server && echo. && echo ═══════════════════════════════════ && echo   AI ASTROLOGER SERVER              && echo   Port: %SERVER_PORT%                  && echo ═══════════════════════════════════ && echo. && echo Starting server... && echo Please wait for 'Ready' message... && echo. && npm run %NPM_SCRIPT%"

echo   [WAIT] Waiting for server to start...
echo   [INFO] This takes 10-20 seconds
echo.

REM Wait for server to be ready
set attempts=0
:wait_loop
timeout /t 2 /nobreak >nul
set /a attempts+=1

REM Check if server is responding
curl -s http://localhost:%SERVER_PORT% >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo.
    echo   ╔═══════════════════════════════════════╗
    echo   ║   ✓ SERVER IS RUNNING!                ║
    echo   ╚═══════════════════════════════════════╝
    echo.
    echo   Server URL: http://localhost:%SERVER_PORT%
    echo   Status: Ready and accepting connections
    echo.
    echo   [OPEN] Opening browser...
    timeout /t 1 /nobreak >nul
    start http://localhost:%SERVER_PORT%
    echo.
    echo   ═══════════════════════════════════
    echo   SERVER HOSTED SUCCESSFULLY!
    echo   ═══════════════════════════════════
    echo.
    echo   Server is running in the other window.
    echo   Keep that window open to keep server running.
    echo.
    echo   To stop server: Close the server window
    echo   or press Ctrl+C in that window.
    echo.
    pause
    exit /b 0
)

REM Show progress
if %attempts% LEQ 5 (
    echo   [WAIT] Starting server... ^(%attempts%/30^)
) else if %attempts% LEQ 15 (
    echo   [WAIT] Compiling application... ^(%attempts%/30^)
) else (
    echo   [WAIT] Almost ready... ^(%attempts%/30^)
)

if %attempts% GEQ 30 (
    echo.
    echo   [INFO] Server is taking longer than expected
    echo   [INFO] Opening browser - server may still be starting
    start http://localhost:%SERVER_PORT%
    echo.
    echo   Server is starting. If you see an error:
    echo   1. Wait 10-20 more seconds
    echo   2. Refresh browser (F5)
    echo   3. Check server window for status
    echo.
    pause
    exit /b 0
)

goto wait_loop
