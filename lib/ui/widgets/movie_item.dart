import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/models/movie_model.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:intl/intl.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    super.key,
    required this.movie,
  });

  final Movie movie;

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
                Text(
                  movie.title,
                  style: bold_14,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    for (var i = 0; i < movie.rating; i++)
                      Icon(
                        Icons.star,
                        size: 10,
                        color: Colors.amber,
                        shadows: lightShadow,
                      ),
                  ],
                ),
                height_4,
                Text(
                  "${movie.director}  •  ${DateFormat.yMd().format(movie.releaseDate)}",
                  style: medium_10.copyWith(
                    color: Colors.grey[700],
                  ),
                ),
                filler,
                Text(
                  movie.description,
                  style: regular_10.copyWith(
                    color: Colors.grey[700],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              ],
            ),
          ),
          MoviePoster(image: movie.image ?? ""),
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  const MoviePoster({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: imageShadow,
        color: Colors.white,
      ),
      child: Image.network(
        image,
        height: 180,
        width: 120,
        fit: BoxFit.cover,
      ),
    );
  }
}
