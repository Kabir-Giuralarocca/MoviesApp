import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/repositories/movie/movie_repository.dart';
import 'package:flutter_movies_app/domain/helpers/date_helper.dart';
import 'package:flutter_movies_app/domain/helpers/time_helper.dart';
import 'package:flutter_movies_app/domain/models/movie_model.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/widgets/appbars/collapsing_image_app_bar.dart';
import 'package:flutter_movies_app/ui/widgets/form_input.dart';
import 'package:flutter_movies_app/ui/widgets/loading_screen.dart';
import 'package:flutter_movies_app/ui/widgets/rating_stars_input.dart';

class EditMovieScreen extends StatefulWidget {
  const EditMovieScreen({super.key, required this.movie});

  final Movie movie;

  @override
  State<EditMovieScreen> createState() => _EditMovieScreenState();
}

class _EditMovieScreenState extends State<EditMovieScreen> {
  bool loader = false;
  late Movie movie;

  final _formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final director = TextEditingController();
  final genre = TextEditingController();
  final duration = TextEditingController();
  final releaseDate = TextEditingController();
  final description = TextEditingController();
  final image = TextEditingController();
  TimeOfDay time = const TimeOfDay(hour: 0, minute: 0);
  DateTime date = DateTime.now();
  int rating = 0;

  @override
  void initState() {
    movie = widget.movie;
    super.initState();
    _fillForm(movie);
  }

  void _showLoader(bool show) => setState(() => loader = show);

  @override
  void dispose() {
    title.dispose();
    director.dispose();
    genre.dispose();
    duration.dispose();
    releaseDate.dispose();
    description.dispose();
    image.dispose();
    super.dispose();
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await durationPicker(context, time);
    if (picked != null) {
      setState(() {
        time = picked;
        duration.text = picked.formatDuration();
      });
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await realeaseDatePicker(context, date);
    if (picked != null) {
      setState(() {
        date = picked;
        releaseDate.text = picked.formatDate();
      });
    }
  }

  void _onRatingChange(int index) {
    setState(() => rating == index + 1 ? rating-- : rating = index + 1);
  }

  _fillForm(Movie movie) {
    title.text = movie.title;
    director.text = movie.director;
    genre.text = movie.genre;
    duration.text = movie.duration.formatDuration();
    releaseDate.text = movie.releaseDate.formatDate();
    description.text = movie.description;
    image.text = movie.image ?? "";
    time = movie.duration;
    date = movie.releaseDate;
    rating = movie.rating;
  }

  void _editMovie() {
    _showLoader(true);
    MovieRepository.editMovie(Movie(
      id: movie.id,
      title: title.text,
      description: description.text,
      director: director.text,
      genre: genre.text,
      duration: time,
      releaseDate: date,
      rating: rating,
      image: image.text,
    )).then((value) {
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

  void _showExitDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => exitDialog(context));
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      showLoader: loader,
      child: Scaffold(
        body: CustomScrollView(
          clipBehavior: Clip.none,
          slivers: [
            CollapsingImageAppBar(
              title: movie.title,
              image: movie.image ?? "",
              automaticallyImplyLeading: false,
              expandedHeight: 300,
              rightIcon: Icons.close,
              rightIconTap: () => _showExitDialog(context),
            ),
            SliverList.list(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormInput(
                          label: "Titolo",
                          hint: "es. Interstellar",
                          controller: title,
                        ),
                        FormInput(
                          label: "Regista",
                          hint: "es. Christopher Nolan",
                          controller: director,
                        ),
                        FormInput(
                          label: "Genere",
                          hint: "es. Action, Science Fiction, Adventure",
                          controller: genre,
                        ),
                        FormInput(
                          label: "Durata",
                          hint: "00:00",
                          onTap: () => _selectTime(context),
                          controller: duration,
                        ),
                        FormInput(
                          label: "Data di uscita",
                          hint: "--/--/--",
                          onTap: () => _selectDate(context),
                          controller: releaseDate,
                        ),
                        FormInput(
                          label: "Trama",
                          hint: "Inserisci la descrizione del film",
                          maxLines: 15,
                          controller: description,
                        ),
                        FormInput(
                          label: "Immagine",
                          hint: "Link immagine",
                          controller: image,
                        ),
                        RatingStarsInput(
                          rating: rating,
                          onTap: (index) => _onRatingChange(index),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 100),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() == true) {
                                _editMovie();
                              }
                            },
                            child: const Text("Modifica"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
