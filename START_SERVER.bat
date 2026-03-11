@echo off
title Start Server
color 0A

REM Stop existing servers
taskkill /F /IM node.exe >nul 2>&1

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Node.js not installed!
    pause
    exit /b 1
)

REM Install if needed
if not exist "node_modules" call npm install

REM Start server
start "Server" cmd /k "npm run dev:8080"

echo Server starting on port 8080...
echo Wait 10-20 seconds, then open: http://localhost:8080
pause
