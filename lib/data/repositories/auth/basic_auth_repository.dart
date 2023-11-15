import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/domain/exceptions/exceptions.dart';
import 'package:flutter_movies_app/domain/token.dart';
import 'package:flutter_movies_app/domain/models/login_model.dart';
import 'package:flutter_movies_app/domain/models/register_model.dart';
import 'package:http/http.dart' as http;

class BasicAuthRepository {
  //static const _localUrl = "localhost:44342";
  static const _baseUrl = "fluttermoviesapi.azurewebsites.net";

  static Future<void> login(LoginModel model) async {
    try {
      final response = await http.post(
        Uri.https(_baseUrl, "/SignIn"),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(model.toJson()),
      );
      if (response.statusCode == 401) {
        throw Unauthorized();
      }
      final result = jsonDecode(response.body)["token"];
      Token.saveToken(result);
    } on Unauthorized {
      throw Unauthorized(message: "Credenziali errate!");
    } catch (e) {
      throw GenericError(message: "Qualcosa è andato storto!");
    }
  }

  static Future<void> register(RegisterModel model) async {
    try {
      final response = await http.post(
        Uri.https(_baseUrl, "/SignUp"),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(model.toJson()),
      );
      if (response.statusCode == 400) {
        throw UserAlredyExist();
      }
    } on UserAlredyExist {
      throw UserAlredyExist(message: "Questo account esiste già!");
    } catch (e) {
      throw GenericError(message: "Qualcosa è andato storto!");
    }
  }

  static Future<void> registerWithLogin(RegisterModel model) async {
    final LoginModel loginModel = LoginModel(
      username: model.username,
      password: model.password,
    );
    Future.wait([
      register(model),
      Future.delayed(
        const Duration(seconds: 2),
        () => login(loginModel),
      ),
    ]);
  }

  static void logout(BuildContext context) {
    Token.removeToken();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
