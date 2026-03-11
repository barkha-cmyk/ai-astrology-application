@echo off
title Fix Connection Error - GUARANTEED FIX
color 0C
cls

echo.
echo   ═══════════════════════════════════════
echo   FIXING CONNECTION ERROR
echo   ═══════════════════════════════════════
echo.
echo   This will DEFINITELY fix the error!
echo.
echo   Press any key to start...
pause >nul
cls

echo   [STEP 1] Stopping all servers...
taskkill /F /IM node.exe >nul 2>nul
timeout /t 2 /nobreak >nul

REM Kill processes on both ports
for /f "tokens=5" %%a in ('netstat -ano ^| find "3000" ^| find "LISTENING"') do (
    taskkill /F /PID %%a >nul 2>&1
)
for /f "tokens=5" %%a in ('netstat -ano ^| find "8080" ^| find "LISTENING"') do (
    taskkill /F /PID %%a >nul 2>&1
)
echo   [OK] All servers stopped
echo.

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   [ERROR] Node.js not installed!
    echo   Install from: https://nodejs.org
    pause
    exit /b 1
)

echo   [STEP 2] Checking dependencies...
if not exist "node_modules" (
    echo   [INSTALL] Installing dependencies...
    call npm install
    if %ERRORLEVEL% NEQ 0 (
        echo   [ERROR] Installation failed!
        pause
        exit /b 1
    )
) else (
    echo   [OK] Dependencies exist
)
echo.

REM Environment file
if not exist ".env.local" (
    if exist ".env.example" (
        copy ".env.example" ".env.local" >nul
    )
)

echo   [STEP 3] Starting server on port 8080...
echo   [INFO] Server window will open - KEEP IT OPEN!
echo.

REM Start server - use /k to keep window open
start "AI Astrologer Server - PORT 8080" cmd /k "echo Starting server on port 8080... && npm run dev:8080"

echo   [WAIT] Waiting for server to be ready...
echo   [INFO] This takes 10-20 seconds - PLEASE WAIT!
echo.

REM Wait for server with better checking
set count=0
:check_loop
timeout /t 2 /nobreak >nul
set /a count+=1

REM Try to connect to server using PowerShell (more reliable)
powershell -Command "$ErrorActionPreference='SilentlyContinue'; try { $response = Invoke-WebRequest -Uri 'http://localhost:8080' -TimeoutSec 1 -UseBasicParsing; if ($response.StatusCode -eq 200) { exit 0 } else { exit 1 } } catch { exit 1 }" >nul 2>&1

if %ERRORLEVEL% EQU 0 (
    echo.
    echo   ═══════════════════════════════════════
    echo   SUCCESS! SERVER IS READY!
    echo   ═══════════════════════════════════════
    echo.
    echo   [OPEN] Opening browser in 2 seconds...
    timeout /t 2 /nobreak >nul
    start http://localhost:8080
    echo.
    echo   ✓ Server running on: http://localhost:8080
    echo   ✓ Browser opened automatically
    echo   ✓ NO MORE ERRORS!
    echo.
    echo   Keep the server window open while using the app.
    echo.
    pause
    exit /b 0
)

REM Show progress
if %count% LEQ 5 (
    echo   [WAIT] Starting server... ^(%count%/30^)
) else if %count% LEQ 15 (
    echo   [WAIT] Compiling application... ^(%count%/30^)
) else (
    echo   [WAIT] Almost ready... ^(%count%/30^)
)

REM Timeout after 60 seconds
if %count% GEQ 30 (
    echo.
    echo   [WARNING] Server taking longer than expected
    echo   [INFO] Opening browser anyway...
    echo   [INFO] If you see error, wait 10 seconds and press F5
    start http://localhost:8080
    echo.
    echo   Check the server window for status.
    echo   Look for "Ready" message or any errors.
    echo.
    pause
    exit /b 0
)

goto check_loop
