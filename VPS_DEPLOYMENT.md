# 🚀 VPS Deployment Guide

## Prerequisites
- VPS with Ubuntu 20.04+ or CentOS 7+
- Root or sudo access
- Domain name (optional but recommended)

## Step 1: Connect to Your VPS

```bash
ssh root@your-vps-ip
# or
ssh username@your-vps-ip
```

## Step 2: Install Docker and Docker Compose

### For Ubuntu/Debian:
```bash
# Update package index
apt update

# Install required packages
apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Add Docker repository
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install Docker
apt update
apt install -y docker-ce docker-ce-cli containerd.io

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Start Docker service
systemctl start docker
systemctl enable docker
```

## Step 3: Upload Your Project

### Option A: Using Git (Recommended)
```bash
# Install Git
apt install -y git

# Clone your repository
git clone https://github.com/yourusername/inventory-management.git
cd inventory-management
```

### Option B: Using SCP
```bash
# From your local machine
scp -r ./inventory-management root@your-vps-ip:/root/
```

## Step 4: Configure Environment Variables

```bash
# Create .env file
nano .env
```

Add your MongoDB credentials:
```env
MONGODB_URI=mongodb+srv://username:password@cluster0.xxxxx.mongodb.net/inventory_system?retryWrites=true&w=majority
NODE_ENV=production
PORT=5000
VITE_API_URL=http://your-domain.com/api
VITE_APP_NAME=Inventory Management System
```

## Step 5: Deploy with Docker

```bash
# Make deploy script executable
chmod +x deploy.sh

# Run deployment
./deploy.sh
```

## Step 6: Configure Domain (Optional)

### Using Nginx (if you have a domain):
```bash
# Install Nginx
apt install -y nginx

# Create site configuration
nano /etc/nginx/sites-available/inventory
```

Add this configuration:
```nginx
server {
    listen 80;
    server_name your-domain.com www.your-domain.com;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Enable the site:
```bash
ln -s /etc/nginx/sites-available/inventory /etc/nginx/sites-enabled/
nginx -t
systemctl reload nginx
```

## Step 7: SSL Certificate (Optional but Recommended)

```bash
# Install Certbot
apt install -y certbot python3-certbot-nginx

# Get SSL certificate
certbot --nginx -d your-domain.com -d www.your-domain.com
```

## Step 8: Firewall Configuration

```bash
# Install UFW
apt install -y ufw

# Configure firewall
ufw allow ssh
ufw allow 80
ufw allow 443
ufw enable
```

## Step 9: Monitor Your Application

```bash
# Check container status
docker-compose ps

# View logs
docker-compose logs -f

# Restart services
docker-compose restart
```

## Step 10: Access Your Application

- **Without domain**: http://your-vps-ip:8080
- **With domain**: http://your-domain.com
- **API**: http://your-domain.com/api

## Troubleshooting

### Check if containers are running:
```bash
docker ps
```

### View application logs:
```bash
docker-compose logs backend
docker-compose logs frontend
```

### Restart all services:
```bash
docker-compose restart
```

### Update application:
```bash
git pull
docker-compose up --build -d
```

## Security Recommendations

1. **Change default SSH port**
2. **Use SSH keys instead of passwords**
3. **Enable fail2ban**
4. **Keep system updated**
5. **Use strong passwords**
6. **Enable firewall**
7. **Use SSL certificates**

## Backup

```bash
# Backup MongoDB data
docker exec inventory-backend mongodump --uri="your-mongodb-uri" --out=/backup

# Backup application files
tar -czf inventory-backup-$(date +%Y%m%d).tar.gz /root/inventory-management
```

## Monitoring

```bash
# Check system resources
htop

# Check disk usage
df -h

# Check memory usage
free -h

# Check Docker stats
docker stats
```
