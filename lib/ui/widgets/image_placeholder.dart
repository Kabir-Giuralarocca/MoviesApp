import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({
    super.key,
    this.height = 180,
    this.width = 120,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: imageShadow,
        color: Colors.blueGrey[900],
      ),
      child: const Center(
        child: Icon(Icons.movie, size: 48, color: Colors.white),
      ),
    );
  }
}
