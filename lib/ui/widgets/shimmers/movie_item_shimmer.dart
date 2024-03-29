import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/widgets/shimmers/base_shimmer.dart';

class MovieItemShimmer extends StatelessWidget {
  const MovieItemShimmer({
    super.key,
    this.horizontalPadding = false,
  });

  final bool horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: horizontalPadding ? 16 : 0,
      ),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            height: 180,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 16, left: 16),
            padding: const EdgeInsets.fromLTRB(120, 16, 16, 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: lightShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseShimmer(
                  child: Container(
                    height: 12,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                  ),
                ),
                height_4,
                BaseShimmer(
                  child: Container(
                    height: 12,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                  ),
                ),
                height_4,
                BaseShimmer(
                  child: Container(
                    height: 12,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          BaseShimmer(
            child: Container(
              height: 180,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
