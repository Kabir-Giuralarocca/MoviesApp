import 'package:flutter/material.dart';
import 'package:flutter_movies_app/router.dart';
import 'package:flutter_movies_app/ui/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  Intl.defaultLocale = "it";
  initializeDateFormatting();
  setPathUrlStrategy(); // to implement url navigation
  GoRouter.optionURLReflectsImperativeAPIs = true; // for working with Navigator
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      theme: AppTheme.theme,
      routerConfig: AppRouter.router,
    );
  }
}


// Cors for network images
// flutter run --web-browser-flag "--disable-web-security"
//
// oppure edit launch.json
// {
//   "name": "flutter_movies_app",
//   "request": "launch",
//   "type": "dart",
//   "args": [
//   "--web-browser-flag", 
//   "--disable-web-security",
//   ]
// }
