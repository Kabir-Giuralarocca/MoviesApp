import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/repositories/movie_repository.dart';
import 'package:flutter_movies_app/domain/helpers/date_helper.dart';
import 'package:flutter_movies_app/domain/helpers/time_helper.dart';
import 'package:flutter_movies_app/domain/models/movie_model.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/widgets/appbars/collapsing_app_bar.dart';
import 'package:flutter_movies_app/ui/widgets/form_input.dart';
import 'package:flutter_movies_app/ui/widgets/list_description.dart';
import 'package:flutter_movies_app/ui/widgets/loading_screen.dart';
import 'package:flutter_movies_app/ui/widgets/rating_stars_input.dart';

class CreateMovieScreen extends StatefulWidget {
  const CreateMovieScreen({super.key});

  @override
  State<CreateMovieScreen> createState() => _CreateMovieScreenState();
}

class _CreateMovieScreenState extends State<CreateMovieScreen> {
  bool loader = false;

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

  void _clearForm() {
    title.clear();
    director.clear();
    genre.clear();
    duration.clear();
    releaseDate.clear();
    description.clear();
    image.clear();
    time = const TimeOfDay(hour: 0, minute: 0);
    date = DateTime.now();
    rating = 0;
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

  void _createMovie() {
    _showLoader(true);
    MovieRepository.createMovie(Movie(
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
      _clearForm();
      ScaffoldMessenger.of(context).showSnackBar(
        messageSnackBar(
          message: "Film creato con successo!",
        ),
      );
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
    return LoadingScreen(
      showLoader: loader,
      child: Scaffold(
        body: CustomScrollView(
          clipBehavior: Clip.none,
          slivers: [
            const CollapsingAppBar(title: "Aggiungi film"),
            const ListDescription(
              text:
                  "Inserisci tutte le informazioni per creare un nuovo film ed aggiungerlo alla tua lista.",
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
                          hint: "dd/mm/yyyy",
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
                                _createMovie();
                              }
                            },
                            child: const Text("Aggiungi"),
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
