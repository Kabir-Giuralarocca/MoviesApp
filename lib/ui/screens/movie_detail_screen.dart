import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/helpers/movie_helper.dart';
import 'package:flutter_movies_app/data/models/movie_model.dart';
import 'package:flutter_movies_app/ui/theme/app_theme.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/widgets/collapsing_title.dart';

class MovieDatailScreen extends StatelessWidget {
  const MovieDatailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)?.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        clipBehavior: Clip.none,
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 600,
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
            centerTitle: true,
            title: CollapsingTitle(
              child: Text(
                movie.title,
                style: bold_20,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.all(16),
              title: CollapsingTitle(
                visibleOnCollapsed: true,
                child: Text(
                  movie.title,
                  style: bold_20.copyWith(shadows: imageShadow),
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(movie.image ?? ""),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4),
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList.list(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MovieInfo(
                      label: "VALUTAZIONE",
                      child: Row(
                        children: [
                          for (var i = 0; i < movie.rating; i++)
                            Icon(
                              Icons.star,
                              size: 24,
                              color: Colors.amber,
                              shadows: lightShadow,
                            ),
                        ],
                      ),
                    ),
                    MovieInfo(label: "DURATA", text: movie.formatDuration()),
                    MovieInfo(label: "USCITA", text: movie.formatDate()),
                    MovieInfo(label: "REGISTA", text: movie.director),
                    MovieInfo(label: "GENERE", text: movie.genre),
                    MovieInfo(label: "TRAMA", text: movie.description),
                    height_16,
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Modifica"),
                    ),
                    height_16,
                    ElevatedButton(
                      onPressed: () {},
                      style: deleteStyle(context),
                      child: const Text("Elimina"),
                    ),
                    height_16,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MovieInfo extends StatelessWidget {
  const MovieInfo({
    super.key,
    required this.label,
    this.text,
    this.child,
  });

  final String label;
  final String? text;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: bold_20,
        ),
        text != null
            ? Text(
                text ?? "",
                style: medium_16,
              )
            : child ?? Container(),
        height_16,
      ],
    );
  }
}
