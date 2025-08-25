export interface Sneaker {
  id: number;
  name: string;
  brand: string;
  price: number;
  size: string;
  condition: string;
  image: string;
  seller: string;
}

export interface User {
  id: number;
  username: string;
  email: string;
  avatar?: string;
}