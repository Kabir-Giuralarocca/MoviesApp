part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OnLogin extends LoginEvent {}

class OnDownloadApk extends LoginEvent {}
