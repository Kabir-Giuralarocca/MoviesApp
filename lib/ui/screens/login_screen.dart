import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/helpers/token_helper.dart';
import 'package:flutter_movies_app/data/repositories/auth_repository.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/utils/form_validators.dart';
import 'package:flutter_movies_app/ui/widgets/form_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  BuildContext? dialogContext;
  bool obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    TokenHelper.getToken().then((value) =>
        value.isNotEmpty ? Navigator.of(context).pushNamed("/home") : null);
  }

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

  void _login() {
    if (defaultTargetPlatform != TargetPlatform.android) {
      _showLoaderDialog(context);
      login(
        username: usernameController.text,
        password: passwordController.text,
      ).then(
        (value) {
          _closeLoaderDialog();
          Navigator.of(context).pushNamed("/home");
        },
      ).onError((error, stackTrace) {
        _closeLoaderDialog();
        ScaffoldMessenger.of(context).showSnackBar(
          messageSnackBar(message: error.toString(), isError: true),
        );
      });
    } else {
      Navigator.of(context).pushNamed("/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  controller: usernameController,
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
              onPressed: () => Navigator.of(context).pushNamed("/register"),
              child: const Text("Registrati"),
            ),
          ],
        ),
      ),
    );
  }
}
