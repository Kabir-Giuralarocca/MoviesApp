import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/screens/login_screen.dart';
import 'package:flutter_movies_app/ui/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      theme: AppTheme.theme,
      initialRoute: "/",
      routes: {
        "/": (context) => const LoginScreen(),
      },
    );
  }
}
