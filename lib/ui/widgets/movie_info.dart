import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';

class MovieInfo extends StatelessWidget {
  const MovieInfo({
    super.key,
    required this.label,
    this.text = "",
    this.child,
  });

  final String label;
  final String text;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: bold_20),
        child ?? Text(text, style: medium_16),
        height_16,
      ],
    );
  }
}
