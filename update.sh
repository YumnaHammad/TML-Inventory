#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🔄 Updating Inventory Management System${NC}"

# Stop current containers
echo -e "${YELLOW}🛑 Stopping current version...${NC}"
docker-compose down

# Pull latest changes (if using Git)
if [ -d ".git" ]; then
    echo -e "${YELLOW}📥 Pulling latest changes...${NC}"
    git pull
fi

# Rebuild and start with new changes
echo -e "${YELLOW}🔨 Building new version...${NC}"
docker-compose up --build -d

# Wait for services to be ready
echo -e "${YELLOW}⏳ Waiting for services to restart...${NC}"
sleep 15

# Check if services are running
echo -e "${YELLOW}🔍 Checking if update was successful...${NC}"
if curl -f http://localhost:8080/health > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Update successful!${NC}"
    echo -e "${GREEN}🌐 Your app is updated at: http://localhost:8080${NC}"
else
    echo -e "${RED}❌ Update failed. Check logs with: docker-compose logs${NC}"
fi
