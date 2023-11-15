import 'package:dio/dio.dart';
import 'package:flutter_movies_app/domain/exceptions/error_type.dart';

extension ExceptionHelper on DioException {
  ErrorType errorType() {
    switch (response?.statusCode) {
      case 400:
        return ErrorType.userAlreadyExist;
      case 401:
        return ErrorType.unauthorized;
      default:
        return ErrorType.generic;
    }
  }
}
