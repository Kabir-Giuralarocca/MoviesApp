import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/helpers/movie_helper.dart';
import 'package:flutter_movies_app/data/models/movie_model.dart';
import 'package:flutter_movies_app/data/repositories/movie_repository.dart';
import 'package:flutter_movies_app/ui/theme/app_theme.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/widgets/collapsing_title.dart';
import 'package:flutter_movies_app/ui/widgets/error_alert.dart';

class MovieDatailScreen extends StatefulWidget {
  const MovieDatailScreen({super.key, required this.movieId});

  final int movieId;

  @override
  State<MovieDatailScreen> createState() => _MovieDatailScreenState();
}

class _MovieDatailScreenState extends State<MovieDatailScreen> {
  bool loader = false;
  late Future<Movie> movie;

  @override
  void initState() {
    super.initState();
    movie = getMovie(widget.movieId);
  }

  void _showLoader(bool show) => setState(() => loader = show);

  void _showDeleteDialog(BuildContext context, Movie movie) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Sei sicuro di voler eliminare ${movie.title}?",
                  style: bold_14,
                ),
                height_16,
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _deleteMovie(movie);
                  },
                  style: deleteStyle(context),
                  child: const Text("Elimina"),
                ),
                height_8,
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Annulla"),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteMovie(Movie movie) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      Navigator.pop(context);
    } else {
      _showLoader(true);
      deleteMovie(movie).then((value) {
        _showLoader(false);
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        _showLoader(false);
        ScaffoldMessenger.of(context).showSnackBar(
          messageSnackBar(
            message: error.toString(),
            isError: true,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            movie = getMovie(widget.movieId);
          });
        }),
        child: FutureBuilder(
          future: movie,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorAlert(text: snapshot.error.toString());
            } else if (snapshot.hasData) {
              return CustomScrollView(
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
                        snapshot.data!.title,
                        style: bold_20,
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      titlePadding: const EdgeInsets.all(16),
                      title: CollapsingTitle(
                        visibleOnCollapsed: true,
                        child: Text(
                          snapshot.data!.title,
                          style: bold_20.copyWith(shadows: imageShadow),
                        ),
                      ),
                      background: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(snapshot.data!.image ?? ""),
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
                                  for (var i = 0;
                                      i < snapshot.data!.rating;
                                      i++)
                                    Icon(
                                      Icons.star,
                                      size: 24,
                                      color: Colors.amber,
                                      shadows: lightShadow,
                                    ),
                                ],
                              ),
                            ),
                            MovieInfo(
                                label: "DURATA",
                                text: snapshot.data!.duration.formatDuration()),
                            MovieInfo(
                                label: "USCITA",
                                text: snapshot.data!.releaseDate.formatDate()),
                            MovieInfo(
                                label: "REGISTA",
                                text: snapshot.data!.director),
                            MovieInfo(
                                label: "GENERE", text: snapshot.data!.genre),
                            MovieInfo(
                                label: "TRAMA",
                                text: snapshot.data!.description),
                            height_16,
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pushNamed(
                                "/edit",
                                arguments: snapshot.data!,
                              ),
                              child: const Text("Modifica"),
                            ),
                            height_16,
                            ElevatedButton(
                              onPressed: () =>
                                  _showDeleteDialog(context, snapshot.data!),
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
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
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
