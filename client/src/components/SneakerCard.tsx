import React from 'react';
import { Sneaker } from '../types';

interface SneakerCardProps {
  sneaker: Sneaker;
}

const SneakerCard: React.FC<SneakerCardProps> = ({ sneaker }) => {
  return (
    <div className="sneaker-card">
      <div className="sneaker-image">
        <div className="placeholder-image">👟</div>
      </div>
      <div className="sneaker-info">
        <h3>{sneaker.name}</h3>
        <p className="brand">{sneaker.brand}</p>
        <p className="price">${sneaker.price}</p>
        <p className="size">Size: {sneaker.size}</p>
        <p className="condition">{sneaker.condition}</p>
        <p className="seller">Seller: {sneaker.seller}</p>
      </div>
    </div>
  );
};

export default SneakerCard;