# 🚀 Vercel Deployment Guide

## Environment Variables Setup

### Frontend Environment Variables (Vercel Dashboard)
```bash
VITE_API_URL=https://your-backend-name.vercel.app
VITE_APP_NAME=Inventory Management System
VITE_APP_VERSION=1.0.0
```

### Backend Environment Variables (Vercel Dashboard)
```bash
# Database
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/inventory?retryWrites=true&w=majority

# JWT
JWT_SECRET=your-super-secret-jwt-key-here
JWT_EXPIRE=7d

# Server
NODE_ENV=production
PORT=5000

# CORS
CORS_ORIGIN=https://tml-frontend.vercel.app
FRONTEND_URL=https://tml-frontend.vercel.app
```

## Deployment Steps

### 1. Frontend Deployment
1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Click "New Project"
3. Import your GitHub repository
4. Set **Root Directory** to `frontend`
5. Set **Build Command** to `npm run build`
6. Set **Output Directory** to `dist`
7. Add environment variables
8. Deploy

### 2. Backend Deployment
1. Create another project in Vercel Dashboard
2. Import the same GitHub repository
3. Set **Root Directory** to `backend`
4. Set **Build Command** to `npm install`
5. Add environment variables
6. Deploy

## Project Structure
```
project-root/
├── frontend/           # React frontend
│   ├── src/
│   ├── package.json
│   └── vite.config.js
├── backend/           # Node.js backend
│   ├── server.js
│   ├── package.json
│   └── vercel.json
├── vercel.json        # Frontend Vercel config
└── env.example        # Environment variables template
```

## URLs After Deployment
- **Frontend**: https://tml-frontend.vercel.app
- **Backend**: https://your-backend-name.vercel.app

## Troubleshooting

### Common Issues:
1. **CORS Errors**: Make sure `CORS_ORIGIN` includes your frontend URL
2. **API Not Found**: Check that backend routes are properly configured
3. **Database Connection**: Verify MongoDB URI is correct
4. **Build Failures**: Check that all dependencies are in package.json

### Testing:
1. Test frontend: https://tml-frontend.vercel.app
2. Test backend health: https://your-backend-name.vercel.app/api/health
3. Check browser console for any errors
4. Verify API calls in Network tab

## Support
If you encounter issues, check:
- Vercel deployment logs
- Browser console errors
- Network tab for failed requests
- Backend server logs in Vercel dashboard
