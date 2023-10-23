import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';

class ListDescription extends StatelessWidget {
  const ListDescription({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Text(text, style: medium_14, textAlign: TextAlign.center),
      ),
    );
  }
}
