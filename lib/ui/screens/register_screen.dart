import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/helpers/exceptions.dart';
import 'package:flutter_movies_app/data/repositories/auth_repository.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/utils/form_validators.dart';
import 'package:flutter_movies_app/ui/widgets/form_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  BuildContext? dialogContext;
  bool obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _showLoaderDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialog) {
        dialogContext = dialog;
        return loaderDialog;
      },
    );
  }

  void _closeLoaderDialog() {
    dialogContext != null ? Navigator.pop(dialogContext!) : null;
  }

  void _register() {
    _showLoaderDialog(context);

    // registerWithLogin(
    //   username: usernameController.text,
    //   email: emailController.text,
    //   password: passwordController.text,
    // ).then((value) {
    //   _closeLoaderDialog();
    //   Navigator.of(context).pushNamed("/home");
    // }).onError((error, stackTrace) {
    //   _closeLoaderDialog();
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     messageSnackBar(message: error.toString(), isError: true),
    //   );
    // });

    register(
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    ).then((value) {
      _closeLoaderDialog();
      ScaffoldMessenger.of(context).showSnackBar(
        messageSnackBar(
          message: "Account creato con successo!",
          label: "Accedi",
          onPressed: () => Navigator.of(context).pop(),
        ),
      );
    }).onError((error, stackTrace) {
      _closeLoaderDialog();
      bool userExist = error is UserAlredyExist;
      ScaffoldMessenger.of(context).showSnackBar(messageSnackBar(
        message: error.toString(),
        isError: true,
        label: userExist ? "Accedi" : null,
        onPressed: userExist ? () => Navigator.of(context).pop() : null,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  controller: usernameController,
                ),
                height_16,
                FormInput(
                  label: "Email",
                  hint: "es. mario.rossi@mail.it",
                  icon: Icons.email,
                  controller: emailController,
                  validator: emailValidator,
                ),
                height_16,
                FormInput(
                  label: "Password",
                  hint: "Password",
                  icon:
                      obscurePassword ? Icons.visibility : Icons.visibility_off,
                  obscureText: obscurePassword,
                  onIconTap: () => setState(() {
                    obscurePassword = !obscurePassword;
                  }),
                  controller: passwordController,
                  validator: passwordValidator,
                ),
                height_24,
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
    );
  }
}
