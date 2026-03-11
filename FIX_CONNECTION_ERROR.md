# Fix Connection Error - ERR_CONNECTION_REFUSED

## ✅ Solution: Use the Correct Port

The error occurs because:
- **Next.js runs on port 3000 by default**
- You're trying to access port 8080
- The server isn't running on port 8080

## 🚀 Quick Fix

### Option 1: Use Port 3000 (Recommended)
1. **Double-click `start.bat`**
2. Wait for server to start
3. Browser will open automatically at http://localhost:3000

### Option 2: Use Port 8080
1. **Double-click `start-8080.bat`**
2. Wait for server to start  
3. Browser will open automatically at http://localhost:8080

## 🔍 Why This Happens

The connection error means:
- ❌ No server is running on that port
- ❌ Server hasn't started yet
- ❌ Wrong port number

## ✅ How to Verify Server is Running

After running the start script, you should see:
```
✓ Ready in X seconds
○ Local: http://localhost:3000
```

If you see this, the server is running correctly!

## 🛠️ Troubleshooting

### Server Not Starting?
1. Make sure Node.js is installed: `node --version`
2. Install dependencies: `npm install`
3. Check if port is in use
4. Try the other port (3000 or 8080)

### Still Getting Error?
1. **Wait 10-15 seconds** after starting - server needs time to compile
2. Check the command window for error messages
3. Make sure no firewall is blocking the port
4. Try accessing http://127.0.0.1:3000 instead of localhost

## 📝 Step-by-Step

1. **Close any existing browser tabs** with localhost
2. **Double-click `start.bat`** (or `start-8080.bat`)
3. **Wait for "Ready" message** in the command window
4. **Browser opens automatically** - if not, manually go to:
   - http://localhost:3000 (for start.bat)
   - http://localhost:8080 (for start-8080.bat)

The application will work once the server is running! 🎉
