import 'package:flutter/material.dart';
import 'package:qualaboa/screens/splash_screen.dart';
import 'package:qualaboa/screens/main_navigation.dart';
import 'package:qualaboa/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qual é a Boa?',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      // A tela inicial continua sendo a SplashScreen, que depois redirecionará para a MainNavigation
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
