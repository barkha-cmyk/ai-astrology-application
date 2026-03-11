@echo off
title Start Server NOW - Port 8080
color 0A
cls

echo.
echo   ═══════════════════════════════════════
echo   STARTING SERVER ON PORT 8080
echo   ═══════════════════════════════════════
echo.

REM Stop everything first
echo   [1] Stopping old servers...
taskkill /F /IM node.exe >nul 2>&1
timeout /t 1 /nobreak >nul
echo   ✓ Done
echo.

REM Check Node.js
echo   [2] Checking Node.js...
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   ✗ Node.js not found!
    echo   Install from: https://nodejs.org
    pause
    exit /b 1
)
echo   ✓ Node.js OK
echo.

REM Install dependencies
echo   [3] Checking dependencies...
if not exist "node_modules" (
    echo   Installing dependencies (first time - 2-3 min)...
    call npm install
) else (
    echo   ✓ Dependencies exist
)
echo.

REM Start server
echo   [4] Starting server...
echo   Server window will open - KEEP IT OPEN!
echo.
start "AI Astrologer Server" cmd /k "npm run dev:8080"

REM Wait for server
echo   [5] Waiting for server to be ready...
echo   This takes 10-20 seconds...
echo.

set tries=0
:check
timeout /t 2 /nobreak >nul
set /a tries+=1

curl -s http://localhost:8080 >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo.
    echo   ═══════════════════════════════════════
    echo   ✓ SERVER IS RUNNING!
    echo   ═══════════════════════════════════════
    echo.
    echo   Opening browser...
    start http://localhost:8080
    echo.
    echo   ✓ Server: http://localhost:8080
    echo   ✓ Browser opened
    echo   ✓ Keep server window open!
    echo.
    pause
    exit /b 0
)

if %tries% LEQ 10 (
    echo   Waiting... ^(%tries%/25^)
) else if %tries% LEQ 20 (
    echo   Still starting... ^(%tries%/25^)
) else (
    echo   Almost ready... ^(%tries%/25^)
)

if %tries% GEQ 25 (
    echo.
    echo   Opening browser (server may still be starting)...
    start http://localhost:8080
    echo   If error, wait 10 seconds and refresh (F5)
    pause
    exit /b 0
)

goto check
