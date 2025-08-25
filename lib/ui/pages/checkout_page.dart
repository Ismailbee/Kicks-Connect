import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Shipping Info', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: 'Full name')),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: 'Address')),
            const SizedBox(height: 16),
            const Text('Payment', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Stripe/Paystack/Flutterwave integration goes here'),
            const Spacer(),
            FilledButton(onPressed: () {}, child: const Text('Pay now')),
          ],
        ),
      ),
    );
  }
}
