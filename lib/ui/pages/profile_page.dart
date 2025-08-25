import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(radius: 36, child: Icon(Icons.person)),
          const SizedBox(height: 12),
          const Text('Guest', textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
          const SizedBox(height: 24),
          FilledButton(onPressed: () {}, child: const Text('Sign in / Create account')),
        ],
      ),
    );
  }
}
