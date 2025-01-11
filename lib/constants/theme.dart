import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData getThemeData(ThemeMode themeMode) {
    if (themeMode == ThemeMode.light) {
      return ThemeData(
        brightness: Brightness.light,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          titleSmall: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          bodySmall: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.normal),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          labelLarge: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          labelMedium: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
          labelSmall: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        useMaterial3: true,
      );
    } else {
      return ThemeData(
        brightness: Brightness.dark,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          titleSmall: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          bodySmall: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          labelLarge: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          labelMedium: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          labelSmall: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        useMaterial3: true,
      );
    }
  }
}
