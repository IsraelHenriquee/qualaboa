import 'package:flutter/material.dart';

class AppTheme {
  // Cores principais do app baseadas na imagem
  static const Color primaryColor = Color(0xFFE53935); // Vermelho
  static const Color backgroundColor = Colors.white;
  static const Color cardColor = Colors.white;
  static const Color textColor = Colors.black87;
  static const Color secondaryTextColor = Colors.black54;
  static const Color chipColor = Color(0xFFE0E0E0); // Cinza claro para chips

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: primaryColor.withOpacity(0.8),
        background: backgroundColor,
        surface: cardColor,
        onSurface: textColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: backgroundColor,
      cardTheme: CardTheme(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
        titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
        bodyLarge: TextStyle(fontSize: 16, color: textColor),
        bodyMedium: TextStyle(fontSize: 14, color: secondaryTextColor),
      ),
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: Colors.grey[500]),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  static ThemeData get darkTheme {
    // Para este projeto, vamos manter apenas o tema claro conforme a imagem
    return lightTheme;
  }
}
