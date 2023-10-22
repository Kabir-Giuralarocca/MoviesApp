import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/helpers/movie_helper.dart';
import 'package:flutter_movies_app/data/models/movie_model.dart';
import 'package:flutter_movies_app/data/repositories/movie_repository.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/widgets/collapsing_title.dart';
import 'package:flutter_movies_app/ui/widgets/form_input.dart';
import 'package:flutter_movies_app/ui/widgets/loading_screen.dart';

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

  @override
  void initState() {
    movie = widget.movie;
    super.initState();
    _fillForm(movie);
  }

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

  _fillForm(Movie movie) {
    titleController.text = movie.title;
    directorController.text = movie.director;
    genreController.text = movie.genre;
    durationController.text = movie.duration.formatDuration();
    releaseDateController.text = movie.releaseDate.formatDate();
    descriptionController.text = movie.description;
    imageController.text = movie.image ?? "";
    duration = movie.duration;
    releaseDate = movie.releaseDate;
    rating = movie.rating;
  }

  void _showExitDialog(BuildContext context) {
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
                  "Se esci perderai le modifiche fatte in questa pagina!",
                  style: bold_14,
                ),
                height_16,
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text("Esci"),
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

  void _editMovie() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      Navigator.pop(context);
    } else {
      _showLoader(true);
      editMovie(
        Movie(
          id: movie.id,
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
    return LoadingScreen(
      showLoader: loader,
      loadingScreen: Scaffold(
        body: CustomScrollView(
          clipBehavior: Clip.none,
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: 300,
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              centerTitle: true,
              actions: [
                GestureDetector(
                  onTap: () => _showExitDialog(context),
                  child: const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(Icons.close),
                  ),
                )
              ],
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
                          hint: "--/--/--",
                          icon: Icons.calendar_today,
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
