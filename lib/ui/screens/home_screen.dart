import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/models/movie_model.dart';
import 'package:flutter_movies_app/data/repositories/auth_repository.dart';
import 'package:flutter_movies_app/data/repositories/movie_repository.dart';
import 'package:flutter_movies_app/ui/screens/movies_screen.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/widgets/error_alert.dart';
import 'package:flutter_movies_app/ui/widgets/movie_carousel_item.dart';
import 'package:flutter_movies_app/ui/widgets/movie_carousel_item_shimmer.dart';
import 'package:flutter_movies_app/ui/widgets/movie_item.dart';
import 'package:flutter_movies_app/ui/widgets/movie_item_shimmer.dart';
import 'package:flutter_movies_app/ui/widgets/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> movieList;
  List<Movie> topRated = [];

  @override
  void initState() {
    super.initState();
    movieList = movies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text("Movies App"),
        titleTextStyle: bold_24.copyWith(color: Colors.white),
        actions: [
          GestureDetector(
            onTap: () => logout(context),
            child: const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.logout, color: Colors.white),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: movieList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorAlert(text: snapshot.error.toString());
          } else {
            if (snapshot.hasData) {
              topRated = snapshot.data!.where((movie) {
                return movie.rating == 5;
              }).toList();
              topRated.shuffle();
            }
            return ListView(
              clipBehavior: Clip.none,
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                Text(
                  "Gestisti e cataloga tutti i tuoi film preferiti in un unico posto",
                  style: medium_14,
                ),
                height_16,
                SectionTitle(
                  label: "Top Rated",
                  action: () => Navigator.of(context).pushNamed(
                    "/movies",
                    arguments: MoviesListArgs(true),
                  ),
                ),
                height_8,
                SizedBox(
                  height: 360,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    children: [
                      for (var i = 0; i < 3; i++)
                        snapshot.hasData
                            ? MovieCarouselItem(movie: topRated[i])
                            : const MovieCarouselItemShimmer(),
                    ],
                  ),
                ),
                height_16,
                SectionTitle(
                  label: "Movies",
                  action: () => Navigator.of(context).pushNamed("/movies"),
                ),
                height_8,
                for (var i = 0; i < 3; i++)
                  snapshot.hasData
                      ? MovieItem(movie: snapshot.data![i])
                      : const MovieItemShimmer(),
                height_24,
                OutlinedButton.icon(
                  onPressed: () {},
                  label: const Text("Aggiungi"),
                  icon: const Icon(Icons.add),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
