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
      return result.reversed.toList();
    }
  } on Unauthorized {
    throw Unauthorized(message: "Rifai l'accesso per utilizzare l'app");
  } catch (e) {
    throw GenericError(message: "Qualcosa è andato storto!");
  }
}

Future<Movie> getMovie(int movieId) async {
  try {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final String response = await rootBundle.loadString('assets/movies.json');
      Iterable data = await json.decode(response)["items"];
      final result = data.map((e) => Movie.fromJson(e)).toList();
      var movie = result.firstWhere((element) => element.id == movieId);
      return movie;
    } else {
      var token = "";
      await TokenHelper.getToken().then((value) => token = value);
      final response = await http.get(
        Uri.https(
          baseUrl,
          "api/Movies/$movieId",
        ),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      if (response.statusCode == 401) {
        throw Unauthorized();
      }
      Movie result = Movie.fromJson(jsonDecode(response.body));
      return result;
    }
  } on Unauthorized {
    throw Unauthorized(message: "Rifai l'accesso per utilizzare l'app");
  } catch (e) {
    throw GenericError(message: "Qualcosa è andato storto!");
  }
}

Future<void> createMovie(Movie movie) async {
  try {
    var token = "";
    await TokenHelper.getToken().then((value) => token = value);
    final response = await http.post(
      Uri.https(
        baseUrl,
        "api/Movies",
      ),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(movie.toJson()),
    );
    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 401) {
      throw Unauthorized();
    } else {
      throw GenericError();
    }
  } on Unauthorized {
    throw Unauthorized(message: "Rifai l'accesso per utilizzare l'app");
  } catch (e) {
    throw GenericError(message: "Qualcosa è andato storto!");
  }
}

Future<Movie> editMovie(Movie movie) async {
  try {
    var token = "";
    await TokenHelper.getToken().then((value) => token = value);
    final response = await http.put(
      Uri.https(
        baseUrl,
        "api/Movies/${movie.id}",
      ),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(movie.toJson()),
    );
    if (response.statusCode == 200) {
      Movie result = Movie.fromJson(jsonDecode(response.body));
      return result;
    } else if (response.statusCode == 401) {
      throw Unauthorized();
    } else {
      throw GenericError();
    }
  } on Unauthorized {
    throw Unauthorized(message: "Rifai l'accesso per utilizzare l'app");
  } catch (e) {
    throw GenericError(message: "Qualcosa è andato storto!");
  }
}

Future<void> deleteMovie(Movie movie) async {
  try {
    var token = "";
    await TokenHelper.getToken().then((value) => token = value);
    final response = await http.delete(
      Uri.https(
        baseUrl,
        "api/Movies/${movie.id}",
      ),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 401) {
      throw Unauthorized();
    } else {
      throw GenericError();
    }
  } on Unauthorized {
    throw Unauthorized(message: "Rifai l'accesso per utilizzare l'app");
  } catch (e) {
    throw GenericError(message: "Qualcosa è andato storto!");
  }
}
