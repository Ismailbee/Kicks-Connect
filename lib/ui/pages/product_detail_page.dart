import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../services/shoes_provider.dart';
import '../services/cart_service.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  final String productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  int? selectedSize;

  @override
  Widget build(BuildContext context) {
    final shoe = ref.watch(shoeByIdProvider(widget.productId));
    final cartItemCount = ref.watch(cartItemCountProvider);

    if (shoe == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Product not found')),
        body: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text('Product not found', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('The requested product could not be found.'),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product details'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () => context.go('/cart'),
              ),
              if (cartItemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$cartItemCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1.2,
            child: Container(
              color: Colors.grey.shade300,
              child: const Icon(
                Icons.image,
                size: 120,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shoe.name,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Category: ${shoe.category}',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${shoe.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      shoe.stock > 10 
                          ? Icons.check_circle 
                          : shoe.stock > 0 
                              ? Icons.warning 
                              : Icons.cancel,
                      color: shoe.stock > 10 
                          ? Colors.green 
                          : shoe.stock > 0 
                              ? Colors.orange 
                              : Colors.red,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${shoe.stock} in stock',
                      style: TextStyle(
                        color: shoe.stock > 10 
                            ? Colors.green 
                            : shoe.stock > 0 
                                ? Colors.orange 
                                : Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Sizes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: shoe.sizes.map((size) {
                    final isSelected = selectedSize == size;
                    return ChoiceChip(
                      label: Text('$size'),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedSize = selected ? size : null;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'A premium ${shoe.category} shoe designed for maximum comfort and performance. '
                  'Featuring high-quality materials and innovative design for ${shoe.category} activities.',
                  style: const TextStyle(height: 1.5),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: selectedSize == null || shoe.stock == 0
                ? null
                : () {
                    ref.read(cartProvider.notifier).addItem(shoe, selectedSize!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${shoe.name} (Size $selectedSize) added to cart'),
                        action: SnackBarAction(
                          label: 'View Cart',
                          onPressed: () => context.go('/cart'),
                        ),
                      ),
                    );
                  },
            child: Text(
              selectedSize == null 
                  ? 'Select a size' 
                  : shoe.stock == 0 
                      ? 'Out of stock' 
                      : 'Add to cart',
            ),
          ),
        ),
      ),
    );
  }
}
