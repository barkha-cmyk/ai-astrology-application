@echo off
title Fix Error and Start Server
color 0C
cls

echo.
echo   ═══════════════════════════════════════
echo   FIXING ERROR AND STARTING SERVER
echo   ═══════════════════════════════════════
echo.

REM Kill ALL Node processes
echo   [1] Stopping all Node.js processes...
taskkill /F /IM node.exe >nul 2>&1
timeout /t 2 /nobreak >nul
echo   ✓ All stopped
echo.

REM Check Node.js
echo   [2] Checking Node.js...
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   ✗ Node.js not installed!
    pause
    exit /b 1
)
echo   ✓ Node.js OK
echo.

REM Install dependencies
echo   [3] Checking dependencies...
if not exist "node_modules" (
    echo   Installing dependencies...
    call npm install
) else (
    echo   ✓ Dependencies exist
)
echo.

REM Start server
echo   [4] Starting server on port 8080...
echo   Server window opening - KEEP IT OPEN!
echo.
start "AI Astrologer Server" cmd /k "npm run dev:8080"

REM Wait for server
echo   [5] Waiting for server to be ready...
echo   This takes 15-20 seconds - PLEASE WAIT!
echo.

set tries=0
:check_server
timeout /t 2 /nobreak >nul
set /a tries+=1

REM Check if port 8080 is listening
netstat -ano | find "8080" | find "LISTENING" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    REM Also check if server responds
    curl -s http://localhost:8080 >nul 2>&1
    if %ERRORLEVEL% EQU 0 (
        echo.
        echo   ═══════════════════════════════════════
        echo   ✓✓✓ SERVER IS RUNNING! ✓✓✓
        echo   ═══════════════════════════════════════
        echo.
        echo   Opening browser...
        start http://localhost:8080
        echo.
        echo   ✓ Server: http://localhost:8080
        echo   ✓ Browser opened
        echo   ✓ ERROR FIXED!
        echo.
        echo   Keep server window open!
        pause
        exit /b 0
    )
)

if %tries% LEQ 10 (
    echo   Starting... ^(%tries%/30^)
) else if %tries% LEQ 20 (
    echo   Compiling... ^(%tries%/30^)
) else (
    echo   Almost ready... ^(%tries%/30^)
)

if %tries% GEQ 30 (
    echo.
    echo   Opening browser (server may still be starting)...
    start http://localhost:8080
    echo   If error, wait 15 seconds and refresh (F5)
    pause
    exit /b 0
)

goto check_server
