@echo off
title AI Astrologer - Fix Connection Error
color 0C
cls

echo.
echo   ╔═══════════════════════════════════════╗
echo   ║   FIX CONNECTION ERROR               ║
echo   ╚═══════════════════════════════════════╝
echo.
echo   This will fix the "ERR_CONNECTION_REFUSED" error
echo.

REM Port Selection
echo   [STEP 1] Select which port you want to use:
echo.
echo   1. Port 3000 (Default - Recommended)
echo   2. Port 8080 (Alternative)
echo.
set /p port_choice="Enter your choice (1 or 2): "

if "%port_choice%"=="1" (
    set SERVER_PORT=3000
    set NPM_SCRIPT=dev
) else if "%port_choice%"=="2" (
    set SERVER_PORT=8080
    set NPM_SCRIPT=dev:8080
) else (
    echo   [INFO] Invalid choice. Using port 3000 (default)
    set SERVER_PORT=3000
    set NPM_SCRIPT=dev
)

cls
echo.
echo   ╔═══════════════════════════════════════╗
echo   ║   FIXING CONNECTION ERROR              ║
echo   ║   Port: %SERVER_PORT%                          ║
echo   ╚═══════════════════════════════════════╝
echo.

REM Close browser tabs first
echo   [STEP 2] Close any browser tabs with localhost errors
echo   Press any key after closing browser tabs...
pause >nul
cls

echo.
echo   [STEP 3] Stopping any existing servers...
echo.

REM Kill any existing Node processes
taskkill /F /IM node.exe >nul 2>&1
timeout /t 2 /nobreak >nul

REM Kill processes on specific port
for /f "tokens=5" %%a in ('netstat -ano ^| find "%SERVER_PORT%" ^| find "LISTENING"') do (
    taskkill /F /PID %%a >nul 2>&1
)

echo   [OK] Existing servers stopped
echo.

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   [ERROR] Node.js not installed!
    echo   Install from: https://nodejs.org
    pause
    exit /b 1
)

echo   [STEP 4] Checking dependencies...
echo.

if not exist "node_modules" (
    echo   [INFO] Installing dependencies (2-3 minutes)...
    call npm install
)

echo   [OK] Dependencies ready
echo.

if not exist ".env.local" (
    if exist ".env.example" (
        copy ".env.example" ".env.local" >nul
    )
)

echo   [STEP 5] Starting server on port %SERVER_PORT%...
echo.
echo   Please wait - do NOT open browser yet!
echo.

REM Start server
start "AI Astrologer Server - Port %SERVER_PORT%" cmd /c "npm run %NPM_SCRIPT%"

echo   [WAIT] Server is starting...
echo   [WAIT] Checking if server is ready...
echo.

set attempts=0
:check
timeout /t 2 /nobreak >nul
set /a attempts+=1

REM Display progress
if %attempts% LEQ 5 echo   [WAIT] Compiling application... ^(%attempts%/30^)
if %attempts% GTR 5 if %attempts% LEQ 10 echo   [WAIT] Almost ready... ^(%attempts%/30^)
if %attempts% GTR 10 echo   [WAIT] Starting up... ^(%attempts%/30^)

REM Check if server responds
curl -s http://localhost:%SERVER_PORT% >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    cls
    echo.
    echo   ╔═══════════════════════════════════════╗
    echo   ║   ✓ ERROR FIXED!                     ║
    echo   ║   ✓ SERVER IS READY!                 ║
    echo   ╚═══════════════════════════════════════╝
    echo.
    echo   Opening browser in 3 seconds...
    timeout /t 3 /nobreak >nul
    start http://localhost:%SERVER_PORT%
    echo.
    echo   ✓ Application running at: http://localhost:%SERVER_PORT%
    echo   ✓ Browser opened - NO ERRORS!
    echo.
    echo   Server is running in the other window.
    echo   Keep that window open.
    echo.
    echo   Press any key to close this window...
    pause >nul
    exit /b 0
)

if %attempts% GEQ 30 (
    echo.
    echo   [WARNING] Taking longer than expected...
    echo   [INFO] Opening browser - please wait if error appears
    start http://localhost:%SERVER_PORT%
    echo.
    echo   If you still see an error:
    echo   1. Wait 10 more seconds
    echo   2. Press F5 to refresh
    echo   3. Check the server window
    echo.
    pause
    exit /b 0
)

goto check

