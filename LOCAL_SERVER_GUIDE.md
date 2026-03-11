# 🖥️ Local Server Guide

## 🚀 Start Local Server

The application runs on a **local development server** on your computer.

### Quick Start

**Option 1: Interactive Menu**
- Double-click `start-local-server.bat`
- Choose port 3000 or 8080
- Server starts automatically

**Option 2: Direct Start**
- **Port 3000**: Double-click `start.bat`
- **Port 8080**: Double-click `start-8080.bat`

## 📍 Local Server URLs

Once started, access the application at:
- **Port 3000**: http://localhost:3000
- **Port 8080**: http://localhost:8080

You can also use:
- http://127.0.0.1:3000
- http://127.0.0.1:8080

## ✅ How to Know Server is Running

Look for this message in the command window:
```
✓ Ready in X seconds
○ Local: http://localhost:3000
```

When you see "Ready", the local server is running!

## 🔧 What the Local Server Does

1. **Serves the Application**: Makes your app accessible in the browser
2. **Hot Reload**: Automatically refreshes when you make changes
3. **Development Mode**: Optimized for development (not production)
4. **Local Only**: Only accessible on your computer

## 🌐 Accessing the Local Server

### From Browser:
1. Wait for "Ready" message
2. Open browser
3. Go to http://localhost:3000
4. Application loads!

### Automatic Browser Opening:
- Browser opens automatically after 15 seconds
- If it doesn't open, manually go to the URL

## 🛑 Stop the Local Server

Press `Ctrl+C` in the command window, or close the window.

## ⚠️ Important Notes

1. **Local Only**: Server only works on your computer
2. **Must Be Running**: Keep the command window open
3. **Port Conflict**: If port is busy, use the other port
4. **First Time**: Takes longer to start (compiling)

## 🐛 Troubleshooting

### Server Won't Start?
- Check Node.js is installed: `node --version`
- Make sure port isn't in use
- Try the other port

### Can't Access Localhost?
- Wait for "Ready" message
- Check the correct port (3000 or 8080)
- Try http://127.0.0.1 instead of localhost

### Connection Refused?
- Server isn't running yet - wait longer
- Wrong port number
- Firewall blocking (unlikely for localhost)

## 📋 Server Status

| Status | Meaning |
|--------|---------|
| "Starting..." | Server is compiling |
| "Ready" | Server is running - you can access it! |
| "Error" | Something went wrong - check messages |

## 🎯 Quick Reference

- **Start**: Double-click `start.bat` or `start-local-server.bat`
- **URL**: http://localhost:3000
- **Stop**: Press Ctrl+C
- **Status**: Look for "Ready" message

The local server is the easiest way to run and test your application! 🎉
