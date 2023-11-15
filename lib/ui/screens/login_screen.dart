import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/repositories/auth/auth_repository.dart';
import 'package:flutter_movies_app/domain/models/login_model.dart';
import 'package:flutter_movies_app/domain/token.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/utils/form_validators.dart';
import 'package:flutter_movies_app/ui/widgets/form_input.dart';
import 'package:flutter_movies_app/ui/widgets/loading_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loader = false;
  bool obscurePwd = true;
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();

  void _showLoader(bool show) => setState(() => loader = show);

  @override
  void initState() {
    super.initState();
    Token.getToken().then((value) {
      return value.isNotEmpty ? Navigator.pushNamed(context, "/home") : null;
    });
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  void _login() {
    _showLoader(true);
    AuthRepository.login(
            LoginModel(username: username.text, password: password.text))
        .then(
      (value) {
        _showLoader(false);
        Navigator.of(context).pushNamed("/home");
      },
    ).onError((error, stackTrace) {
      _showLoader(false);
      ScaffoldMessenger.of(context).showSnackBar(
        messageSnackBar(message: error.toString(), isError: true),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      showLoader: loader,
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
              key: _formKey,
              child: Column(
                children: [
                  FormInput(
                    label: "Username",
                    hint: "es. MarioRossi",
                    icon: Icons.person,
                    controller: username,
                  ),
                  FormInput(
                    label: "Password",
                    hint: "Password",
                    icon: obscurePwd ? Icons.visibility : Icons.visibility_off,
                    obscureText: obscurePwd,
                    onIconTap: () => setState(() => obscurePwd = !obscurePwd),
                    controller: password,
                    validator: passwordValidator,
                  ),
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
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    _login();
                  }
                },
                child: const Text("Accedi"),
              ),
              height_8,
              OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, "/register"),
                child: const Text("Registrati"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
