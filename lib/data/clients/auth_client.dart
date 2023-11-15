import 'package:dio/dio.dart';
import 'package:flutter_movies_app/data/interceptors/base_interceptor.dart';

class AuthClient {
  static const localUrl = "https://localhost:44342";
  static const baseUrl = "https://fluttermoviesapi.azurewebsites.net";

  static final options = BaseOptions(
    baseUrl: baseUrl,
    contentType: "application/json; charset=UTF-8",
  );

  static Dio get dio {
    final Dio dio = Dio(options);
    dio.interceptors.addAll([
      BaseInterceptor(),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
    return dio;
  }
}
