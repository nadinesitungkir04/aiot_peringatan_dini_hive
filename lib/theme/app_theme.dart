import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF176B63)),
    scaffoldBackgroundColor: const Color(0xFFF5F8F7),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFE1F1EB)),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
  );
}
