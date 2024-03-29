import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey[200],
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Colors.blueGrey,
      onPrimary: Colors.white,
      secondary: Colors.black,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.black,
      background: Colors.grey.shade200,
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
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
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.blueGrey,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentTextStyle: regular_12.copyWith(color: Colors.white),
      actionBackgroundColor: Colors.blueGrey[900],
      actionTextColor: Colors.white,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.black,
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      headerBackgroundColor: Colors.blueGrey[900],
      headerForegroundColor: Colors.white,
    ),
  );
}

ButtonStyle? deleteStyle(BuildContext context) {
  return Theme.of(context).elevatedButtonTheme.style?.copyWith(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.pressed)
              ? Colors.red[900]
              : Colors.red,
        ),
      );
}
