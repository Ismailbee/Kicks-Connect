# Development Guide

## Project Overview

Kicks-Connect is a full-stack sneaker marketplace application with the following architecture:

### Frontend (React + TypeScript)
- **Location**: `/client/`
- **Port**: 3000 (development)
- **Features**: 
  - Responsive grid layout for sneaker cards
  - Modern UI with gradient headers
  - TypeScript for type safety
  - Component-based architecture

### Backend (Node.js + Express)
- **Location**: `/server/`
- **Port**: 5000
- **Features**:
  - RESTful API endpoints
  - CORS enabled for frontend communication
  - Mock data for development
  - Environment configuration support

## API Endpoints

### Health Check
```
GET /api/health
```
Response:
```json
{
  "message": "Kicks-Connect API is running!",
  "status": "OK"
}
```

### Get Sneakers
```
GET /api/sneakers
```
Response:
```json
[
  {
    "id": 1,
    "name": "Air Jordan 1 Retro High",
    "brand": "Nike",
    "price": 170,
    "size": "10",
    "condition": "New",
    "image": "/images/jordan1.jpg",
    "seller": "SneakerHead123"
  }
]
```

## Development Workflow

1. **Install dependencies**:
   ```bash
   npm run install-all
   ```

2. **Start development servers**:
   ```bash
   npm run dev
   ```
   This runs both frontend (port 3000) and backend (port 5000) concurrently.

3. **Build for production**:
   ```bash
   npm run build
   ```

## File Structure
```
Kicks-Connect/
├── client/                    # React frontend
│   ├── src/
│   │   ├── components/        # React components
│   │   │   └── SneakerCard.tsx
│   │   ├── App.tsx           # Main app component
│   │   ├── App.css           # Application styles
│   │   ├── types.ts          # TypeScript type definitions
│   │   └── index.tsx         # React entry point
│   ├── public/               # Static assets
│   └── package.json          # Frontend dependencies
├── server/                   # Node.js backend
│   ├── index.js             # Express server
│   ├── .env                 # Environment variables
│   └── package.json         # Backend dependencies
├── package.json             # Root project configuration
├── .gitignore              # Git ignore rules
└── README.md               # Project documentation
```

## Next Steps for Development

1. **Database Integration**: Add MongoDB with Mongoose for data persistence
2. **Authentication**: Implement JWT-based user authentication
3. **Image Upload**: Add file upload functionality for sneaker images
4. **Search & Filter**: Implement search and filtering capabilities
5. **User Profiles**: Create user registration and profile management
6. **Real-time Features**: Add real-time chat for buyer-seller communication
7. **Payment Integration**: Integrate payment processing (Stripe, PayPal)
8. **Mobile Responsiveness**: Enhance mobile experience
9. **Testing**: Add unit and integration tests
10. **Deployment**: Set up production deployment pipeline

## Environment Variables

Backend environment variables (server/.env):
```
PORT=5000
MONGODB_URI=mongodb://localhost:27017/kicks-connect
JWT_SECRET=your-secret-key-here
```

## Technology Stack

- **Frontend**: React 18, TypeScript, CSS3
- **Backend**: Node.js, Express, CORS
- **Development**: Concurrently, Nodemon
- **Future**: MongoDB, JWT, bcryptjs, Mongoose