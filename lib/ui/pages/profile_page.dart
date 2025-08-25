import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Simple authentication state provider (placeholder)
final authStateProvider = StateProvider<bool>((ref) => false);
final userNameProvider = StateProvider<String>((ref) => 'Guest User');

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(authStateProvider);
    final userName = ref.watch(userNameProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Header
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: isAuthenticated ? Colors.blue : Colors.grey,
                    child: Icon(
                      isAuthenticated ? Icons.person : Icons.person_outline,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isAuthenticated ? userName : 'Guest',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isAuthenticated ? 'Welcome back!' : 'Sign in to access your account',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Authentication Button
          if (!isAuthenticated)
            FilledButton(
              onPressed: () => _showAuthDialog(context, ref),
              child: const Text('Sign in / Create account'),
            )
          else
            OutlinedButton(
              onPressed: () {
                ref.read(authStateProvider.notifier).state = false;
                ref.read(userNameProvider.notifier).state = 'Guest User';
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Signed out successfully')),
                );
              },
              child: const Text('Sign out'),
            ),

          if (isAuthenticated) ...[
            const SizedBox(height: 24),
            
            // Menu Items
            const Text(
              'Account',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _MenuItem(
              icon: Icons.shopping_bag_outlined,
              title: 'Order History',
              onTap: () => _showComingSoon(context, 'Order History'),
            ),
            _MenuItem(
              icon: Icons.favorite_outline,
              title: 'Wishlist',
              onTap: () => _showComingSoon(context, 'Wishlist'),
            ),
            _MenuItem(
              icon: Icons.location_on_outlined,
              title: 'Addresses',
              onTap: () => _showComingSoon(context, 'Address Management'),
            ),
            _MenuItem(
              icon: Icons.payment_outlined,
              title: 'Payment Methods',
              onTap: () => _showComingSoon(context, 'Payment Methods'),
            ),

            const SizedBox(height: 24),
            const Text(
              'Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _MenuItem(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              onTap: () => _showComingSoon(context, 'Notification Settings'),
            ),
            _MenuItem(
              icon: Icons.dark_mode_outlined,
              title: 'Theme',
              onTap: () => _showComingSoon(context, 'Theme Settings'),
            ),
            _MenuItem(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () => _showComingSoon(context, 'Help & Support'),
            ),

            const SizedBox(height: 24),
            _MenuItem(
              icon: Icons.admin_panel_settings,
              title: 'Admin Dashboard',
              onTap: () => context.go('/admin'),
              isAdmin: true,
            ),
          ],
        ],
      ),
    );
  }

  void _showAuthDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Demo Authentication'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('This is a demo authentication system.'),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Your Name',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final name = nameController.text.trim();
              if (name.isNotEmpty) {
                ref.read(authStateProvider.notifier).state = true;
                ref.read(userNameProvider.notifier).state = name;
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Welcome, $name!')),
                );
              }
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature - Coming soon! Connect Firebase Auth for full functionality.'),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isAdmin;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: isAdmin ? Colors.orange : null,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isAdmin ? Colors.orange : null,
            fontWeight: isAdmin ? FontWeight.bold : null,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
