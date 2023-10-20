import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';

class MovieItemShimmer extends StatelessWidget {
  const MovieItemShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
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
                    color: Colors.white,
                  ),
                ),
                height_4,
                BaseShimmer(
                  child: Container(
                    height: 12,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
                height_4,
                BaseShimmer(
                  child: Container(
                    height: 12,
                    width: 100,
                    color: Colors.white,
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
