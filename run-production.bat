@echo off
echo ========================================
echo   AI Astrologer - Production Mode
echo   Building and Starting...
echo ========================================
echo.

REM Check if Node.js is installed
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Node.js is not installed or not in PATH
    pause
    exit /b 1
)

REM Check if node_modules exists
if not exist "node_modules" (
    echo Installing dependencies...
    call npm install
    if %ERRORLEVEL% NEQ 0 (
        echo ERROR: Failed to install dependencies
        pause
        exit /b 1
    )
    echo.
)

echo Building application for production...
call npm run build
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Build failed
    pause
    exit /b 1
)

echo.
echo Starting production server on port 3000...
echo Server will be available at http://localhost:3000
echo.
echo Opening browser...
timeout /t 2 /nobreak >nul
start http://localhost:3000
echo.
echo Server is running. Press Ctrl+C to stop.
echo.

call npm run start

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Server failed to start
    pause
    exit /b 1
)
