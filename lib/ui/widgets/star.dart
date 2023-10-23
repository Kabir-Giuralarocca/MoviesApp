import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  const Stars({
    super.key,
    this.size = 24,
    this.onTap,
    required this.rating,
  });

  final double size;
  final int rating;
  final void Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < 5; i++)
          GestureDetector(
            onTap: onTap != null ? () => onTap!(i) : null,
            child: Icon(
              rating > i ? Icons.star : Icons.star_border,
              size: size,
              color: rating > i ? Colors.amber : Colors.grey,
            ),
          ),
      ],
    );
  }
}
