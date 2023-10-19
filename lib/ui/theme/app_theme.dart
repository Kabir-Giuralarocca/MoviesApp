import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey[200],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[200],
      scrolledUnderElevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(semibold_16),
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.pressed)
              ? Colors.grey[900]
              : Colors.black,
        ),
        minimumSize: const MaterialStatePropertyAll(Size.fromHeight(44)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(semibold_16),
        foregroundColor: const MaterialStatePropertyAll(Colors.black),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.pressed)
              ? Colors.grey[100]
              : Colors.transparent,
        ),
        minimumSize: const MaterialStatePropertyAll(Size.fromHeight(44)),
        side: const MaterialStatePropertyAll(
          BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.zero,
      isDense: true,
      hintStyle: regular_14.copyWith(color: Colors.grey),
      suffixIconColor: Colors.grey[700],
      errorStyle: regular_12.copyWith(color: Colors.red),
      errorMaxLines: 3,
      border: InputBorder.none,
    ),
  );
}
