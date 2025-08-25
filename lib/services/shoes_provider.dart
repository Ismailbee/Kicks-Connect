import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models.dart';

// Sample shoe data for development
final sampleShoes = [
  Shoe(
    id: '1',
    name: 'Air Max Classic',
    imageUrl: 'assets/images/air_max_classic.jpg',
    price: 129.99,
    sizes: [38, 39, 40, 41, 42, 43, 44],
    category: 'running',
    stock: 25,
  ),
  Shoe(
    id: '2',
    name: 'Urban Boost',
    imageUrl: 'assets/images/urban_boost.jpg',
    price: 149.99,
    sizes: [37, 38, 39, 40, 41, 42],
    category: 'lifestyle',
    stock: 15,
  ),
  Shoe(
    id: '3',
    name: 'Pro Basketball',
    imageUrl: 'assets/images/pro_basketball.jpg',
    price: 189.99,
    sizes: [39, 40, 41, 42, 43, 44, 45],
    category: 'basketball',
    stock: 12,
  ),
  Shoe(
    id: '4',
    name: 'Street Walker',
    imageUrl: 'assets/images/street_walker.jpg',
    price: 99.99,
    sizes: [36, 37, 38, 39, 40, 41],
    category: 'casual',
    stock: 30,
  ),
  Shoe(
    id: '5',
    name: 'Speed Runner',
    imageUrl: 'assets/images/speed_runner.jpg',
    price: 159.99,
    sizes: [38, 39, 40, 41, 42, 43],
    category: 'running',
    stock: 18,
  ),
  Shoe(
    id: '6',
    name: 'Classic White',
    imageUrl: 'assets/images/classic_white.jpg',
    price: 89.99,
    sizes: [37, 38, 39, 40, 41, 42, 43],
    category: 'casual',
    stock: 40,
  ),
  Shoe(
    id: '7',
    name: 'Trail Master',
    imageUrl: 'assets/images/trail_master.jpg',
    price: 179.99,
    sizes: [39, 40, 41, 42, 43, 44, 45],
    category: 'outdoor',
    stock: 8,
  ),
  Shoe(
    id: '8',
    name: 'Fashion Forward',
    imageUrl: 'assets/images/fashion_forward.jpg',
    price: 199.99,
    sizes: [36, 37, 38, 39, 40, 41, 42],
    category: 'lifestyle',
    stock: 22,
  ),
];

// Provider for all shoes
final shoesProvider = Provider<List<Shoe>>((ref) {
  return sampleShoes;
});

// Provider for a specific shoe by ID
final shoeByIdProvider = Provider.family<Shoe?, String>((ref, id) {
  final shoes = ref.watch(shoesProvider);
  try {
    return shoes.firstWhere((shoe) => shoe.id == id);
  } catch (e) {
    return null; // Shoe not found
  }
});

// Provider for shoes filtered by category
final shoesByCategoryProvider = Provider.family<List<Shoe>, String?>((ref, category) {
  final shoes = ref.watch(shoesProvider);
  if (category == null || category.isEmpty || category.toLowerCase() == 'all') {
    return shoes;
  }
  return shoes.where((shoe) => shoe.category.toLowerCase() == category.toLowerCase()).toList();
});

// Provider for available categories
final categoriesProvider = Provider<List<String>>((ref) {
  final shoes = ref.watch(shoesProvider);
  final categories = shoes.map((shoe) => shoe.category).toSet().toList();
  categories.sort();
  return ['All', ...categories];
});