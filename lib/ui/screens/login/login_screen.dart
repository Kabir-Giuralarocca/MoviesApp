import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/data/repositories/apk_repository.dart';
import 'package:flutter_movies_app/data/repositories/auth_repository.dart';
import 'package:flutter_movies_app/router.dart';
import 'package:flutter_movies_app/ui/screens/login/bloc/login_bloc.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/widgets/download_button.dart';
import 'package:flutter_movies_app/ui/widgets/form_input.dart';
import 'package:flutter_movies_app/ui/widgets/loading_screen.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (_) => AuthRepository()),
        RepositoryProvider<ApkRepository>(create: (_) => ApkRepository()),
      ],
      child: BlocProvider(
        create: (context) => LoginBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
          apkRepository: RepositoryProvider.of<ApkRepository>(context),
        ),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is Authenticated) {
              context.push(AppRouter.home);
            }
            if (state is Error) {
              ScaffoldMessenger.of(context).showSnackBar(
                messageSnackBar(message: state.error, isError: true),
              );
            }
          },
          builder: (context, state) =>
              LoginLayout(showLoader: state is Loading),
        ),
      ),
    );
  }
}

class LoginLayout extends StatefulWidget {
  const LoginLayout({super.key, required this.showLoader});

  final bool showLoader;

  @override
  State<LoginLayout> createState() => _LoginLayoutState();
}

class _LoginLayoutState extends State<LoginLayout> {
  late LoginBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = BlocProvider.of<LoginBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.username.dispose();
    bloc.password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      showLoader: widget.showLoader,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            height_68,
            Text(
              "Accedi",
              style: bold_36,
            ),
            Text(
              "Inserisci le tue credenziali per poter accedere all'applicazione.",
              style: medium_14,
            ),
            height_24,
            Form(
              key: bloc.form,
              child: Column(
                children: [
                  FormInput(
                    label: "Username",
                    hint: "es. MarioRossi",
                    icon: Icons.person,
                    controller: bloc.username,
                  ),
                  FormInputPassword(controller: bloc.password),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => bloc.add(OnLogin()),
                child: const Text("Accedi"),
              ),
              height_8,
              OutlinedButton(
                onPressed: () => context.push(AppRouter.register),
                child: const Text("Registrati"),
              ),
              Visibility(
                visible: kIsWeb,
                child: DownloadButton(
                  label: "Download APK",
                  onPressed: () => bloc.add(OnDownloadApk()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
