@echo off
title Run Local Server
color 0A

echo.
echo   Starting local server...
echo.

REM Stop existing
taskkill /F /IM node.exe >nul 2>&1

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   ERROR: Node.js not installed!
    pause
    exit /b 1
)

REM Install if needed
if not exist "node_modules" call npm install

REM Start server
start "AI Astrologer Server" cmd /k "npm run dev:8080"

echo   Server starting on port 8080...
echo   URL: http://localhost:8080
echo.
echo   Wait 10-20 seconds, then open the URL in your browser.
echo   Keep the server window open!
echo.
pause
