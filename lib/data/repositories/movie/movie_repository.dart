import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movies_app/data/clients/movie_client.dart';
import 'package:flutter_movies_app/domain/exceptions/error_type.dart';
import 'package:flutter_movies_app/domain/exceptions/exception_helper.dart';
import 'package:flutter_movies_app/domain/exceptions/exceptions.dart';
import 'package:flutter_movies_app/domain/models/movie_model.dart';

class MovieRepository {
  static Future<List<Movie>> movies() async {
    try {
      final response = await MovieClient.dio.get("");
      Iterable data = response.data;
      final result = data.map((e) => Movie.fromJson(e)).toList();
      result.shuffle();
      return result;
    } on DioException catch (e) {
      if (e.errorType() == ErrorType.unauthorized) {
        throw Unauthorized(message: "Rifai l'accesso per utilizzare l'app");
      } else {
        throw e.error ?? GenericError(message: "Qualcosa è andato storto!");
      }
    }
  }

  static Future<Movie> movieDetail(int movieId) async {
    try {
      final response = await MovieClient.dio.get("/$movieId");
      Movie result = Movie.fromJson(response.data);
      return result;
    } on DioException catch (e) {
      if (e.errorType() == ErrorType.unauthorized) {
        throw Unauthorized(message: "Rifai l'accesso per utilizzare l'app");
      } else {
        throw e.error ?? GenericError(message: "Qualcosa è andato storto!");
      }
    }
  }

  static Future<void> createMovie(Movie movie) async {
    try {
      await MovieClient.dio.post("", data: jsonEncode(movie.toJson()));
    } on DioException catch (e) {
      if (e.errorType() == ErrorType.unauthorized) {
        throw Unauthorized(message: "Rifai l'accesso per utilizzare l'app");
      } else {
        throw e.error ?? GenericError(message: "Qualcosa è andato storto!");
      }
    }
  }

  static Future<Movie> editMovie(Movie movie) async {
    try {
      final response = await MovieClient.dio.put(
        "/${movie.id}",
        data: jsonEncode(movie.toJson()),
      );
      Movie result = Movie.fromJson(response.data);
      return result;
    } on DioException catch (e) {
      if (e.errorType() == ErrorType.unauthorized) {
        throw Unauthorized(message: "Rifai l'accesso per utilizzare l'app");
      } else {
        throw e.error ?? GenericError(message: "Qualcosa è andato storto!");
      }
    }
  }

  static Future<void> deleteMovie(int movieId) async {
    try {
      await MovieClient.dio.delete("/$movieId");
    } on DioException catch (e) {
      if (e.errorType() == ErrorType.unauthorized) {
        throw Unauthorized(message: "Rifai l'accesso per utilizzare l'app");
      } else {
        throw e.error ?? GenericError(message: "Qualcosa è andato storto!");
      }
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
