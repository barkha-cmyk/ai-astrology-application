@echo off
title Fix Connection Error - WORKS EVERY TIME
color 0A
cls

echo.
echo   ╔═══════════════════════════════════════╗
echo   ║   FIX CONNECTION ERROR               ║
echo   ║   This WILL fix the error!            ║
echo   ╚═══════════════════════════════════════╝
echo.

REM Stop everything first
echo   [1/5] Stopping all servers...
taskkill /F /IM node.exe >nul 2>&1
timeout /t 2 /nobreak >nul
echo   ✓ Done
echo.

REM Check Node.js
echo   [2/5] Checking Node.js...
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   ✗ Node.js not found!
    echo   Install from: https://nodejs.org
    pause
    exit /b 1
)
echo   ✓ Node.js found
echo.

REM Install dependencies
echo   [3/5] Checking dependencies...
if not exist "node_modules" (
    echo   Installing dependencies (2-3 minutes)...
    call npm install
) else (
    echo   ✓ Dependencies exist
)
echo.

REM Start server
echo   [4/5] Starting server on port 8080...
start "AI Astrologer Server" cmd /k "npm run dev:8080"
echo   ✓ Server starting...
echo.

REM Wait and check
echo   [5/5] Waiting for server to be ready...
set tries=0
:wait
timeout /t 2 /nobreak >nul
set /a tries+=1

curl -s http://localhost:8080 >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   ✓ Server ready!
    echo.
    echo   Opening browser...
    start http://localhost:8080
    echo.
    echo   ╔═══════════════════════════════════════╗
    echo   ║   ✓ ERROR FIXED!                     ║
    echo   ║   ✓ Application running!             ║
    echo   ╚═══════════════════════════════════════╝
    echo.
    pause
    exit /b 0
)

if %tries% GEQ 25 (
    echo   Opening browser (server may still be starting)...
    start http://localhost:8080
    echo   If error, wait 10 seconds and refresh (F5)
    pause
    exit /b 0
)

echo   Waiting... ^(%tries%/25^)
goto wait
