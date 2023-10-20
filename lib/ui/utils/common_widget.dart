import 'package:flutter/material.dart';

const height_4 = SizedBox(height: 4);
const height_8 = SizedBox(height: 8);
const height_16 = SizedBox(height: 16);
const height_24 = SizedBox(height: 24);
const height_36 = SizedBox(height: 36);
const height_68 = SizedBox(height: 68);

// Shadows
List<BoxShadow> lightShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.08),
    spreadRadius: 5,
    blurRadius: 16,
    offset: const Offset(0, 2),
  )
];

// Loader
Dialog loaderDialog = const Dialog(
  backgroundColor: Colors.transparent,
  surfaceTintColor: Colors.transparent,
  shadowColor: Colors.transparent,
  child: Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(color: Colors.black),
    ],
  ),
);

// SnackBar
SnackBar messageSnackBar({
  required String message,
  bool isError = false,
  String? label,
  void Function()? onPressed,
}) {
  return SnackBar(
    backgroundColor: isError ? Colors.red : Colors.blueGrey,
    content: Text(message),
    action: label != null && onPressed != null
        ? SnackBarAction(label: label, onPressed: onPressed)
        : null,
  );
}
