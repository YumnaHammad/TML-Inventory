@echo off
echo 🌐 Deploying to VPS (Your Server)
echo =================================

echo.
echo This script will help you deploy to your VPS server.
echo.

echo Step 1: Connect to your VPS
echo ---------------------------
echo 1. Open Command Prompt as Administrator
echo 2. Run: ssh root@YOUR_VPS_IP
echo 3. Enter your VPS password when prompted
echo.

echo Step 2: Install Docker on VPS
echo ------------------------------
echo Run these commands on your VPS:
echo.
echo apt update
echo apt install -y docker.io docker-compose
echo systemctl start docker
echo systemctl enable docker
echo.

echo Step 3: Upload your project
echo ---------------------------
echo Option A - Using Git (Recommended):
echo 1. Create a GitHub repository
echo 2. Upload your project to GitHub
echo 3. On VPS: git clone YOUR_GITHUB_URL
echo.
echo Option B - Using FileZilla:
echo 1. Download FileZilla (free FTP client)
echo 2. Connect to your VPS using SFTP
echo 3. Upload your entire project folder
echo.

echo Step 4: Deploy on VPS
echo ---------------------
echo On your VPS, run:
echo.
echo cd /root/inventory-management
echo chmod +x deploy.sh
echo ./deploy.sh
echo.

echo Step 5: Access your live app
echo ----------------------------
echo Your app will be available at:
echo http://YOUR_VPS_IP:8080
echo.

echo Press any key to continue...
pause > nul
