import React, { useEffect, useState } from 'react';
import './App.css';
import { Sneaker } from './types';
import SneakerCard from './components/SneakerCard';

function App() {
  const [sneakers, setSneakers] = useState<Sneaker[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchSneakers();
  }, []);

  const fetchSneakers = async () => {
    try {
      const response = await fetch('http://localhost:5000/api/sneakers');
      const data = await response.json();
      setSneakers(data);
      setLoading(false);
    } catch (error) {
      console.error('Error fetching sneakers:', error);
      setLoading(false);
    }
  };

  if (loading) {
    return <div className="loading">Loading sneakers...</div>;
  }

  return (
    <div className="App">
      <header className="App-header">
        <h1>👟 Kicks-Connect</h1>
        <p>Connect with sneaker enthusiasts and find your perfect kicks!</p>
      </header>
      
      <main className="main-content">
        <section className="hero">
          <h2>Featured Sneakers</h2>
          <p>Discover amazing sneakers from our community</p>
        </section>
        
        <section className="sneakers-grid">
          {sneakers.map((sneaker) => (
            <SneakerCard key={sneaker.id} sneaker={sneaker} />
          ))}
        </section>
      </main>
      
      <footer className="App-footer">
        <p>&copy; 2024 Kicks-Connect. Connecting sneaker lovers worldwide.</p>
      </footer>
    </div>
  );
}

export default App;
