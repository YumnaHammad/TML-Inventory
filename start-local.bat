@echo off
echo 🚀 Starting Inventory Management System (Local Development)
echo ========================================================

echo.
echo Starting backend server...
start "Backend" cmd /k "cd /d C:\Users\XPRISTO\Desktop\Inventory\backend && node server.js"

echo Waiting 5 seconds for backend to start...
timeout /t 5 /nobreak > nul

echo Starting frontend server...
start "Frontend" cmd /k "cd /d C:\Users\XPRISTO\Desktop\Inventory\frontend && npm run dev"

echo.
echo ✅ Both servers started!
echo.
echo 🌐 Your local app is now running at:
echo    Frontend: http://localhost:3001
echo    Backend:  http://localhost:5000
echo.
echo 📝 The app will automatically use localhost backend when running locally
echo 📝 The app will automatically use Vercel backend when deployed
echo.
echo Press any key to continue...
pause > nul
