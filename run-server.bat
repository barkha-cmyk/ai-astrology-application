@echo off
title AI Astrologer - Local Server
color 0A
cls

echo.
echo ========================================
echo   AI ASTROLOGER - LOCAL SERVER
echo   Starting automatically...
echo ========================================
echo.

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Node.js not found. Please install Node.js 18+
    pause
    exit /b 1
)

REM Install dependencies if needed
if not exist "node_modules" (
    echo [SETUP] Installing dependencies...
    call npm install
    if %ERRORLEVEL% NEQ 0 (
        echo [ERROR] Installation failed
        pause
        exit /b 1
    )
)

REM Create .env.local if missing
if not exist ".env.local" (
    if exist ".env.example" (
        copy ".env.example" ".env.local" >nul
    )
)

echo.
echo [INFO] Starting local server on port 3000...
echo [INFO] Server URL: http://localhost:3000
echo.
echo Please wait for "Ready" message...
echo Browser will open automatically when server is ready.
echo.

REM Start server and wait for it to be ready, then open browser
start /B cmd /c "npm run dev > server.log 2>&1"

REM Wait and check if server is ready
echo [WAIT] Waiting for server to start...
timeout /t 5 /nobreak >nul

:check
REM Try to check if server is responding
powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://localhost:3000' -TimeoutSec 2 -UseBasicParsing -ErrorAction Stop; exit 0 } catch { exit 1 }" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [SUCCESS] Server is ready!
    echo [INFO] Opening browser...
    start http://localhost:3000
    echo.
    echo ========================================
    echo   Server is running!
    echo   Access at: http://localhost:3000
    echo   Press Ctrl+C to stop
    echo ========================================
    echo.
    REM Keep window open and show server output
    type server.log
    goto end
)

REM Check if 15 seconds have passed
set /a count+=1
if %count% GTR 30 (
    echo [WARNING] Server taking longer than expected...
    echo [INFO] Trying to open browser anyway...
    start http://localhost:3000
    echo.
    echo Server may still be starting. Please wait...
    type server.log
    goto end
)

timeout /t 1 /nobreak >nul
goto check

:end
REM Keep server running
timeout /t 3600
