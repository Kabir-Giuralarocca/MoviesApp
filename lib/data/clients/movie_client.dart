import 'package:dio/dio.dart';
import 'package:flutter_movies_app/data/interceptors/base_interceptor.dart';
import 'package:flutter_movies_app/data/interceptors/token_interceptor.dart';

class MovieClient {
  static const localUrl = "https://localhost:44342/api/Movies";
  static const baseUrl =
      "https://fluttermoviesapi.azurewebsites.net/api/Movies";

  static final options = BaseOptions(
    baseUrl: baseUrl,
    contentType: "application/json; charset=UTF-8",
  );

  static Dio get dio {
    final Dio dio = Dio(options);
    dio.interceptors.addAll([
      BaseInterceptor(),
      TokenInterceptor(),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
    return dio;
  }
}
