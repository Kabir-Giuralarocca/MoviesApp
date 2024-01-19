import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_movies_app/domain/models/movie_model.dart';
import 'package:flutter_movies_app/domain/token.dart';
import 'package:flutter_movies_app/ui/screens/create_movie_screen.dart';
import 'package:flutter_movies_app/ui/screens/edit_movie_screen.dart';
import 'package:flutter_movies_app/ui/screens/home_screen.dart';
import 'package:flutter_movies_app/ui/screens/login/login_screen.dart';
import 'package:flutter_movies_app/ui/screens/movie_detail_screen.dart';
import 'package:flutter_movies_app/ui/screens/movies_screen.dart';
import 'package:flutter_movies_app/ui/screens/register/register_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  // Routes paths
  static const login = "/login";
  static const register = "/register";
  static const home = "/home";
  static const movies = "/movies";
  static const create = "/create";
  static const detail = "/detail";
  static const edit = "/edit";

  // Routes params
  static const topRatedParam = "topRated";
  static const idParam = "id";

  static FutureOr<String?> _authRedirection() async {
    String token = await Token.getToken();
    return token.isEmpty ? login : null;
  }

  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: home,
    routes: [
      // Login
      GoRoute(
        name: login.substring(1),
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),
      // Register
      GoRoute(
        name: register.substring(1),
        path: register,
        builder: (context, state) => const RegisterScreen(),
      ),
      // Home
      GoRoute(
        name: home.substring(1),
        path: home,
        builder: (context, state) => const HomeScreen(),
        redirect: (context, state) => _authRedirection(),
      ),
      // Movies
      GoRoute(
        name: movies.substring(1),
        path: movies,
        builder: (context, state) => MoviesScreen(
          topRated: state.uri.queryParameters[topRatedParam] as bool? ?? false,
        ),
        redirect: (context, state) => _authRedirection(),
      ),
      // Create Movie
      GoRoute(
        name: create.substring(1),
        path: create,
        builder: (context, state) => const CreateMovieScreen(),
        redirect: (context, state) => _authRedirection(),
      ),
      // Movie Detail
      GoRoute(
        name: detail.substring(1),
        path: "$detail/:$idParam",
        builder: (context, GoRouterState state) => MovieDatailScreen(
          id: state.pathParameters[idParam] as int,
        ),
        redirect: (context, state) => _authRedirection(),
      ),
      // Edit Movie
      GoRoute(
        name: edit.substring(1),
        path: "$edit/:$idParam",
        builder: (context, GoRouterState state) => EditMovieScreen(
          id: state.pathParameters[idParam] as int,
          movie: state.extra as Movie?,
        ),
        redirect: (context, state) => _authRedirection(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(state.error?.message ?? ""),
      ),
    ),
  );
}
