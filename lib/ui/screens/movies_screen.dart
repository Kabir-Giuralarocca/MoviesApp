import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/models/movie_model.dart';
import 'package:flutter_movies_app/data/repositories/movie_repository.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/widgets/error_alert.dart';
import 'package:flutter_movies_app/ui/widgets/movie_item.dart';
import 'package:flutter_movies_app/ui/widgets/movie_item_shimmer.dart';

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
  late final bool showTopRated;
  late Future<List<Movie>> movieList;
  List<Movie> topRated = [];

  @override
  void initState() {
    super.initState();
    showTopRated = widget.args?.showTopRated ?? false;
    movieList = movies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: FutureBuilder(
          future: movieList,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorAlert(text: snapshot.error.toString());
            } else {
              if (snapshot.hasData) {
                topRated = snapshot.data!.where((movie) {
                  return movie.rating == 5;
                }).toList();
              }
              return CustomScrollView(
                clipBehavior: Clip.none,
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 120,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(
                        showTopRated ? "Top Rated Movies" : "Movies",
                        style: bold_24.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Text(
                        showTopRated
                            ? "Qui puoi vedere la raccolta di tutti i tuoi film preferiti (5 stars rated), che hai inserito nell'applicazione."
                            : "Qui puoi vedere la raccolta di tutti i tuoi film che hai inserito nell'applicazione.",
                        style: medium_14,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  snapshot.hasData
                      ? SliverList.builder(
                          itemCount: showTopRated
                              ? topRated.length
                              : snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return MovieItem(
                              movie: showTopRated
                                  ? topRated[index]
                                  : snapshot.data![index],
                              horizontalPadding: true,
                            );
                          },
                        )
                      : SliverList.builder(
                          itemBuilder: (context, index) {
                            return const MovieItemShimmer(
                              horizontalPadding: true,
                            );
                          },
                        ),
                ],
              );
            }
          },
        ),
        onRefresh: () => Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            movieList = movies();
          });
        }),
      ),
    );
  }
}

class MoviesListArgs {
  final bool showTopRated;

  MoviesListArgs(this.showTopRated);
}
