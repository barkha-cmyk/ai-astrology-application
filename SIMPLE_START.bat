@echo off
title AI Astrologer - Simple Start
color 0A
cls

echo.
echo   ═══════════════════════════════════════
echo   AI ASTROLOGER - SIMPLE START
echo   ═══════════════════════════════════════
echo.
echo   This will start everything correctly.
echo.
echo   Press any key to begin...
pause >nul
cls

REM Stop existing servers
taskkill /F /IM node.exe >nul 2>&1

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   ERROR: Install Node.js from https://nodejs.org
    pause
    exit /b 1
)

REM Install if needed
if not exist "node_modules" (
    echo   Installing dependencies...
    call npm install
)

if not exist ".env.local" (
    if exist ".env.example" copy ".env.example" ".env.local" >nul
)

echo.
echo   Starting server...
echo   DO NOT open browser manually!
echo.

REM Start server
start /MIN "AI Astrologer" cmd /c "npm run dev"

REM Wait for server
set attempts=0
:wait
timeout /t 2 /nobreak >nul
set /a attempts+=1
curl -s http://localhost:3000 >nul 2>&1
if %ERRORLEVEL% EQU 0 goto ready
if %attempts% LSS 30 goto wait

:ready
echo   Server ready! Opening browser...
timeout /t 2 /nobreak >nul
start http://localhost:3000

echo.
echo   ═══════════════════════════════════════
echo   Application running!
echo   URL: http://localhost:3000
echo   ═══════════════════════════════════════
echo.
pause
