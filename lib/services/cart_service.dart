import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models.dart';

// Cart item with size information
class CartItem {
  final Shoe shoe;
  final int size;
  final int quantity;

  CartItem({
    required this.shoe,
    required this.size,
    required this.quantity,
  });

  CartItem copyWith({
    Shoe? shoe,
    int? size,
    int? quantity,
  }) {
    return CartItem(
      shoe: shoe ?? this.shoe,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => shoe.price * quantity;
}

// Cart state notifier
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItem(Shoe shoe, int size, {int quantity = 1}) {
    final existingIndex = state.indexWhere(
      (item) => item.shoe.id == shoe.id && item.size == size,
    );

    if (existingIndex >= 0) {
      // Update existing item quantity
      final existingItem = state[existingIndex];
      final updatedItem = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
      state = [
        ...state.sublist(0, existingIndex),
        updatedItem,
        ...state.sublist(existingIndex + 1),
      ];
    } else {
      // Add new item
      state = [...state, CartItem(shoe: shoe, size: size, quantity: quantity)];
    }
  }

  void removeItem(String shoeId, int size) {
    state = state.where((item) => 
      !(item.shoe.id == shoeId && item.size == size)
    ).toList();
  }

  void updateQuantity(String shoeId, int size, int newQuantity) {
    if (newQuantity <= 0) {
      removeItem(shoeId, size);
      return;
    }

    final index = state.indexWhere(
      (item) => item.shoe.id == shoeId && item.size == size,
    );

    if (index >= 0) {
      final updatedItem = state[index].copyWith(quantity: newQuantity);
      state = [
        ...state.sublist(0, index),
        updatedItem,
        ...state.sublist(index + 1),
      ];
    }
  }

  void clearCart() {
    state = [];
  }

  double get totalPrice {
    return state.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  int get totalItems {
    return state.fold(0, (sum, item) => sum + item.quantity);
  }
}

// Cart provider
final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

// Computed providers for cart totals
final cartTotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0.0, (sum, item) => sum + item.totalPrice);
});

final cartItemCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0, (sum, item) => sum + item.quantity);
});