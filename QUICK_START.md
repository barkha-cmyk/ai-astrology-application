# Quick Start Guide - AI Astrologer

## 🚀 Run Independently (Easiest Method)

### For Windows Users:

**Option 1: Double-click to start (Port 3000)**
1. Double-click `start.bat` file
2. Wait for dependencies to install (first time only)
3. Browser will open automatically or go to http://localhost:3000

**Option 2: Double-click for Port 8080**
1. Double-click `start-8080.bat` file
2. Wait for dependencies to install (first time only)
3. Browser will open automatically or go to http://localhost:8080

**Option 3: PowerShell Script**
1. Right-click `start.ps1`
2. Select "Run with PowerShell"
3. Application will start automatically

### For All Users (Command Line):

```bash
# Install dependencies (first time only)
npm install

# Start the application
npm run dev        # Port 3000
# OR
npm run dev:8080   # Port 8080
```

## 📋 What the Scripts Do:

1. ✅ Check if dependencies are installed
2. ✅ Install dependencies automatically if missing
3. ✅ Create `.env.local` from template if missing
4. ✅ Start the development server
5. ✅ Display the URL to access the application

## 🌐 Access the Application:

Once started, open your browser and go to:
- **Port 3000**: http://localhost:3000
- **Port 8080**: http://localhost:8080

The application will automatically redirect to `/en` (English version).

## ⚙️ Configuration:

1. **First Run**: The script will create `.env.local` from `.env.example`
2. **Update API Keys**: Edit `.env.local` with your actual API keys:
   - OpenAI API key (for AI features)
   - Supabase credentials (for database)
   - Daily.co API key (for video calls - optional)

## 🛑 Stop the Server:

Press `Ctrl+C` in the terminal/command prompt to stop the server.

## 📝 Notes:

- The application will work without API keys, but some features (AI chatbot, predictions) will need OpenAI key
- Database features require Supabase setup
- Video calls require Daily.co account
- All other features work independently!

## 🎯 Troubleshooting:

**Port Already in Use:**
- Use the other port (3000 or 8080)
- Or stop the process using that port

**Dependencies Not Installing:**
- Make sure Node.js 18+ is installed
- Run `npm install` manually

**Connection Refused:**
- Make sure the server is running
- Check the correct port (3000 or 8080)
- Wait a few seconds after starting

The application is now ready to run independently! 🎉
