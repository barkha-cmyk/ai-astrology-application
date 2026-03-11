@echo off
title Quick Fix - Connection Error
color 0C

REM Stop everything
taskkill /F /IM node.exe >nul 2>&1
timeout /t 1 /nobreak >nul

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Node.js not installed! Get it from https://nodejs.org
    pause
    exit /b 1
)

REM Install if needed
if not exist "node_modules" call npm install

REM Start server
start "Server" cmd /k "npm run dev:8080"

REM Wait for server
echo Waiting for server...
set c=0
:loop
timeout /t 2 /nobreak >nul
set /a c+=1
curl -s http://localhost:8080 >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Server ready! Opening browser...
    start http://localhost:8080
    pause
    exit
)
if %c% GEQ 25 (
    start http://localhost:8080
    echo If error, wait 10 seconds and refresh
    pause
    exit
)
goto loop
