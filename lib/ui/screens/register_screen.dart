import 'package:flutter/material.dart';
import 'package:flutter_movies_app/domain/exceptions.dart';
import 'package:flutter_movies_app/data/repositories/auth_repository.dart';
import 'package:flutter_movies_app/domain/models/register_model.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/utils/form_validators.dart';
import 'package:flutter_movies_app/ui/widgets/form_input.dart';
import 'package:flutter_movies_app/ui/widgets/loading_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool loader = false;
  bool obscurePwd = true;
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  void _showLoader(bool show) => setState(() => loader = show);

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  // ignore: unused_element
  void _registerWithLogin() {
    _showLoader(true);
    registerWithLogin(RegisterModel(
      username: username.text,
      email: email.text,
      password: password.text,
    )).then((value) {
      _showLoader(false);
      Navigator.pushNamed(context, "/home");
    }).onError((error, stackTrace) {
      _showLoader(false);
      bool userExist = error is UserAlredyExist;
      ScaffoldMessenger.of(context).showSnackBar(
        messageSnackBar(
          message: error.toString(),
          isError: true,
          label: userExist ? "Accedi" : null,
          onPressed: userExist ? () => Navigator.pop(context) : null,
        ),
      );
    });
  }

  void _register() {
    _showLoader(true);
    register(RegisterModel(
      username: username.text,
      email: email.text,
      password: password.text,
    )).then((value) {
      _showLoader(false);
      ScaffoldMessenger.of(context).showSnackBar(
        messageSnackBar(
          message: "Account creato con successo!",
          label: "Accedi",
          onPressed: () => Navigator.pop(context),
        ),
      );
    }).onError((error, stackTrace) {
      _showLoader(false);
      bool userExist = error is UserAlredyExist;
      ScaffoldMessenger.of(context).showSnackBar(
        messageSnackBar(
          message: error.toString(),
          isError: true,
          label: userExist ? "Accedi" : null,
          onPressed: userExist ? () => Navigator.pop(context) : null,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      showLoader: loader,
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
                    label: "Email",
                    hint: "es. mario.rossi@mail.it",
                    icon: Icons.email,
                    controller: email,
                    validator: emailValidator,
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
                  height_8,
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        _register();
                      }
                    },
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
