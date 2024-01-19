import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/data/repositories/auth_repository.dart';
import 'package:flutter_movies_app/domain/models/register_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  final form = GlobalKey<FormState>();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  RegisterBloc({required this.authRepository}) : super(Initial()) {
    on<OnRegister>((event, emit) async {
      emit(Loading());
      try {
        if (form.currentState?.validate() == true) {
          await authRepository.registerWithLogin(
            RegisterModel(
              username: username.text,
              email: email.text,
              password: password.text,
            ),
          );
          emit(Authenticated());
        } else {
          emit(ValidationError());
        }
      } catch (e) {
        emit(UnAuthenticated());
        emit(Error(error: e, message: e.toString()));
      }
    });
  }
}
