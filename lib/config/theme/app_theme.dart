import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme({bool isDarkMode = true}) => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.amber,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor: const Color(0x00060606),
      );
}
