@echo off
title AI Astrologer - Server Port 8080
color 0A
cls

echo.
echo   ╔═══════════════════════════════════════╗
echo   ║   AI ASTROLOGER - Port 8080          ║
echo   ╚═══════════════════════════════════════╝
echo.

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   [ERROR] Node.js not found!
    pause
    exit /b 1
)

REM Install if needed
if not exist "node_modules" (
    echo   [SETUP] Installing dependencies...
    call npm install
    echo.
)

REM Environment
if not exist ".env.local" (
    if exist ".env.example" (
        copy ".env.example" ".env.local" >nul
    )
)

echo   [START] Starting server on port 8080...
echo   [INFO] Server URL: http://localhost:8080
echo.

REM Start server
start "AI Astrologer Server (8080)" cmd /k "npm run dev:8080 2>&1 | findstr /C:"Ready" /C:"Local" /C:"error" /C:"Error""

REM Wait and check
echo   [WAIT] Waiting for server...
set attempts=0
:wait_loop
timeout /t 2 /nobreak >nul
set /a attempts+=1

powershell -Command "$ErrorActionPreference='SilentlyContinue'; try { $response = Invoke-WebRequest -Uri 'http://localhost:8080' -TimeoutSec 1 -UseBasicParsing; if ($response.StatusCode -eq 200) { exit 0 } else { exit 1 } } catch { exit 1 }" >nul 2>&1

if %ERRORLEVEL% EQU 0 (
    echo   [SUCCESS] Server ready!
    start http://localhost:8080
    echo.
    echo   Server running at http://localhost:8080
    echo   Browser opened automatically
    echo.
    pause
    exit /b 0
)

if %attempts% GTR 30 (
    echo   [INFO] Opening browser (server may still be starting)...
    start http://localhost:8080
    echo   If error appears, wait 10 seconds and refresh.
    pause
    exit /b 0
)

goto wait_loop
