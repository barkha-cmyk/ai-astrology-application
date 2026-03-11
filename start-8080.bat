@echo off
title AI Astrologer - Port 8080
color 0D
cls

echo.
echo   ╔═══════════════════════════════════════╗
echo   ║   AI ASTROLOGER - PORT 8080          ║
echo   ╚═══════════════════════════════════════╝
echo.

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   [ERROR] Node.js not found!
    echo   Install from: https://nodejs.org
    pause
    exit /b 1
)

REM Install dependencies
if not exist "node_modules" (
    echo   [SETUP] Installing dependencies...
    call npm install
)

REM Environment
if not exist ".env.local" (
    if exist ".env.example" (
        copy ".env.example" ".env.local" >nul
    )
)

echo   [START] Starting server on port 8080...
echo.

REM Kill existing process on port 8080
for /f "tokens=5" %%a in ('netstat -ano ^| find "8080" ^| find "LISTENING"') do (
    taskkill /F /PID %%a >nul 2>&1
)

REM Start server
start "AI Astrologer Server - Port 8080" cmd /k "npm run dev:8080"

echo   [WAIT] Waiting for server to be ready...
set attempts=0

:wait_8080
timeout /t 2 /nobreak >nul
set /a attempts+=1

curl -s http://localhost:8080 >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   [SUCCESS] Server ready!
    echo   [OPEN] Opening browser...
    start http://localhost:8080
    echo.
    echo   Application running at: http://localhost:8080
    echo.
    pause
    exit /b 0
)

if %attempts% GEQ 30 (
    echo   [INFO] Opening browser (server may still be starting)...
    start http://localhost:8080
    echo   Wait 10 seconds and refresh if needed.
    pause
    exit /b 0
)

goto wait_8080
