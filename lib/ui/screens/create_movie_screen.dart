import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/helpers/movie_helper.dart';
import 'package:flutter_movies_app/data/models/movie_model.dart';
import 'package:flutter_movies_app/data/repositories/movie_repository.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/widgets/form_input.dart';
import 'package:flutter_movies_app/ui/widgets/loading_screen.dart';

class CreateMovieScreen extends StatefulWidget {
  const CreateMovieScreen({super.key});

  @override
  State<CreateMovieScreen> createState() => _CreateMovieScreenState();
}

class _CreateMovieScreenState extends State<CreateMovieScreen> {
  bool loader = false;

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final directorController = TextEditingController();
  final genreController = TextEditingController();
  final durationController = TextEditingController();
  final releaseDateController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageController = TextEditingController();
  TimeOfDay duration = const TimeOfDay(hour: 0, minute: 0);
  DateTime releaseDate = DateTime.now();
  int rating = 0;

  void _showLoader(bool show) => setState(() => loader = show);

  @override
  void dispose() {
    titleController.dispose();
    directorController.dispose();
    genreController.dispose();
    durationController.dispose();
    releaseDateController.dispose();
    descriptionController.dispose();
    imageController.dispose();
    super.dispose();
  }

  void _clearForm() {
    titleController.clear();
    directorController.clear();
    genreController.clear();
    durationController.clear();
    releaseDateController.clear();
    descriptionController.clear();
    imageController.clear();
    duration = const TimeOfDay(hour: 0, minute: 0);
    releaseDate = DateTime.now();
    rating = 0;
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? time = await durationPicker(context, duration);
    if (time != null) {
      setState(() {
        duration = time;
        durationController.text = time.formatDuration();
      });
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await realeaseDatePicker(context, releaseDate);
    if (picked != null) {
      setState(() {
        releaseDate = picked;
        releaseDateController.text = picked.formatDate();
      });
    }
  }

  void _onRatingChange(int index) {
    setState(() {
      if (rating == index + 1) {
        rating--;
      } else {
        rating = index + 1;
      }
    });
  }

  void _createMovie() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      _clearForm();
      ScaffoldMessenger.of(context).showSnackBar(
        messageSnackBar(
          message: "Film creato con successo!",
        ),
      );
    } else {
      _showLoader(true);
      createMovie(
        Movie(
          title: titleController.text,
          description: descriptionController.text,
          director: directorController.text,
          genre: genreController.text,
          duration: duration,
          releaseDate: releaseDate,
          rating: rating,
          image: imageController.text,
        ),
      ).then((value) {
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
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      showLoader: loader,
      loadingScreen: Scaffold(
        body: CustomScrollView(
          clipBehavior: Clip.none,
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Aggiungi Film",
                  style: bold_24.copyWith(color: Colors.black),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  "Inserisci tutte le informazioni per creare un nuovo film ed aggiungerlo alla tua lista.",
                  style: medium_14,
                  textAlign: TextAlign.center,
                ),
              ),
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
                          controller: titleController,
                        ),
                        FormInput(
                          label: "Regista",
                          hint: "es. Christopher Nolan",
                          controller: directorController,
                        ),
                        FormInput(
                          label: "Genere",
                          hint: "es. Action, Science Fiction, Adventure",
                          controller: genreController,
                        ),
                        FormInput(
                          label: "Durata",
                          hint: "00:00",
                          onTap: () => _selectTime(context),
                          controller: durationController,
                        ),
                        FormInput(
                          label: "Data di uscita",
                          hint: "dd/mm/yyyy",
                          onTap: () => _selectDate(context),
                          controller: releaseDateController,
                        ),
                        FormInput(
                          label: "Trama",
                          hint: "Inserisci la descrizione del film",
                          maxLines: 15,
                          controller: descriptionController,
                        ),
                        FormInput(
                          label: "Immagine",
                          hint: "Link immagine",
                          controller: imageController,
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 24),
                          decoration: formInputDecoration,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FormInputLabel(label: "Valutazione"),
                              height_4,
                              Row(
                                children: [
                                  for (var i = 0; i < 5; i++)
                                    GestureDetector(
                                      onTap: () => _onRatingChange(i),
                                      child: Icon(
                                        rating > i
                                            ? Icons.star
                                            : Icons.star_border,
                                        size: 36,
                                        color: rating > i
                                            ? Colors.amber
                                            : Colors.grey,
                                        shadows: lightShadow,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
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
