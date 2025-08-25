import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'ui/pages/home_page.dart';
import 'ui/pages/product_list_page.dart';
import 'ui/pages/product_detail_page.dart';
import 'ui/pages/cart_page.dart';
import 'ui/pages/checkout_page.dart';
import 'ui/pages/profile_page.dart';
import 'ui/pages/admin/admin_dashboard_page.dart';

GoRouter createRouter(WidgetRef ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (context, state) => const ProductListPage(),
      ),
      GoRoute(
        path: '/product/:id',
        name: 'product',
        builder: (context, state) => ProductDetailPage(productId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        path: '/checkout',
        name: 'checkout',
        builder: (context, state) => const CheckoutPage(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/admin',
        name: 'admin',
        builder: (context, state) => const AdminDashboardPage(),
      ),
    ],
  );
}
