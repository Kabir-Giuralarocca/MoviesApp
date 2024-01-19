import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/data/repositories/apk_repository.dart';
import 'package:flutter_movies_app/data/repositories/auth_repository.dart';
import 'package:flutter_movies_app/domain/models/login_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final ApkRepository apkRepository;

  final form = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();

  LoginBloc({
    required this.authRepository,
    required this.apkRepository,
  }) : super(Initial()) {
    on<OnLogin>((event, emit) async {
      emit(Loading());
      try {
        if (form.currentState?.validate() == true) {
          await authRepository.login(
            LoginModel(username: username.text, password: password.text),
          );
          emit(Authenticated());
        } else {
          emit(ValidationError());
        }
      } catch (e) {
        emit(UnAuthenticated());
        emit(Error(e.toString()));
      }
    });

    on<OnDownloadApk>((event, emit) {
      apkRepository.downloadApkWeb();
    });
  }
}
