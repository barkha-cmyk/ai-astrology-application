# Auto-Upgrade and Auto-Start Guide

## Quick Start

### Option 1: Auto Upgrade & Start (Recommended)
**Double-click: `AUTO_UPGRADE_AND_START.bat`**

This will:
- ✅ Upgrade all packages to latest versions
- ✅ Install missing dependencies
- ✅ Start the application
- ✅ Open browser automatically

### Option 2: Just Auto Start
**Double-click: `AUTO_START.bat`**

This will:
- ✅ Check if server is already running
- ✅ Start server if not running
- ✅ Open browser automatically
- ✅ Auto-select port (3000 or 8080)

### Option 3: Just Upgrade
**Double-click: `AUTO_UPGRADE.bat`**

This will:
- ✅ Update npm to latest version
- ✅ Upgrade all packages
- ✅ Check for outdated packages
- ✅ Ask if you want to start

## Auto-Start on Windows Boot

### Install Auto-Start
**Double-click: `INSTALL_AUTO_START.bat`**

This will:
- ✅ Add application to Windows startup
- ✅ Application starts automatically on boot
- ✅ No manual intervention needed

### Disable Auto-Start
1. Press `Win + R`
2. Type: `shell:startup`
3. Delete `AI_Astrologer_Startup.vbs`

## Auto-Recovery

### If Application Crashes
**Double-click: `AUTO_RECOVERY.bat`**

This will:
- ✅ Stop crashed servers
- ✅ Clean npm cache
- ✅ Reinstall corrupted dependencies
- ✅ Restart application automatically

## Features

### Auto-Upgrade Features:
- Checks for package updates
- Upgrades to latest compatible versions
- Installs missing dependencies
- Verifies installation

### Auto-Start Features:
- Detects if server already running
- Auto-selects available port
- Waits for server to be ready
- Opens browser automatically
- Shows clear status messages

### Auto-Recovery Features:
- Kills crashed processes
- Cleans corrupted cache
- Reinstalls broken dependencies
- Restarts automatically

## Usage Scenarios

### First Time Setup:
1. Run `AUTO_UPGRADE_AND_START.bat`
2. Wait for installation
3. Application starts automatically

### Daily Use:
1. Run `AUTO_START.bat`
2. Application starts in 10-20 seconds
3. Browser opens automatically

### After Updates:
1. Run `AUTO_UPGRADE.bat`
2. Packages upgrade automatically
3. Start application when ready

### If Something Breaks:
1. Run `AUTO_RECOVERY.bat`
2. Issues are fixed automatically
3. Application restarts

## Configuration

### Enable Auto-Upgrade Check on Start
Create a file named `AUTO_UPGRADE_ENABLED.txt` in the project folder.
This will make `AUTO_START.bat` check for updates before starting.

### Disable Auto-Upgrade Check
Delete `AUTO_UPGRADE_ENABLED.txt` if it exists.

## Troubleshooting

### Auto-Start Not Working?
- Check if file exists in startup folder
- Run `INSTALL_AUTO_START.bat` again
- Make sure you have admin privileges

### Upgrade Fails?
- Check internet connection
- Run `AUTO_RECOVERY.bat` first
- Then try `AUTO_UPGRADE.bat` again

### Server Won't Start?
- Run `AUTO_RECOVERY.bat`
- This fixes most common issues
- Then run `AUTO_START.bat`

## Summary

| Task | Script |
|------|--------|
| **Upgrade & Start** | `AUTO_UPGRADE_AND_START.bat` |
| **Just Start** | `AUTO_START.bat` |
| **Just Upgrade** | `AUTO_UPGRADE.bat` |
| **Install Boot Start** | `INSTALL_AUTO_START.bat` |
| **Fix Issues** | `AUTO_RECOVERY.bat` |

## Benefits

✅ **No Manual Steps** - Everything happens automatically
✅ **Always Updated** - Packages stay current
✅ **Auto-Recovery** - Fixes issues automatically
✅ **Boot Start** - Starts with Windows
✅ **Smart Detection** - Knows what to do

## Ready to Use!

Just double-click `AUTO_UPGRADE_AND_START.bat` and everything happens automatically!
