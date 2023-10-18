import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/widgets/form_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          height_64,
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
            child: Column(
              children: [
                const FormInput(
                  label: "Username",
                  hint: "es. MarioRossi",
                  icon: Icons.person,
                ),
                height_24,
                FormInput(
                  label: "Password",
                  hint: "Password",
                  icon:
                      obscurePassword ? Icons.visibility : Icons.visibility_off,
                  obscureText: obscurePassword,
                  onIconTap: () => setState(() {
                    obscurePassword = !obscurePassword;
                  }),
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
              onPressed: () {},
              child: const Text("Accedi"),
            ),
            height_8,
            OutlinedButton(
              onPressed: () {},
              child: const Text("Registrati"),
            ),
          ],
        ),
      ),
    );
  }
}
