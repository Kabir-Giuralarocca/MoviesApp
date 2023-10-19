import 'package:flutter/material.dart';
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
  bool obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                      Navigator.of(context).pushNamed("/home");
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
