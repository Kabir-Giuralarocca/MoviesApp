import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/models/movie_model.dart';
import 'package:flutter_movies_app/ui/screens/create_movie_screen.dart';
import 'package:flutter_movies_app/ui/screens/edit_movie_screen.dart';
import 'package:flutter_movies_app/ui/screens/home_screen.dart';
import 'package:flutter_movies_app/ui/screens/login_screen.dart';
import 'package:flutter_movies_app/ui/screens/movie_detail_screen.dart';
import 'package:flutter_movies_app/ui/screens/movies_screen.dart';
import 'package:flutter_movies_app/ui/screens/register_screen.dart';
import 'package:flutter_movies_app/ui/theme/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  Intl.defaultLocale = "it";
  initializeDateFormatting();
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
      onGenerateRoute: (settings) {
        var args = settings.arguments;
        var routes = {
          "/": (context) => const LoginScreen(),
          "/register": (context) => const RegisterScreen(),
          "/home": (context) => const HomeScreen(),
          "/movies": (context) => MoviesScreen(args: args as MoviesListArgs?),
          "/detail": (context) => MovieDatailScreen(movieId: args as int),
          "/create": (context) => const CreateMovieScreen(),
          "/edit": (context) => EditMovieScreen(movie: args as Movie),
        };
        WidgetBuilder builder = routes[settings.name]!;
        return MaterialPageRoute(builder: (context) => builder(context));
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

// Cors for network images
// flutter run -d chrome --web-browser-flag "--disable-web-security"

// 1- Go to flutter\bin\cache and remove a file named: flutter_tools.stamp

// 2- Go to flutter\packages\flutter_tools\lib\src\web and open the file chrome.dart.

// 3- Find '--disable-extensions'

// 4- Add '--disable-web-security'
