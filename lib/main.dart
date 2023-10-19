import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/screens/home_screen.dart';
import 'package:flutter_movies_app/ui/screens/login_screen.dart';
import 'package:flutter_movies_app/ui/screens/register_screen.dart';
import 'package:flutter_movies_app/ui/theme/app_theme.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
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
        "/register": (context) => const RegisterScreen(),
        "/home": (context) => const HomeScreen(),
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
