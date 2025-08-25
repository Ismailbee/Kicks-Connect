import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.black, brightness: Brightness.light),
  useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.white, brightness: Brightness.dark),
  useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
