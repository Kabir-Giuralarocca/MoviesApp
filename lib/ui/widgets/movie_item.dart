import 'package:flutter/material.dart';
import 'package:flutter_movies_app/domain/helpers/date_helper.dart';
import 'package:flutter_movies_app/domain/models/movie_model.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/widgets/movie_poster.dart';
import 'package:flutter_movies_app/ui/widgets/star.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    super.key,
    required this.movie,
    this.horizontalPadding = false,
  });

  final Movie movie;
  final bool horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        "/detail",
        arguments: movie.id,
      ),
      child: Padding(
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
                  Text(
                    movie.title,
                    style: bold_14,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Stars(size: 12, rating: movie.rating),
                  height_4,
                  Text(
                    "${movie.releaseDate.formatDate()}  •  ${movie.director}",
                    style: medium_10.copyWith(
                      color: Colors.grey[700],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
            MoviePoster(image: movie.image),
          ],
        ),
      ),
    );
  }
}
