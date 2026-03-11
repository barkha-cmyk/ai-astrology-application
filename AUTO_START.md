# Auto-Start Guide - Run Application Independently

## 🎯 One-Click Start (Windows)

The application can now run completely independently with just a double-click!

### Method 1: Batch File (Recommended)
1. **Double-click `start.bat`** - Starts on port 3000
2. **Double-click `start-8080.bat`** - Starts on port 8080

That's it! The script will:
- ✅ Check and install dependencies automatically
- ✅ Create environment file if missing
- ✅ Start the development server
- ✅ Display the URL to access

### Method 2: PowerShell Script
1. Right-click `start.ps1`
2. Select "Run with PowerShell"
3. Application starts automatically

## 🔄 What Happens Automatically:

1. **Dependency Check**: Script checks if `node_modules` exists
2. **Auto-Install**: If missing, runs `npm install` automatically
3. **Environment Setup**: Creates `.env.local` from template if missing
4. **Server Start**: Launches Next.js development server
5. **Ready**: Application is accessible at http://localhost:3000 or http://localhost:8080

## 📱 Access the Application:

After starting, open your browser:
- **Port 3000**: http://localhost:3000
- **Port 8080**: http://localhost:8080

The app automatically redirects to `/en` (English).

## 🛑 Stop the Server:

Press `Ctrl+C` in the command window, or close the window.

## ⚙️ First-Time Setup:

1. **First Run**: Script installs dependencies (may take 2-3 minutes)
2. **Environment**: Creates `.env.local` file
3. **Optional**: Edit `.env.local` to add API keys for full functionality

## 🎉 Benefits:

- ✅ No manual commands needed
- ✅ Automatic dependency management
- ✅ Works immediately after double-click
- ✅ Handles all setup automatically
- ✅ Works on any Windows machine with Node.js

## 📝 Requirements:

- Windows 10/11
- Node.js 18+ installed
- Internet connection (for first-time dependency installation)

The application is now fully independent and ready to run! 🚀
