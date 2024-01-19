part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OnRegister extends RegisterEvent {}
