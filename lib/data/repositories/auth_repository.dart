import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/env_variables.dart';
import 'package:flutter_movies_app/domain/exceptions.dart';
import 'package:flutter_movies_app/domain/token.dart';
import 'package:flutter_movies_app/domain/models/login_model.dart';
import 'package:flutter_movies_app/domain/models/register_model.dart';
import 'package:http/http.dart' as http;

Future<void> login(LoginModel model) async {
  try {
    final response = await http.post(
      Uri.https(baseUrl, "/SignIn"),
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

Future<void> register(RegisterModel model) async {
  try {
    final response = await http.post(
      Uri.https(baseUrl, "/SignUp"),
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

Future<void> registerWithLogin(RegisterModel model) async {
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

void logout(BuildContext context) {
  Token.removeToken();
  Navigator.of(context).popUntil((route) => route.isFirst);
}
