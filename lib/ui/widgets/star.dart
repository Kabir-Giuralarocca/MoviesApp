import 'package:flutter/material.dart';

class Star extends StatelessWidget {
  const Star({
    super.key,
    this.size = 24,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.star, size: size, color: Colors.amber);
  }
}
