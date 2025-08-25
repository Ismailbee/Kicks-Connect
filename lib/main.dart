import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase init is optional in dev; guarded to not crash on web w/o config
  try {
    await Firebase.initializeApp();
  } catch (_) {}
  runApp(const ProviderScope(child: KicksConnectApp()));
}

class KicksConnectApp extends ConsumerWidget {
  const KicksConnectApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter router = createRouter(ref);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Kicks Connect',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
