@echo off
title AI Astrologer - Fix Connection Error NOW
color 0C
cls

echo.
echo   ╔═══════════════════════════════════════════════════╗
echo   ║   FIX CONNECTION ERROR - IMMEDIATE RESOLUTION    ║
echo   ╚═══════════════════════════════════════════════════╝
echo.
echo   This will fix the "ERR_CONNECTION_REFUSED" error
echo   by starting the server and waiting for it to be ready.
echo.

REM Step 1: Port Selection
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
echo   ╔═══════════════════════════════════════════════════╗
echo   ║   FIXING CONNECTION ERROR                         ║
echo   ║   Port: %SERVER_PORT%                                    ║
echo   ╚═══════════════════════════════════════════════════╝
echo.

REM Step 2: Close browser tabs
echo   [STEP 2] Please close any browser tabs showing the error
echo   Press any key after closing browser tabs...
pause >nul
cls

echo.
echo   [STEP 3] Stopping any existing servers...
echo.

REM Kill any existing Node.js processes
taskkill /F /IM node.exe >nul 2>&1
timeout /t 2 /nobreak >nul

REM Kill processes on specific port
for /f "tokens=5" %%a in ('netstat -ano ^| find "%SERVER_PORT%" ^| find "LISTENING"') do (
    taskkill /F /PID %%a >nul 2>&1
)

echo   [OK] Existing servers stopped
echo.

REM Step 3: Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   [ERROR] Node.js is not installed!
    echo   Please install Node.js 18+ from: https://nodejs.org
    echo   After installation, run this script again.
    echo.
    pause
    exit /b 1
)

echo   [CHECK] Node.js version:
node --version
echo.

REM Step 4: Install dependencies
echo   [STEP 4] Checking dependencies...
echo.

if not exist "node_modules" (
    echo   [INFO] Installing dependencies (this may take 2-3 minutes)...
    echo   Please wait...
    echo.
    call npm install
    if %ERRORLEVEL% NEQ 0 (
        echo   [ERROR] Failed to install dependencies
        echo   Please check your internet connection and try again
        pause
        exit /b 1
    )
    echo   [SUCCESS] Dependencies installed!
    echo.
) else (
    echo   [OK] Dependencies already installed
    echo.
)

REM Step 5: Environment setup
if not exist ".env.local" (
    if exist ".env.example" (
        copy ".env.example" ".env.local" >nul
        echo   [OK] Environment file created
    )
)

REM Step 6: Start server
echo   [STEP 5] Starting server on port %SERVER_PORT%...
echo.
echo   [IMPORTANT] Do NOT open browser manually!
echo   [IMPORTANT] Wait for "SERVER READY" message
echo.

REM Start server in separate window
start "AI Astrologer Server - Port %SERVER_PORT%" cmd /k "npm run %NPM_SCRIPT%"

echo   [WAIT] Server is starting...
echo   [WAIT] Checking if server is ready...
echo   [INFO] This may take 10-20 seconds for first compilation
echo.

REM Step 7: Wait for server to be ready
set attempts=0
set max_attempts=45

:check_server
timeout /t 2 /nobreak >nul
set /a attempts+=1

REM Display progress
if %attempts% LEQ 5 (
    echo   [WAIT] Compiling application... ^(%attempts%/%max_attempts%^)
) else if %attempts% LEQ 15 (
    echo   [WAIT] Building components... ^(%attempts%/%max_attempts%^)
) else if %attempts% LEQ 25 (
    echo   [WAIT] Almost ready... ^(%attempts%/%max_attempts%^)
) else (
    echo   [WAIT] Finalizing... ^(%attempts%/%max_attempts%^)
)

REM Check if server responds
curl -s http://localhost:%SERVER_PORT% >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    REM Server is ready!
    cls
    echo.
    echo   ╔═══════════════════════════════════════════════════╗
    echo   ║   ✓ ERROR FIXED!                                 ║
    echo   ║   ✓ SERVER IS READY!                             ║
    echo   ╚═══════════════════════════════════════════════════╝
    echo.
    echo   [SUCCESS] Server is responding on port %SERVER_PORT%
    echo   [OPEN] Opening browser in 3 seconds...
    echo.
    timeout /t 3 /nobreak >nul
    start http://localhost:%SERVER_PORT%
    echo.
    echo   ╔═══════════════════════════════════════════════════╗
    echo   ║   APPLICATION RUNNING                            ║
    echo   ╚═══════════════════════════════════════════════════╝
    echo.
    echo   ✓ URL: http://localhost:%SERVER_PORT%
    echo   ✓ Browser opened automatically
    echo   ✓ NO MORE ERRORS!
    echo.
    echo   Server is running in the "AI Astrologer Server" window.
    echo   Keep that window open while using the application.
    echo.
    echo   To stop: Close the server window or press Ctrl+C in it.
    echo.
    echo   Press any key to close this window...
    pause >nul
    exit /b 0
)

REM Check if we've waited too long
if %attempts% GEQ %max_attempts% (
    echo.
    echo   [WARNING] Server is taking longer than expected
    echo   [INFO] Opening browser anyway - server may still be starting
    echo.
    start http://localhost:%SERVER_PORT%
    echo.
    echo   If you still see an error in the browser:
    echo   1. Wait 10-20 more seconds
    echo   2. Press F5 to refresh the page
    echo   3. Check the "AI Astrologer Server" window for status
    echo   4. Look for "Ready" message in that window
    echo.
    echo   Server window is open - check it for details.
    echo.
    pause
    exit /b 0
)

goto check_server
