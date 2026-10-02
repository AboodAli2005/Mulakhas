import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'library_providers.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final Ref _ref;

  ThemeNotifier(this._ref) : super(ThemeMode.light) {
    _loadTheme();
  }

  void _loadTheme() {
    final storage = _ref.read(storageServiceProvider);
    state = storage.isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    final isDark = state == ThemeMode.dark;
    state = isDark ? ThemeMode.light : ThemeMode.dark;
    _ref.read(storageServiceProvider).setDarkMode(!isDark);
  }

  void setTheme(ThemeMode mode) {
    state = mode;
    _ref.read(storageServiceProvider).setDarkMode(mode == ThemeMode.dark);
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier(ref);
});
