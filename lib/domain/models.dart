class Shoe {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final List<int> sizes;
  final String category;
  final int stock;

  Shoe({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.sizes,
    required this.category,
    required this.stock,
  });

  factory Shoe.fromMap(String id, Map<String, dynamic> map) => Shoe(
        id: id,
        name: map['name'] ?? '',
        imageUrl: map['imageUrl'] ?? '',
        price: (map['price'] ?? 0).toDouble(),
        sizes: List<int>.from(map['sizes'] ?? []),
        category: map['category'] ?? 'general',
        stock: (map['stock'] ?? 0) as int,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'imageUrl': imageUrl,
        'price': price,
        'sizes': sizes,
        'category': category,
        'stock': stock,
      };
}

class OrderItem {
  final String shoeId;
  final int size;
  final int quantity;
  final double price;

  OrderItem({required this.shoeId, required this.size, required this.quantity, required this.price});

  factory OrderItem.fromMap(Map<String, dynamic> map) => OrderItem(
        shoeId: map['shoeId'],
        size: map['size'],
        quantity: map['quantity'],
        price: (map['price'] ?? 0).toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'shoeId': shoeId,
        'size': size,
        'quantity': quantity,
        'price': price,
      };
}

class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double total;
  final String status; // pending, paid, shipped, delivered, cancelled
  final DateTime createdAt;

  Order({required this.id, required this.userId, required this.items, required this.total, required this.status, required this.createdAt});

  factory Order.fromMap(String id, Map<String, dynamic> map) => Order(
        id: id,
        userId: map['userId'],
        items: (map['items'] as List).map((e) => OrderItem.fromMap(Map<String, dynamic>.from(e))).toList(),
        total: (map['total'] ?? 0).toDouble(),
        status: map['status'] ?? 'pending',
        createdAt: DateTime.fromMillisecondsSinceEpoch((map['createdAt'] ?? 0) as int),
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'items': items.map((e) => e.toMap()).toList(),
        'total': total,
        'status': status,
        'createdAt': createdAt.millisecondsSinceEpoch,
      };
}
