═══════════════════════════════════════════════════════
HOW TO FIX "localhost refused to connect" ERROR
═══════════════════════════════════════════════════════

THE PROBLEM:
- Browser tries to connect to localhost:8080
- But no server is running on that port
- Result: "ERR_CONNECTION_REFUSED"

THE SOLUTION:
1. Close browser tab with error
2. Double-click: FIX_AND_START.bat
3. Wait for "SERVER IS RUNNING!" message
4. Browser opens automatically - ERROR FIXED!

═══════════════════════════════════════════════════════

WHAT FIX_AND_START.bat DOES:
✓ Stops all old Node.js processes
✓ Checks Node.js is installed
✓ Installs dependencies if needed
✓ Starts fresh server on port 8080
✓ Waits for server to be ready
✓ Opens browser automatically

═══════════════════════════════════════════════════════

IMPORTANT:
- Keep the server window OPEN!
- Don't close it while using the app
- Wait 15-20 seconds for first start

═══════════════════════════════════════════════════════

IF STILL SEEING ERROR:
1. Check server window for error messages
2. Wait 15 more seconds
3. Press F5 to refresh browser
4. Run FIX_AND_START.bat again

═══════════════════════════════════════════════════════

ALTERNATIVE SCRIPTS:
- WORKING_FIX.bat (same functionality)
- START_NOW.bat (quick start)
- HOST_SERVER.bat (full auto)

═══════════════════════════════════════════════════════
