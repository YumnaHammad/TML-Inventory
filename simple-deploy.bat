@echo off
echo 🚀 Simple Inventory Management Deployment
echo ========================================

echo.
echo Step 1: Testing locally first...
echo.

echo Starting backend server...
start "Backend" cmd /k "cd /d C:\Users\XPRISTO\Desktop\Inventory\backend && node server.js"

echo Waiting 5 seconds...
timeout /t 5 /nobreak > nul

echo Starting frontend server...
start "Frontend" cmd /k "cd /d C:\Users\XPRISTO\Desktop\Inventory\frontend && npm run dev"

echo.
echo ✅ Both servers started!
echo.
echo 🌐 Your app is now running at:
echo    Frontend: http://localhost:3001
echo    Backend:  http://localhost:5000
echo.
echo Press any key to continue...
pause > nul
