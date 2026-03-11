# Host and Run Local Server

## Quick Start

### Option 1: Full Auto (Recommended)
**Double-click: `HOST_SERVER.bat`**

This will:
- ✅ Check requirements
- ✅ Install dependencies if needed
- ✅ Start server on port 8080
- ✅ Wait for server to be ready
- ✅ Open browser automatically

### Option 2: Simple Start
**Double-click: `START_LOCAL_SERVER.bat`**

This will:
- ✅ Start server on port 8080
- ✅ Show server URL
- ✅ You open browser manually

### Option 3: Basic Run
**Double-click: `RUN_SERVER.bat`**

This will:
- ✅ Start server
- ✅ Show instructions
- ✅ You open browser manually

## Server URLs

Once running, access at:
- **Port 8080**: http://localhost:8080
- **Port 3000**: http://localhost:3000 (if using start.bat)

## How It Works

1. **Script starts server** in separate window
2. **Server compiles** (10-20 seconds first time)
3. **Server shows "Ready"** message
4. **You access** http://localhost:8080
5. **Application loads** in browser

## Important Notes

- **Keep server window open** - Don't close it!
- **Wait for "Ready"** - Don't access before server is ready
- **First time takes longer** - Server needs to compile
- **Port 8080** - Default port used

## To Stop Server

- Close the server window
- OR press `Ctrl+C` in server window

## Troubleshooting

### Server won't start?
- Check Node.js is installed: `node --version`
- Check dependencies: Make sure `node_modules` exists
- Run `HOST_SERVER.bat` - it installs automatically

### Still see connection error?
- Wait 10-20 more seconds
- Check server window for "Ready" message
- Refresh browser (F5)

## Ready to Host!

**Just double-click `HOST_SERVER.bat`** and your local server will be running!
