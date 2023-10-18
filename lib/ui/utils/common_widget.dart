import 'package:flutter/material.dart';

const height_4 = SizedBox(height: 4);
const height_8 = SizedBox(height: 8);
const height_16 = SizedBox(height: 16);
const height_24 = SizedBox(height: 24);
const height_36 = SizedBox(height: 36);
const height_64 = SizedBox(height: 64);

// Shadows
List<BoxShadow> lightShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.08),
    spreadRadius: 5,
    blurRadius: 16,
    offset: const Offset(0, 2),
  )
];
