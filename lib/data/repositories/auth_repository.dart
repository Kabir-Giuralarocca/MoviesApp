import 'dart:convert';
import 'package:flutter_movies_app/data/helpers/env_variables.dart';
import 'package:flutter_movies_app/data/helpers/exceptions.dart';
import 'package:flutter_movies_app/data/helpers/token_helper.dart';
import 'package:flutter_movies_app/data/models/login_model.dart';
import 'package:http/http.dart' as http;

// GET
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
    throw "Credenziali errate!";
  } catch (e) {
    throw "Qualcosa è andato storto!";
  }
}
