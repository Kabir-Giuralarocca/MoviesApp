import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_movies_app/data/config.dart';
import 'package:flutter_movies_app/domain/exceptions/exceptions.dart';
import 'package:flutter_movies_app/domain/token.dart';
import 'package:flutter_movies_app/domain/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieRepository {
  // GET ALL
  static Future<List<Movie>> movies() async {
    try {
      var token = "";
      await Token.getToken().then((value) => token = value);
      final response = await http.get(
        Uri.https(baseUrl, "api/Movies"),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );
      if (response.statusCode == 401) {
        throw Unauthorized();
      }
      Iterable data = jsonDecode(response.body);
      final result = data.map((e) => Movie.fromJson(e)).toList();
      result.shuffle();
      return result;
    } on Unauthorized {
      throw Unauthorized(message: "Rifai l'accesso per utilizzare l'app");
    } catch (e) {
      throw GenericError(message: "Qualcosa è andato storto!");
    }
  }

  // GET SINGLE
  static Future<Movie> movieDetail(int movieId) async {
    try {
      var token = "";
      await Token.getToken().then((value) => token = value);
      final response = await http.get(
        Uri.https(baseUrl, "api/Movies/$movieId"),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );
      if (response.statusCode == 401) {
        throw Unauthorized();
      }
      Movie result = Movie.fromJson(jsonDecode(response.body));
      return result;
    } on Unauthorized {
      throw Unauthorized(message: "Rifai l'accesso per utilizzare l'app");
    } catch (e) {
      throw GenericError(message: "Qualcosa è andato storto!");
    }
  }

  // POST
  static Future<void> createMovie(Movie movie) async {
    try {
      var token = "";
      await Token.getToken().then((value) => token = value);
      final response = await http.post(
        Uri.https(baseUrl, "api/Movies"),
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

  // PUT
  static Future<Movie> editMovie(Movie movie) async {
    try {
      var token = "";
      await Token.getToken().then((value) => token = value);
      final response = await http.put(
        Uri.https(baseUrl, "api/Movies/${movie.id}"),
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

  // DELETE
  static Future<void> deleteMovie(int movieId) async {
    try {
      var token = "";
      await Token.getToken().then((value) => token = value);
      final response = await http.delete(
        Uri.https(baseUrl, "api/Movies/$movieId"),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
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

  // For test purpose
  static Future<List<Movie>> moviesFake() async {
    try {
      final String response = await rootBundle.loadString('assets/movies.json');
      Iterable data = await json.decode(response)["items"];
      final result = data.map((e) => Movie.fromJson(e)).toList();
      result.shuffle();
      return result;
    } on Unauthorized {
      throw Unauthorized(message: "Rifai l'accesso per utilizzare l'app");
    } catch (e) {
      throw GenericError(message: "Qualcosa è andato storto!");
    }
  }

  static Future<Movie> movieDetailFake(int movieId) async {
    try {
      final String response = await rootBundle.loadString('assets/movies.json');
      Iterable data = await json.decode(response)["items"];
      final result = data.map((e) => Movie.fromJson(e)).toList();
      var movie = result.firstWhere((element) => element.id == movieId);
      return movie;
    } on Unauthorized {
      throw Unauthorized(message: "Rifai l'accesso per utilizzare l'app");
    } catch (e) {
      throw GenericError(message: "Qualcosa è andato storto!");
    }
  }
}
