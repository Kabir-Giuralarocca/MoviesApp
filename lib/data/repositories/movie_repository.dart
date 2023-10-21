import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movies_app/data/helpers/env_variables.dart';
import 'package:flutter_movies_app/data/helpers/exceptions.dart';
import 'package:flutter_movies_app/data/helpers/token_helper.dart';
import 'package:flutter_movies_app/data/models/movie_model.dart';
import 'package:http/http.dart' as http;

Future<List<Movie>> movies() async {
  try {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final String response = await rootBundle.loadString('assets/movies.json');
      Iterable data = await json.decode(response)["items"];
      final result = data.map((e) => Movie.fromJson(e)).toList();
      result.shuffle();
      return result;
    } else {
      var token = "";
      await TokenHelper.getToken().then((value) => token = value);
      final response = await http.get(
        Uri.https(
          baseUrl,
          "api/Movies",
        ),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      if (response.statusCode == 401) {
        throw Unauthorized();
      }
      Iterable data = jsonDecode(response.body);
      final result = data.map((e) => Movie.fromJson(e)).toList();
      result.shuffle();
      return result;
    }
  } on Unauthorized {
    throw Unauthorized(message: "Rifai l'accesso per utilizzare l'app");
  } catch (e) {
    throw GenericError(message: "Qualcosa è andato storto!");
  }
}
