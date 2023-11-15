import 'package:dio/dio.dart';
import 'package:flutter_movies_app/domain/exceptions/error_type.dart';
import 'package:flutter_movies_app/domain/exceptions/exception_helper.dart';
import 'package:flutter_movies_app/domain/exceptions/exceptions.dart';
import 'package:logger/logger.dart';

class BaseInterceptor extends Interceptor {
  final log = Logger();
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log.e(err.message);
    switch (err.errorType()) {
      case ErrorType.userAlreadyExist:
        throw UserAlredyExist(message: "Questo account esiste già!");
      case ErrorType.unauthorized:
        throw Unauthorized(message: "Credenziali errate!");
      default:
        throw GenericError(message: "Qualcosa è andato storto!");
    }
  }
}
