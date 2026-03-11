@echo off
title Run Server - Port 8080
color 0A
cls

echo.
echo   ═══════════════════════════════════════
echo   STARTING SERVER ON PORT 8080
echo   ═══════════════════════════════════════
echo.

REM Kill all Node processes
echo   Stopping old servers...
taskkill /F /IM node.exe >nul 2>&1
timeout /t 2 /nobreak >nul

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   ERROR: Node.js not installed!
    pause
    exit /b 1
)

REM Install dependencies
if not exist "node_modules" (
    echo   Installing dependencies...
    call npm install
)

REM Start server
echo   Starting server...
echo   Server window will open - KEEP IT OPEN!
echo.
start "AI Astrologer Server" cmd /k "npm run dev:8080"

REM Wait and check
echo   Waiting for server to start...
set count=0
:wait
timeout /t 2 /nobreak >nul
set /a count+=1

REM Check if server is listening on port 8080
netstat -ano | find "8080" | find "LISTENING" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    REM Also verify it responds
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
        echo   Server: http://localhost:8080
        echo   Keep server window open!
        pause
        exit /b 0
    )
)

if %count% LEQ 10 (
    echo   Starting... ^(%count%/30^)
) else if %count% LEQ 20 (
    echo   Compiling... ^(%count%/30^)
) else (
    echo   Almost ready... ^(%count%/30^)
)

if %count% GEQ 30 (
    echo.
    echo   Opening browser...
    start http://localhost:8080
    echo   If error, wait 10 seconds and refresh (F5)
    pause
    exit /b 0
)

goto wait
