@echo off
title AI Astrologer - Complete Setup and Start
color 0B
cls

echo.
echo   ╔═══════════════════════════════════════════════════════╗
echo   ║   AI ASTROLOGER - COMPLETE AUTO START                ║
echo   ║   Installing all software and starting servers       ║
echo   ╚═══════════════════════════════════════════════════════╝
echo.

REM ============================================
REM STEP 1: Check Prerequisites
REM ============================================
echo   [STEP 1/5] Checking prerequisites...
echo.

where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   [ERROR] Node.js is not installed!
    echo.
    echo   Please install Node.js 18+ from: https://nodejs.org
    echo   After installation, run this script again.
    echo.
    pause
    exit /b 1
)

echo   [OK] Node.js found:
node --version
npm --version
echo.

REM ============================================
REM STEP 2: Install All Dependencies
REM ============================================
echo   [STEP 2/5] Installing all software dependencies...
echo.

if exist "node_modules" (
    echo   [INFO] Dependencies already installed
    echo.
) else (
    echo   [INFO] Installing all required packages...
    echo   This includes:
    echo   - Next.js (Web framework)
    echo   - React (UI library)
    echo   - Tailwind CSS (Styling)
    echo   - OpenAI SDK (AI features)
    echo   - Socket.io (Real-time chat)
    echo   - Daily.co (Video calls)
    echo   - Supabase (Database)
    echo   - D3.js (Charts)
    echo   - And more...
    echo.
    echo   Please wait 2-3 minutes...
    echo.
    
    call npm install
    
    if %ERRORLEVEL% NEQ 0 (
        echo   [ERROR] Failed to install dependencies
        echo   Please check your internet connection and try again
        pause
        exit /b 1
    )
    
    echo.
    echo   [SUCCESS] All dependencies installed!
    echo.
)

REM ============================================
REM STEP 3: Setup Environment
REM ============================================
echo   [STEP 3/5] Setting up environment configuration...
echo.

if not exist ".env.local" (
    if exist ".env.example" (
        copy ".env.example" ".env.local" >nul
        echo   [OK] Environment file created (.env.local)
        echo   [INFO] You can add your API keys later in .env.local
    ) else (
        echo   # AI Astrologer Environment Variables > .env.local
        echo   NEXT_PUBLIC_SUPABASE_URL=your_supabase_url >> .env.local
        echo   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_key >> .env.local
        echo   OPENAI_API_KEY=your_openai_key >> .env.local
        echo   DAILY_API_KEY=your_daily_video_key >> .env.local
        echo   NEXT_PUBLIC_SOCKET_URL=http://localhost:3000 >> .env.local
        echo   [OK] Environment file created
    )
    echo.
) else (
    echo   [OK] Environment file exists
    echo.
)

REM ============================================
REM STEP 4: Start Development Server
REM ============================================
echo   [STEP 4/5] Starting Next.js development server...
echo.
echo   [INFO] Server will run on: http://localhost:3000
echo   [INFO] This may take 10-20 seconds for first compilation
echo.

REM Kill any existing Node.js processes on port 3000
for /f "tokens=5" %%a in ('netstat -ano ^| find "3000" ^| find "LISTENING"') do (
    echo   [INFO] Closing existing server on port 3000...
    taskkill /F /PID %%a >nul 2>&1
)

REM Start the server in a new window
start "AI Astrologer - Development Server" cmd /k "echo Starting Next.js server... && npm run dev"

echo   [INFO] Server window opened
echo   [WAIT] Waiting for server to compile and be ready...
echo.

REM ============================================
REM STEP 5: Wait for Server and Open Browser
REM ============================================
set attempts=0
set max_attempts=45

:check_server
set /a attempts+=1
timeout /t 2 /nobreak >nul

REM Check if server is responding
curl -s http://localhost:3000 >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   [SUCCESS] Server is ready and responding!
    echo.
    echo   [STEP 5/5] Opening browser...
    timeout /t 1 /nobreak >nul
    start http://localhost:3000
    
    echo.
    echo   ╔═══════════════════════════════════════════════════════╗
    echo   ║   ✓ ALL SERVERS ARE RUNNING!                        ║
    echo   ║                                                       ║
    echo   ║   Application URL: http://localhost:3000            ║
    echo   ║   Status: Ready                                      ║
    echo   ║                                                       ║
    echo   ║   Services running:                                  ║
    echo   ║   • Next.js Development Server                       ║
    echo   ║   • React Hot Reload                                 ║
    echo   ║   • API Routes                                       ║
    echo   ║   • WebSocket Support                                ║
    echo   ║                                                       ║
    echo   ║   Browser opened automatically!                      ║
    echo   ╚═══════════════════════════════════════════════════════╝
    echo.
    echo   To stop all servers: Close the "Development Server" window
    echo   or press Ctrl+C in that window.
    echo.
    echo   This window can be closed. Press any key to close...
    pause >nul
    exit /b 0
)

REM Show progress
if %attempts% LEQ 5 (
    echo   [WAIT] Starting up... ^(%attempts%/45^)
)
if %attempts% GTR 5 if %attempts% LEQ 15 (
    echo   [WAIT] Compiling application... ^(%attempts%/45^)
)
if %attempts% GTR 15 (
    echo   [WAIT] Almost ready... ^(%attempts%/45^)
)

REM Check if we've waited too long
if %attempts% GEQ %max_attempts% (
    echo.
    echo   [WARNING] Server is taking longer than expected
    echo   [INFO] Opening browser anyway - it may still be starting
    echo.
    start http://localhost:3000
    echo   If you see an error in browser:
    echo   1. Wait 10-20 more seconds
    echo   2. Refresh the page ^(F5^)
    echo   3. Check the "Development Server" window for errors
    echo.
    pause
    exit /b 0
)

goto check_server
