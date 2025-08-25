const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.get('/api/health', (req, res) => {
  res.json({ message: 'Kicks-Connect API is running!', status: 'OK' });
});

// Basic sneakers endpoint
app.get('/api/sneakers', (req, res) => {
  // Mock data for now
  const mockSneakers = [
    {
      id: 1,
      name: 'Air Jordan 1 Retro High',
      brand: 'Nike',
      price: 170,
      size: '10',
      condition: 'New',
      image: '/images/jordan1.jpg',
      seller: 'SneakerHead123'
    },
    {
      id: 2,
      name: 'Adidas Yeezy Boost 350 V2',
      brand: 'Adidas',
      price: 220,
      size: '9.5',
      condition: 'Used - Excellent',
      image: '/images/yeezy350.jpg',
      seller: 'KickCollector'
    },
    {
      id: 3,
      name: 'Nike Dunk Low Panda',
      brand: 'Nike',
      price: 110,
      size: '11',
      condition: 'New',
      image: '/images/dunkpanda.jpg',
      seller: 'SoleSearcher'
    }
  ];
  
  res.json(mockSneakers);
});

// Start server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});