@echo off
title AI Astrologer - Port 8080 (Fixed)
color 0A
cls

echo.
echo   ╔═══════════════════════════════════════╗
echo   ║   STARTING SERVER ON PORT 8080      ║
echo   ╚═══════════════════════════════════════╝
echo.

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   [ERROR] Node.js not found!
    echo   Install from: https://nodejs.org
    pause
    exit /b 1
)

echo   [CHECK] Node.js: 
node --version
echo.

REM Install dependencies if needed
if not exist "node_modules" (
    echo   [SETUP] Installing dependencies...
    call npm install
    if %ERRORLEVEL% NEQ 0 (
        echo   [ERROR] Installation failed!
        pause
        exit /b 1
    )
)

REM Environment file
if not exist ".env.local" (
    if exist ".env.example" (
        copy ".env.example" ".env.local" >nul
    )
)

REM Kill any existing process on port 8080
echo   [CLEANUP] Checking for existing servers...
for /f "tokens=5" %%a in ('netstat -ano ^| find "8080" ^| find "LISTENING"') do (
    echo   [INFO] Stopping existing server on port 8080...
    taskkill /F /PID %%a >nul 2>&1
)

echo.
echo   [START] Starting server on port 8080...
echo   [INFO] Server window will open separately
echo   [INFO] Keep that window open!
echo.

REM Start server in a window that stays open (using /k instead of /c)
start "AI Astrologer Server - Port 8080" cmd /k "echo Starting Next.js server on port 8080... && npm run dev:8080"

echo   [WAIT] Waiting for server to start...
echo   [INFO] This may take 10-20 seconds
echo.

REM Wait and check if server is ready
set attempts=0
:wait_loop
timeout /t 2 /nobreak >nul
set /a attempts+=1

REM Check if server responds
curl -s http://localhost:8080 >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   [SUCCESS] Server is ready!
    echo   [OPEN] Opening browser...
    timeout /t 1 /nobreak >nul
    start http://localhost:8080
    echo.
    echo   ╔═══════════════════════════════════════╗
    echo   ║   SERVER RUNNING!                    ║
    echo   ║   URL: http://localhost:8080         ║
    echo   ╚═══════════════════════════════════════╝
    echo.
    echo   Browser opened automatically.
    echo   Server is running in the other window.
    echo   Keep that window open!
    echo.
    pause
    exit /b 0
)

REM Show progress
if %attempts% LEQ 10 (
    echo   [WAIT] Starting... ^(%attempts%/30^)
) else if %attempts% LEQ 20 (
    echo   [WAIT] Compiling... ^(%attempts%/30^)
) else (
    echo   [WAIT] Almost ready... ^(%attempts%/30^)
)

if %attempts% GEQ 30 (
    echo.
    echo   [WARNING] Server taking longer than expected
    echo   [INFO] Opening browser anyway...
    echo   [INFO] If error appears, wait 10 seconds and refresh
    start http://localhost:8080
    echo.
    echo   Check the server window for status.
    echo   Look for "Ready" or error messages there.
    echo.
    pause
    exit /b 0
)

goto wait_loop
