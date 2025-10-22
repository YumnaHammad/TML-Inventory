#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Starting Inventory Management System Deployment${NC}"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker is not installed. Please install Docker first.${NC}"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ Docker Compose is not installed. Please install Docker Compose first.${NC}"
    exit 1
fi

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo -e "${YELLOW}⚠️  Creating .env file from template...${NC}"
    cp .env.example .env
    echo -e "${YELLOW}📝 Please edit .env file with your MongoDB credentials and domain name${NC}"
    echo -e "${YELLOW}   Then run this script again.${NC}"
    exit 1
fi

# Stop existing containers
echo -e "${YELLOW}🛑 Stopping existing containers...${NC}"
docker-compose down

# Remove old images
echo -e "${YELLOW}🗑️  Removing old images...${NC}"
docker-compose down --rmi all

# Build and start containers
echo -e "${YELLOW}🔨 Building and starting containers...${NC}"
docker-compose up --build -d

# Wait for services to be ready
echo -e "${YELLOW}⏳ Waiting for services to be ready...${NC}"
sleep 30

# Check if services are running
echo -e "${YELLOW}🔍 Checking service health...${NC}"
if curl -f http://localhost:8080/health > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Frontend is running on http://localhost:8080${NC}"
else
    echo -e "${RED}❌ Frontend health check failed${NC}"
fi

if curl -f http://localhost:5000/api/health > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Backend API is running on http://localhost:5000${NC}"
else
    echo -e "${RED}❌ Backend API health check failed${NC}"
fi

echo -e "${GREEN}🎉 Deployment completed!${NC}"
echo -e "${GREEN}📱 Your app is available at: http://localhost:8080${NC}"
echo -e "${GREEN}🔧 API is available at: http://localhost:5000/api${NC}"
