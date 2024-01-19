part of 'login_bloc.dart';

abstract class LoginState extends Equatable {}

class Initial extends LoginState {
  @override
  List<Object?> get props => [];
}

class Loading extends LoginState {
  @override
  List<Object?> get props => [];
}

class Error extends LoginState {
  final String error;
  Error(this.error);

  @override
  List<Object?> get props => [error];
}

class ValidationError extends LoginState {
  @override
  List<Object?> get props => [];
}

class Success extends LoginState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends LoginState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends LoginState {
  @override
  List<Object?> get props => [];
}
