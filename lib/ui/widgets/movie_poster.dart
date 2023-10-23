import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/widgets/image_placeholder.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({
    super.key,
    this.image,
    this.width = 120,
    this.height = 180,
  });

  final String? image;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: imageShadow,
        color: Colors.transparent,
      ),
      child: Image.network(
        image ?? "",
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return ImagePlaceholder(height: height, width: width);
        },
      ),
    );
  }
}
