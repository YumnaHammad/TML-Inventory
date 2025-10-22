#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Deploying from Separate Repositories${NC}"

# Get repository URLs from user
echo -e "${YELLOW}📝 Please provide your GitHub repository URLs:${NC}"
read -p "Backend repository URL: " BACKEND_REPO
read -p "Frontend repository URL: " FRONTEND_REPO

# Create project directory
mkdir -p /root/inventory-management
cd /root/inventory-management

# Clone backend repository
echo -e "${YELLOW}📥 Cloning backend repository...${NC}"
git clone $BACKEND_REPO backend

# Clone frontend repository
echo -e "${YELLOW}📥 Cloning frontend repository...${NC}"
git clone $FRONTEND_REPO frontend

# Create docker-compose.yml for separate repos
echo -e "${YELLOW}📝 Creating docker-compose.yml...${NC}"
cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  backend:
    build: ./backend
    container_name: inventory-backend
    restart: unless-stopped
    environment:
      - NODE_ENV=production
      - PORT=5000
      - MONGODB_URI=${MONGODB_URI}
    ports:
      - "5000:5000"
    networks:
      - inventory-network

  frontend:
    build: ./frontend
    container_name: inventory-frontend
    restart: unless-stopped
    ports:
      - "80:80"
    depends_on:
      - backend
    networks:
      - inventory-network

networks:
  inventory-network:
    driver: bridge
EOF

# Create .env file
echo -e "${YELLOW}📝 Creating .env file...${NC}"
cat > .env << 'EOF'
MONGODB_URI=mongodb+srv://inventory:your-password@cluster0.earrfsb.mongodb.net/inventory_system?retryWrites=true&w=majority
NODE_ENV=production
PORT=5000
EOF

echo -e "${YELLOW}⚠️  Please edit .env file with your MongoDB credentials${NC}"

# Deploy
echo -e "${YELLOW}🚀 Starting deployment...${NC}"
docker-compose up --build -d

echo -e "${GREEN}✅ Deployment completed!${NC}"
echo -e "${GREEN}🌐 Your app is available at: http://your-vps-ip:80${NC}"
