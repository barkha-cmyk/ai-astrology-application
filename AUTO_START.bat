@echo off
title AI Astrologer - Auto Start
color 0A
cls

echo.
echo   ╔═══════════════════════════════════════════════════╗
echo   ║   AI ASTROLOGER - AUTO START                     ║
echo   ╚═══════════════════════════════════════════════════╝
echo.

REM Check if already running
curl -s http://localhost:3000 >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   [INFO] Server already running on port 3000
    echo   [OPEN] Opening browser...
    start http://localhost:3000
    echo   Application is ready!
    pause
    exit /b 0
)

curl -s http://localhost:8080 >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   [INFO] Server already running on port 8080
    echo   [OPEN] Opening browser...
    start http://localhost:8080
    echo   Application is ready!
    pause
    exit /b 0
)

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   [ERROR] Node.js not installed!
    echo   Install from: https://nodejs.org
    pause
    exit /b 1
)

REM Auto-upgrade check (optional - can be disabled)
if exist "AUTO_UPGRADE_ENABLED.txt" (
    echo   [CHECK] Checking for updates...
    call npm outdated >nul 2>&1
    if %ERRORLEVEL% EQU 0 (
        echo   [INFO] Packages are up to date
    ) else (
        echo   [INFO] Some packages may need updates
        echo   [INFO] Run AUTO_UPGRADE.bat to update
    )
    echo.
)

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

REM Choose port (default 3000)
set SERVER_PORT=3000
set NPM_SCRIPT=dev

REM Check if port 3000 is busy
netstat -ano | find "3000" | find "LISTENING" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   [INFO] Port 3000 is busy, using port 8080
    set SERVER_PORT=8080
    set NPM_SCRIPT=dev:8080
)

echo   [START] Starting server on port %SERVER_PORT%...
echo.

REM Kill any existing Node processes
taskkill /F /IM node.exe >nul 2>&1
timeout /t 1 /nobreak >nul

REM Start server
start "AI Astrologer Server" cmd /k "npm run %NPM_SCRIPT%"

echo   [WAIT] Waiting for server to be ready...
echo   [INFO] This may take 10-20 seconds
echo.

REM Wait for server
set attempts=0
:wait_loop
timeout /t 2 /nobreak >nul
set /a attempts+=1

curl -s http://localhost:%SERVER_PORT% >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   [SUCCESS] Server is ready!
    echo   [OPEN] Opening browser...
    timeout /t 1 /nobreak >nul
    start http://localhost:%SERVER_PORT%
    echo.
    echo   ╔═══════════════════════════════════════════════════╗
    echo   ║   ✓ APPLICATION STARTED!                         ║
    echo   ║   URL: http://localhost:%SERVER_PORT%                    ║
    echo   ╚═══════════════════════════════════════════════════╝
    echo.
    echo   Server is running in the other window.
    echo   Keep that window open while using the application.
    echo.
    pause
    exit /b 0
)

if %attempts% LEQ 10 (
    echo   [WAIT] Starting... ^(%attempts%/30^)
) else if %attempts% LEQ 20 (
    echo   [WAIT] Compiling... ^(%attempts%/30^)
) else (
    echo   [WAIT] Almost ready... ^(%attempts%/30^)
)

if %attempts% GEQ 30 (
    echo   [WARNING] Server taking longer than expected
    echo   [INFO] Opening browser anyway...
    start http://localhost:%SERVER_PORT%
    echo   If error appears, wait 10 seconds and refresh.
    pause
    exit /b 0
)

goto wait_loop
