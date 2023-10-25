import 'package:flutter/material.dart';
import 'package:flutter_movies_app/router.dart';
import 'package:flutter_movies_app/ui/theme/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  Intl.defaultLocale = "it";
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      theme: AppTheme.theme,
      initialRoute: "/login",
      onGenerateRoute: (settings) => onGenerateRoute(settings),
    );
  }
}


// Cors for network images
// flutter run -d chrome --web-browser-flag "--disable-web-security"
//
// oppure
//
// 1 - Go to flutter\packages\flutter_tools\lib\src\web and open the file chrome.dart.
// 2 - Find '--disable-extensions'
// 3 - Add '--disable-web-security'
//
// Go to flutter\bin\cache and remove a file named: flutter_tools.stamp (every session)


