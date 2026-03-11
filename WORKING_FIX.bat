@echo off
title WORKING FIX - This Will Work!
color 0A
cls

echo.
echo   ╔═══════════════════════════════════════╗
echo   ║   FIXING CONNECTION ERROR            ║
echo   ║   This WILL work!                     ║
echo   ╚═══════════════════════════════════════╝
echo.
echo   Close browser tab with error FIRST!
echo   Press any key to continue...
pause >nul
cls

echo   [STEP 1] Stopping all Node.js processes...
taskkill /F /IM node.exe >nul 2>&1
timeout /t 2 /nobreak >nul
echo   ✓ All stopped
echo.

echo   [STEP 2] Checking Node.js...
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   ✗ ERROR: Node.js not installed!
    echo   Download from: https://nodejs.org
    pause
    exit /b 1
)
node --version
echo   ✓ Node.js OK
echo.

echo   [STEP 3] Installing dependencies if needed...
if not exist "node_modules" (
    echo   Installing (first time - 2-3 minutes)...
    call npm install
    if %ERRORLEVEL% NEQ 0 (
        echo   ✗ Installation failed!
        pause
        exit /b 1
    )
) else (
    echo   ✓ Dependencies exist
)
echo.

echo   [STEP 4] Starting server on port 8080...
echo   IMPORTANT: Server window will open - DO NOT CLOSE IT!
echo.
start "AI Astrologer Server" cmd /k "title AI Astrologer Server && echo Starting server on port 8080... && echo. && npm run dev:8080"

echo   [STEP 5] Waiting for server...
echo   Please wait 15-20 seconds...
echo.

REM Wait up to 30 attempts (60 seconds)
set count=0
:wait
timeout /t 2 /nobreak >nul
set /a count+=1

REM Check if server responds
curl -s http://localhost:8080 >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo.
    echo   ╔═══════════════════════════════════════╗
    echo   ║   ✓✓✓ SUCCESS! SERVER RUNNING! ✓✓✓  ║
    echo   ╚═══════════════════════════════════════╝
    echo.
    echo   Opening browser in 2 seconds...
    timeout /t 2 /nobreak >nul
    start http://localhost:8080
    echo.
    echo   ✓ Server: http://localhost:8080
    echo   ✓ Browser opened
    echo   ✓ ERROR FIXED!
    echo.
    echo   Keep server window open!
    echo.
    pause
    exit /b 0
)

REM Show progress
if %count% LEQ 10 (
    echo   Waiting... ^(%count%/30^)
) else if %count% LEQ 20 (
    echo   Still starting... ^(%count%/30^)
) else (
    echo   Almost ready... ^(%count%/30^)
)

if %count% GEQ 30 (
    echo.
    echo   Server taking longer - opening browser anyway...
    start http://localhost:8080
    echo   If error, wait 15 seconds and refresh (F5)
    echo   Check server window for status
    pause
    exit /b 0
)

goto wait
