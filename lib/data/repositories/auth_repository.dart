import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/helpers/env_variables.dart';
import 'package:flutter_movies_app/data/helpers/exceptions.dart';
import 'package:flutter_movies_app/data/helpers/token_helper.dart';
import 'package:flutter_movies_app/data/models/login_model.dart';
import 'package:flutter_movies_app/data/models/register_model.dart';
import 'package:http/http.dart' as http;

Future<void> login({required String username, required String password}) async {
  try {
    final model = LoginModel(username: username, password: password);
    final response = await http.post(
      Uri.https(baseUrl, "/SignIn"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 401) {
      throw Unauthorized();
    }
    final result = jsonDecode(response.body)["token"];
    TokenHelper.saveToken(result);
  } on Unauthorized {
    throw Unauthorized(message: "Credenziali errate!");
  } catch (e) {
    throw GenericError(message: "Qualcosa è andato storto!");
  }
}

Future<void> register({
  required String username,
  required String email,
  required String password,
}) async {
  try {
    final model = RegisterModel(
      username: username,
      email: email,
      password: password,
    );
    final response = await http.post(
      Uri.https(baseUrl, "/SignUp"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
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

Future<void> registerWithLogin({
  required String username,
  required String email,
  required String password,
}) async {
  Future.wait([
    register(username: username, email: email, password: password),
    Future.delayed(
      const Duration(seconds: 2),
      () => login(username: username, password: password),
    ),
  ]);
}

void logout(BuildContext context) {
  TokenHelper.removeToken();
  Navigator.of(context).popUntil((route) => route.isFirst);
}
