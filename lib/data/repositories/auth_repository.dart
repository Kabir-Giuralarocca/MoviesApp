import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/clients/auth_client.dart';
import 'package:flutter_movies_app/domain/models/login_model.dart';
import 'package:flutter_movies_app/domain/models/register_model.dart';
import 'package:flutter_movies_app/domain/token.dart';
import 'package:flutter_movies_app/router.dart';
import 'package:go_router/go_router.dart';

class AuthRepository {
  Future<void> login(LoginModel model) async {
    try {
      final response = await AuthClient.dio.post(
        "/SignIn",
        data: jsonEncode(model.toJson()),
      );
      final result = response.data["token"];
      Token.saveToken(result);
    } on DioException catch (e) {
      throw e.error as Object;
    }
  }

  Future<void> register(RegisterModel model) async {
    try {
      await AuthClient.dio.post(
        "/SignUp",
        data: jsonEncode(model.toJson()),
      );
    } on DioException catch (e) {
      throw e.error as Object;
    }
  }

  Future<void> registerWithLogin(RegisterModel model) async {
    final LoginModel loginModel = LoginModel(
      username: model.username,
      password: model.password,
    );
    await Future.wait([
      register(model),
      Future.delayed(
        const Duration(seconds: 2),
        () => login(loginModel),
      ),
    ]);
  }

  static void logout(BuildContext context) {
    Token.removeToken();
    context.go(AppRouter.login);
  }
}
