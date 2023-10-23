import 'package:flutter/material.dart';
import 'package:flutter_movies_app/domain/models/movie_model.dart';
import 'package:flutter_movies_app/ui/screens/create_movie_screen.dart';
import 'package:flutter_movies_app/ui/screens/edit_movie_screen.dart';
import 'package:flutter_movies_app/ui/screens/home_screen.dart';
import 'package:flutter_movies_app/ui/screens/login_screen.dart';
import 'package:flutter_movies_app/ui/screens/movie_detail_screen.dart';
import 'package:flutter_movies_app/ui/screens/movies_screen.dart';
import 'package:flutter_movies_app/ui/screens/register_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  var routeName = settings.name;
  var args = settings.arguments;

  var routes = {
    "/": (context) => const LoginScreen(),
    "/register": (context) => const RegisterScreen(),
    "/home": (context) => const HomeScreen(),
    "/movies": (context) => MoviesScreen(args: args as MoviesListArgs?),
    "/detail": (context) => MovieDatailScreen(movieId: args as int),
    "/create": (context) => const CreateMovieScreen(),
    "/edit": (context) => EditMovieScreen(movie: args as Movie),
  };

  WidgetBuilder builder = routes[routeName] ?? (context) => const LoginScreen();
  return MaterialPageRoute(builder: (context) => builder(context));
}
