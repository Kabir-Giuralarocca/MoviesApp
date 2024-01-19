import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/data/repositories/auth_repository.dart';
import 'package:flutter_movies_app/domain/exceptions/exceptions.dart';
import 'package:flutter_movies_app/router.dart';
import 'package:flutter_movies_app/ui/screens/register/bloc/register_bloc.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/utils/form_validators.dart';
import 'package:flutter_movies_app/ui/widgets/form_input.dart';
import 'package:flutter_movies_app/ui/widgets/loading_screen.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => AuthRepository(),
      child: BlocProvider(
        create: (context) => RegisterBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is Authenticated) {
              context.push(AppRouter.home);
            }
            if (state is Error) {
              bool userExist = state.error is UserAlredyExist;
              ScaffoldMessenger.of(context).showSnackBar(
                messageSnackBar(
                  message: state.message,
                  isError: true,
                  label: userExist ? "Accedi" : null,
                  onPressed: userExist ? () => context.pop() : null,
                ),
              );
            }
          },
          builder: (context, state) =>
              RegisterLayout(showLoader: state is Loading),
        ),
      ),
    );
  }
}

class RegisterLayout extends StatefulWidget {
  const RegisterLayout({super.key, required this.showLoader});

  final bool showLoader;

  @override
  State<RegisterLayout> createState() => _RegisterLayoutState();
}

class _RegisterLayoutState extends State<RegisterLayout> {
  late RegisterBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = BlocProvider.of<RegisterBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.username.dispose();
    bloc.email.dispose();
    bloc.password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      showLoader: widget.showLoader,
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              "Registrati",
              style: bold_36,
            ),
            Text(
              "Inserisci le tue credenziali per creare il tuo account e poter accedere all'applicazione.",
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
                  FormInput(
                    label: "Email",
                    hint: "es. mario.rossi@mail.it",
                    icon: Icons.email,
                    controller: bloc.email,
                    validator: emailValidator,
                  ),
                  FormInputPassword(controller: bloc.password),
                  height_8,
                  ElevatedButton(
                    onPressed: () => bloc.add(OnRegister()),
                    child: const Text("Registrati"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
