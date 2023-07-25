import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData buildTheme() {
    return ThemeData(
      primaryTextTheme:
          const TextTheme(headlineMedium: TextStyle(color: Colors.white)),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );
  }
}
