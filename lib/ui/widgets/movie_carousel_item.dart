import 'package:flutter/material.dart';
import 'package:flutter_movies_app/domain/models/movie_model.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/widgets/movie_poster.dart';

class MovieCarouselItem extends StatelessWidget {
  const MovieCarouselItem({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        "/detail",
        arguments: movie.id,
      ),
      child: Padding(
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
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.blueGrey.shade900],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: lightShadow,
              ),
              child: Text(
                movie.title,
                style: semibold_16.copyWith(color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            MoviePoster(image: movie.image, width: 200, height: 300),
          ],
        ),
      ),
    );
  }
}
