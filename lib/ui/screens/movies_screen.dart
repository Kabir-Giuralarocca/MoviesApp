import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/repositories/movie_repository.dart';
import 'package:flutter_movies_app/domain/models/movie_model.dart';
import 'package:flutter_movies_app/ui/widgets/appbars/collapsing_app_bar.dart';
import 'package:flutter_movies_app/ui/widgets/error_alert.dart';
import 'package:flutter_movies_app/ui/widgets/list_description.dart';
import 'package:flutter_movies_app/ui/widgets/movie_item.dart';
import 'package:flutter_movies_app/ui/widgets/shimmers/movie_item_shimmer.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({
    super.key,
    this.args,
  });

  final MoviesListArgs? args;

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late final bool showTop;
  late Future<List<Movie>> movieList;
  List<Movie> topRated = [];
  int moviesCount = 0;

  @override
  void initState() {
    super.initState();
    showTop = widget.args?.showTop ?? false;
    movieList = MovieRepository.movies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            movieList = MovieRepository.movies();
          });
        }),
        child: FutureBuilder(
          future: movieList,
          builder: (context, snapshot) {
            snapshot.data?.sort((a, b) => b.id.compareTo(a.id));
            List<Movie> movies = snapshot.data ?? [];
            if (snapshot.hasError) {
              return ErrorAlert(text: snapshot.error.toString());
            } else {
              if (snapshot.hasData) {
                topRated = movies.where((movie) => movie.rating == 5).toList();
                moviesCount = showTop ? topRated.length : movies.length;
              }
              return CustomScrollView(
                clipBehavior: Clip.none,
                slivers: [
                  CollapsingAppBar(
                    title: showTop ? "Top Rated Movies" : "Movies",
                  ),
                  ListDescription(
                    text: showTop
                        ? "Qui puoi vedere la raccolta di tutti i tuoi film preferiti (5 stars rated), che hai inserito nell'applicazione."
                        : "Qui puoi vedere la raccolta di tutti i tuoi film che hai inserito nell'applicazione.",
                  ),
                  SliverList.builder(
                    itemCount: snapshot.hasData ? moviesCount : 5,
                    itemBuilder: (context, index) {
                      if (snapshot.hasData) {
                        return MovieItem(
                          movie: showTop ? topRated[index] : movies[index],
                          horizontalPadding: true,
                        );
                      } else {
                        return const MovieItemShimmer(horizontalPadding: true);
                      }
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class MoviesListArgs {
  final bool showTop;

  MoviesListArgs(this.showTop);
}
