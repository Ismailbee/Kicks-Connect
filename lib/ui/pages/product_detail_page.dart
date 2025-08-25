import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product details')),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1.2,
            child: Container(color: Colors.grey.shade300),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Shoe Name', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('ID: $productId', style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                const Text('\$129.00', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                const Text('Sizes'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: List.generate(6, (i) => ChoiceChip(label: Text('${38 + i}'), selected: i == 0)),
                ),
                const SizedBox(height: 16),
                const Text('Description'),
                const SizedBox(height: 8),
                const Text('A modern athletic shoe designed for comfort and performance.'),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: () {},
            child: const Text('Add to cart'),
          ),
        ),
      ),
    );
  }
}
