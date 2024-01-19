import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/repositories/movie_repository.dart';
import 'package:flutter_movies_app/domain/helpers/date_helper.dart';
import 'package:flutter_movies_app/domain/helpers/time_helper.dart';
import 'package:flutter_movies_app/domain/models/movie_model.dart';
import 'package:flutter_movies_app/ui/theme/app_theme.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/widgets/appbars/collapsing_image_app_bar.dart';
import 'package:flutter_movies_app/ui/widgets/error_alert.dart';
import 'package:flutter_movies_app/ui/widgets/movie_info.dart';
import 'package:flutter_movies_app/ui/widgets/star.dart';

class MovieDatailScreen extends StatefulWidget {
  const MovieDatailScreen({super.key, required this.id});

  final int id;

  @override
  State<MovieDatailScreen> createState() => _MovieDatailScreenState();
}

class _MovieDatailScreenState extends State<MovieDatailScreen> {
  bool loader = false;
  late Future<Movie> movie;

  @override
  void initState() {
    super.initState();
    movie = MovieRepository.movieDetail(widget.id);
  }

  void _showLoader(bool show) => setState(() => loader = show);

  void _showDeleteDialog(BuildContext context, Movie movie) {
    showDialog(
      context: context,
      builder: (context) {
        return confirmDelete(context, movie.title, () => _deleteMovie(movie));
      },
    );
  }

  void _deleteMovie(Movie movie) {
    _showLoader(true);
    MovieRepository.deleteMovie(movie.id).then((value) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            movie = MovieRepository.movieDetail(widget.id);
          });
        }),
        child: FutureBuilder(
          future: movie,
          builder: (context, snapshot) {
            Movie detail = snapshot.data ?? Movie.empty();
            if (snapshot.hasError) {
              return ErrorAlert(text: snapshot.error.toString());
            } else if (snapshot.hasData) {
              return CustomScrollView(
                clipBehavior: Clip.none,
                slivers: [
                  CollapsingImageAppBar(
                    title: detail.title,
                    image: detail.image ?? "",
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
                              child: Stars(rating: detail.rating),
                            ),
                            MovieInfo(
                              label: "DURATA",
                              text: detail.duration.formatDuration(),
                            ),
                            MovieInfo(
                              label: "USCITA",
                              text: detail.releaseDate.formatDate(),
                            ),
                            MovieInfo(label: "REGISTA", text: detail.director),
                            MovieInfo(label: "GENERE", text: detail.genre),
                            MovieInfo(label: "TRAMA", text: detail.description),
                            height_16,
                            ElevatedButton(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                "/edit",
                                arguments: detail,
                              ),
                              child: const Text("Modifica"),
                            ),
                            height_16,
                            ElevatedButton(
                              onPressed: () =>
                                  _showDeleteDialog(context, detail),
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
