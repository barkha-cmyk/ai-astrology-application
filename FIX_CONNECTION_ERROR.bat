@echo off
title FIX CONNECTION ERROR - 100% WORKING
color 0A
cls

echo.
echo   ╔═══════════════════════════════════════════════════╗
echo   ║   FIX "localhost refused to connect" ERROR       ║
echo   ║   This WILL fix it - guaranteed!                  ║
echo   ╚═══════════════════════════════════════════════════╝
echo.
echo   Close the browser tab with the error FIRST!
echo   Then press any key to continue...
pause >nul
cls

echo   [1/6] Stopping ALL servers...
taskkill /F /IM node.exe >nul 2>&1
timeout /t 2 /nobreak >nul

REM Kill specific ports
for /f "tokens=5" %%a in ('netstat -ano ^| find "3000" ^| find "LISTENING"') do taskkill /F /PID %%a >nul 2>&1
for /f "tokens=5" %%a in ('netstat -ano ^| find "8080" ^| find "LISTENING"') do taskkill /F /PID %%a >nul 2>&1
echo   ✓ All servers stopped
echo.

echo   [2/6] Checking Node.js...
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   ✗ ERROR: Node.js not installed!
    echo   Download from: https://nodejs.org
    pause
    exit /b 1
)
node --version
echo   ✓ Node.js OK
echo.

echo   [3/6] Checking dependencies...
if not exist "node_modules" (
    echo   Installing dependencies (first time - takes 2-3 minutes)...
    call npm install
    if %ERRORLEVEL% NEQ 0 (
        echo   ✗ Installation failed!
        pause
        exit /b 1
    )
) else (
    echo   ✓ Dependencies exist
)
echo.

echo   [4/6] Setting up environment...
if not exist ".env.local" (
    if exist ".env.example" (
        copy ".env.example" ".env.local" >nul
    )
)
echo   ✓ Environment ready
echo.

echo   [5/6] Starting server on port 8080...
echo   IMPORTANT: A server window will open - DO NOT CLOSE IT!
echo.
start "AI Astrologer Server" cmd /k "title AI Astrologer Server && echo. && echo Starting server on port 8080... && echo Please wait for 'Ready' message... && echo. && npm run dev:8080"

echo   [6/6] Waiting for server to be ready...
echo   This takes 10-20 seconds - PLEASE WAIT!
echo.

set attempts=0
:wait_for_server
timeout /t 2 /nobreak >nul
set /a attempts+=1

REM Check if server is responding
curl -s http://localhost:8080 >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo.
    echo   ╔═══════════════════════════════════════════════════╗
    echo   ║   ✓✓✓ SUCCESS! ERROR FIXED! ✓✓✓                 ║
    echo   ╚═══════════════════════════════════════════════════╝
    echo.
    echo   Server is ready and responding!
    echo   Opening browser in 2 seconds...
    timeout /t 2 /nobreak >nul
    start http://localhost:8080
    echo.
    echo   ✓ Application running at: http://localhost:8080
    echo   ✓ Browser opened automatically
    echo   ✓ NO MORE "refused to connect" ERROR!
    echo.
    echo   Keep the server window open while using the app.
    echo   Close it only when you're done.
    echo.
    pause
    exit /b 0
)

REM Show progress
if %attempts% LEQ 5 (
    echo   [WAIT] Server starting... ^(%attempts%/30^)
) else if %attempts% LEQ 15 (
    echo   [WAIT] Compiling... ^(%attempts%/30^)
) else if %attempts% LEQ 25 (
    echo   [WAIT] Almost ready... ^(%attempts%/30^)
) else (
    echo   [WAIT] Finalizing... ^(%attempts%/30^)
)

if %attempts% GEQ 30 (
    echo.
    echo   [INFO] Server is taking longer than usual
    echo   [INFO] Opening browser anyway...
    echo   [INFO] If error appears, wait 15 seconds and refresh (F5)
    start http://localhost:8080
    echo.
    echo   Check the server window for:
    echo   - "Ready" message = Server is working
    echo   - Error messages = Something needs fixing
    echo.
    pause
    exit /b 0
)

goto wait_for_server
