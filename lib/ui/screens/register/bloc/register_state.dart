part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {}

class Initial extends RegisterState {
  @override
  List<Object?> get props => [];
}

class Loading extends RegisterState {
  @override
  List<Object?> get props => [];
}

class Error extends RegisterState {
  final String message;
  final Object? error;
  Error({this.error, required this.message});

  @override
  List<Object?> get props => [message, error];
}

class ValidationError extends RegisterState {
  @override
  List<Object?> get props => [];
}

class Success extends RegisterState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends RegisterState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends RegisterState {
  @override
  List<Object?> get props => [];
}
