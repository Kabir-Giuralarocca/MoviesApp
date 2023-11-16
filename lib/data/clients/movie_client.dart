import 'package:dio/dio.dart';
import 'package:flutter_movies_app/data/config.dart';
import 'package:flutter_movies_app/data/interceptors/base_interceptor.dart';
import 'package:flutter_movies_app/data/interceptors/token_interceptor.dart';

class MovieClient {
  static final options = BaseOptions(
    baseUrl: "$baseUrl/api/Movies",
    contentType: "application/json; charset=UTF-8",
  );

  static Dio get dio {
    final Dio dio = Dio(options);
    dio.interceptors.addAll([
      BaseInterceptor(
        unauthorizedMessage: "Rifai l'accesso per utilizzare l'app",
      ),
      TokenInterceptor(),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
    return dio;
  }
}
