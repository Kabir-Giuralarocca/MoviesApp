import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';

class CollapsingAppBar extends StatelessWidget {
  const CollapsingAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 120,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(title, style: bold_24.copyWith(color: Colors.black)),
      ),
    );
  }
}
