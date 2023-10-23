import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/widgets/base_shimmer.dart';

class MovieCarouselItemShimmer extends StatelessWidget {
  const MovieCarouselItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 268),
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
            width: 232,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: lightShadow,
            ),
            child: BaseShimmer(
              child: Container(
                height: 12,
                width: double.infinity,
                color: Colors.white,
              ),
            ),
          ),
          BaseShimmer(
            child: Container(
              height: 300,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: imageShadow,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
