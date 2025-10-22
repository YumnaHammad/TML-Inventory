#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}📦 Creating Monorepo from Separate Repositories${NC}"

# Get repository URLs from user
echo -e "${YELLOW}📝 Please provide your GitHub repository URLs:${NC}"
read -p "Backend repository URL: " BACKEND_REPO
read -p "Frontend repository URL: " FRONTEND_REPO
read -p "New monorepo name (e.g., inventory-management): " REPO_NAME

# Create new directory
mkdir -p $REPO_NAME
cd $REPO_NAME

# Initialize git
git init

# Clone backend as subdirectory
echo -e "${YELLOW}📥 Cloning backend...${NC}"
git clone $BACKEND_REPO temp-backend
mv temp-backend/* backend/
mv temp-backend/.* backend/ 2>/dev/null || true
rmdir temp-backend

# Clone frontend as subdirectory
echo -e "${YELLOW}📥 Cloning frontend...${NC}"
git clone $FRONTEND_REPO temp-frontend
mv temp-frontend/* frontend/
mv temp-frontend/.* frontend/ 2>/dev/null || true
rmdir temp-frontend

# Create root files
echo -e "${YELLOW}📝 Creating root files...${NC}"

# Create README.md
cat > README.md << 'EOF'
# Inventory Management System

A full-stack inventory management system with React frontend and Node.js backend.

## Quick Start

1. Clone this repository
2. Run `./deploy.sh` to deploy with Docker
3. Access the app at http://localhost:8080

## Structure

- `backend/` - Node.js API server
- `frontend/` - React frontend application
- `docker-compose.yml` - Docker orchestration
- `deploy.sh` - Deployment script

## Environment Variables

Create a `.env` file with your MongoDB credentials:

```env
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/database
NODE_ENV=production
PORT=5000
```
EOF

# Create .gitignore
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
*/node_modules/

# Environment variables
.env
.env.local
.env.production

# Build outputs
dist/
build/

# Logs
*.log
npm-debug.log*

# OS generated files
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/

# Docker
.docker/
EOF

# Add all files
git add .
git commit -m "Initial commit: Combined backend and frontend repositories"

echo -e "${GREEN}✅ Monorepo created successfully!${NC}"
echo -e "${YELLOW}📝 Next steps:${NC}"
echo -e "1. Create a new repository on GitHub named '$REPO_NAME'"
echo -e "2. Run: git remote add origin https://github.com/yourusername/$REPO_NAME.git"
echo -e "3. Run: git push -u origin main"
echo -e "4. Your monorepo is ready for deployment!"
