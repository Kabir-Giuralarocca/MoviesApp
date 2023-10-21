import 'package:flutter_movies_app/data/models/movie_model.dart';
import 'package:intl/intl.dart';

extension MovieHelper on Movie {
  String formatDate() => DateFormat.yMd().format(releaseDate);

  String formatDuration() {
    var substring = duration.split(":");
    final String hours =
        substring[0].startsWith("0") ? substring[0].substring(1) : substring[0];
    final String minutes =
        substring[1].startsWith("0") ? substring[1].substring(1) : substring[1];

    return "${hours == "1" ? "$hours ora" : "$hours ore"}${minutes != "0" ? " e $minutes minuti" : ""} ";
  }
}
