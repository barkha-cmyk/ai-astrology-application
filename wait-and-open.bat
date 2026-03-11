@echo off
REM This script waits for the server to be ready, then opens the browser
echo Waiting for server to be ready...
timeout /t 5 /nobreak >nul

REM Try to connect to the server
:check
curl -s http://localhost:3000 >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo Server is ready!
    start http://localhost:3000
    exit /b 0
)

timeout /t 2 /nobreak >nul
goto check
