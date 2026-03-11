@echo off
title AI Astrologer - Local Server Starter
color 0B
cls
echo.
echo ========================================
echo     AI ASTROLOGER - LOCAL SERVER
echo ========================================
echo.
echo This will start the local development server
echo.
echo Choose your port:
echo   1. Port 3000 (Recommended)
echo   2. Port 8080 (Alternative)
echo   3. Exit
echo.
set /p choice="Enter your choice (1-3): "

if "%choice%"=="1" goto port3000
if "%choice%"=="2" goto port8080
if "%choice%"=="3" goto end
goto invalid

:port3000
cls
echo.
echo Starting local server on port 3000...
echo.
call start.bat
goto end

:port8080
cls
echo.
echo Starting local server on port 8080...
echo.
call start-8080.bat
goto end

:invalid
echo.
echo Invalid choice. Please run again.
timeout /t 2 >nul
goto end

:end
exit
