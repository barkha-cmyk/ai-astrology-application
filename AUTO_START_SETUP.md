## Auto Start (Windows)

Use this to start the Next.js dev server automatically at login.

### Option A: Startup Folder (simple)
1. Press `Win + R`, type `shell:startup`, press Enter.
2. Copy `auto-start.bat` into that folder.
3. Restart Windows. The app will start on `http://localhost:8080`.

### Option B: Task Scheduler (more reliable)
1. Press `Win + R`, type `taskschd.msc`, press Enter.
2. Create Basic Task:
   - Name: `AI Astrologer`
   - Trigger: `When I log on`
   - Action: `Start a program`
   - Program/script: `C:\Users\WINDOWS 11\OneDrive\ai astro\auto-start.bat`
3. Finish and test by right-clicking the task → Run.

### Stop the server
- Close the terminal window that opens, or run: `taskkill /f /im node.exe`
