import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/widgets/form_input.dart';
import 'package:flutter_movies_app/ui/widgets/star.dart';

class RatingStarsInput extends StatelessWidget {
  const RatingStarsInput({
    super.key,
    required this.rating,
    required this.onTap,
  });

  final int rating;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: formInputDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "VALUTAZIONE",
            style: semibold_12.copyWith(color: Colors.grey[700]),
          ),
          height_4,
          Stars(
            size: 36,
            rating: rating,
            onTap: (index) => onTap(index),
          ),
        ],
      ),
    );
  }
}
