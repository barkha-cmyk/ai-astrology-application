@echo off
title AI Astrologer - Auto Start Server
color 0E
cls

echo.
echo   ╔═══════════════════════════════════════╗
echo   ║   AI ASTROLOGER                      ║
echo   ║   Automatic Server Start             ║
echo   ╚═══════════════════════════════════════╝
echo.
echo   This will automatically start the server
echo   and open your browser when ready.
echo.
echo   Press any key to begin...
pause >nul
cls

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo   [ERROR] Node.js is not installed!
    echo.
    echo   Please install Node.js 18+ from:
    echo   https://nodejs.org
    echo.
    pause
    exit /b 1
)

echo   [CHECK] Node.js: 
node --version
echo.

REM Install dependencies
if not exist "node_modules" (
    echo   [SETUP] Installing dependencies...
    echo   This will take 2-3 minutes (first time only)
    echo.
    call npm install
    if %ERRORLEVEL% NEQ 0 (
        echo   [ERROR] Installation failed
        pause
        exit /b 1
    )
    echo   [SUCCESS] Dependencies installed!
    echo.
)

REM Environment file
if not exist ".env.local" (
    if exist ".env.example" (
        copy ".env.example" ".env.local" >nul
    )
)

echo   [START] Starting server on port 3000...
echo   [INFO] Server URL: http://localhost:3000
echo.
echo   Please wait - server is starting...
echo   Browser will open automatically when ready.
echo.

REM Start server in a new window and capture output
start "AI Astrologer Server" cmd /k "npm run dev 2>&1 | findstr /C:"Ready" /C:"Local" /C:"error" /C:"Error""

REM Wait for server to be ready (check every 2 seconds)
echo   [WAIT] Waiting for server to be ready...
set attempts=0
:wait_loop
timeout /t 2 /nobreak >nul
set /a attempts+=1

REM Try to connect to the server
powershell -Command "$ErrorActionPreference='SilentlyContinue'; try { $response = Invoke-WebRequest -Uri 'http://localhost:3000' -TimeoutSec 1 -UseBasicParsing; if ($response.StatusCode -eq 200) { exit 0 } else { exit 1 } } catch { exit 1 }" >nul 2>&1

if %ERRORLEVEL% EQU 0 (
    echo   [SUCCESS] Server is ready!
    echo   [OPEN] Opening browser...
    timeout /t 1 /nobreak >nul
    start http://localhost:3000
    echo.
    echo   ╔═══════════════════════════════════════╗
    echo   ║   SERVER IS RUNNING!                  ║
    echo   ║                                       ║
    echo   ║   URL: http://localhost:3000         ║
    echo   ║   Browser opened automatically        ║
    echo   ╚═══════════════════════════════════════╝
    echo.
    echo   Server window is open separately.
    echo   Close that window to stop the server.
    echo.
    echo   Press any key to close this window...
    pause >nul
    exit /b 0
)

REM Check if we've waited too long (60 seconds = 30 attempts)
if %attempts% GTR 30 (
    echo   [WARNING] Server is taking longer than expected...
    echo   [INFO] Opening browser anyway - server may still be starting
    start http://localhost:3000
    echo.
    echo   If you see an error, wait 10 more seconds and refresh.
    echo   Check the server window for status.
    echo.
    pause
    exit /b 0
)

goto wait_loop
