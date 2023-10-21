import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/widgets/form_input.dart';

class CreateMovieScreen extends StatefulWidget {
  const CreateMovieScreen({super.key});

  @override
  State<CreateMovieScreen> createState() => _CreateMovieScreenState();
}

class _CreateMovieScreenState extends State<CreateMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  int rating = 0;

  void _onRatingChange(int index) {
    setState(() {
      if (rating == index + 1) {
        rating--;
      } else {
        rating = index + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      const FormInput(
                        label: "Titolo",
                        hint: "es. Interstellar",
                      ),
                      height_16,
                      const FormInput(
                        label: "Regista",
                        hint: "es. Christopher Nolan",
                      ),
                      height_16,
                      const FormInput(
                        label: "Genere",
                        hint: "es. Action, Science Fiction, Adventure",
                      ),
                      height_16,
                      const FormInput(
                        label: "Durata",
                        hint: "00:00",
                      ),
                      height_16,
                      const FormInput(
                        label: "Data di uscita",
                        hint: "--/--/--",
                      ),
                      height_16,
                      const FormInput(
                        label: "Trama",
                        hint: "Inserisci la descrizione del film",
                        maxLines: 15,
                      ),
                      height_16,
                      const FormInput(
                        label: "Immagine",
                        hint: "Link immagine",
                      ),
                      height_16,
                      Container(
                        padding: const EdgeInsets.all(16),
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
                                          : Colors.amber[900],
                                      shadows: lightShadow,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      height_24,
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Aggiungi"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
