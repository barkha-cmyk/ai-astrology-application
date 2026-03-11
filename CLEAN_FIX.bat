@echo off
title Fix Connection Error - Clean Solution
color 0A
cls

echo.
echo   Fixing connection error...
echo.

REM Stop all Node processes
taskkill /F /IM node.exe >nul 2>&1
timeout /t 1 /nobreak >nul

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   ERROR: Node.js not installed!
    pause
    exit /b 1
)

REM Install dependencies if needed
if not exist "node_modules" (
    echo   Installing dependencies...
    call npm install
)

REM Start server
echo   Starting server on port 8080...
start "Server" cmd /k "npm run dev:8080"

REM Wait for server
echo   Waiting for server to start...
set count=0
:wait
timeout /t 2 /nobreak >nul
set /a count+=1
curl -s http://localhost:8080 >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   Server ready! Opening browser...
    start http://localhost:8080
    echo   Done!
    pause
    exit
)
if %count% GEQ 25 (
    start http://localhost:8080
    echo   If error, wait 10 seconds and refresh
    pause
    exit
)
goto wait
