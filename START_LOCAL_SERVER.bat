@echo off
title Start Local Server - Port 8080
color 0B
cls

echo.
echo   ═══════════════════════════════════════
echo   STARTING LOCAL SERVER
echo   ═══════════════════════════════════════
echo.

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   ERROR: Node.js not installed!
    echo   Get it from: https://nodejs.org
    pause
    exit /b 1
)

REM Install dependencies
if not exist "node_modules" (
    echo   Installing dependencies...
    call npm install
)

REM Stop old servers
taskkill /F /IM node.exe >nul 2>&1

REM Start server
echo   Starting server on port 8080...
start "AI Astrologer Server" cmd /k "echo AI Astrologer Server && echo Port: 8080 && echo. && npm run dev:8080"

echo.
echo   ═══════════════════════════════════════
echo   SERVER STARTED!
echo   ═══════════════════════════════════════
echo.
echo   Server URL: http://localhost:8080
echo.
echo   Wait 10-20 seconds for server to be ready,
echo   then open the URL in your browser.
echo.
echo   Keep the server window open!
echo.
pause
