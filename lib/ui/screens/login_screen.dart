import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/repositories/apk_repository.dart';
import 'package:flutter_movies_app/data/repositories/auth_repository.dart';
import 'package:flutter_movies_app/domain/models/login_model.dart';
import 'package:flutter_movies_app/domain/token.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/widgets/download_button.dart';
import 'package:flutter_movies_app/ui/widgets/form_input.dart';
import 'package:flutter_movies_app/ui/widgets/loading_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loader = false;
  double? progress;
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();

  void _showLoader(bool show, {double? value}) {
    setState(() {
      loader = show;
      progress = value;
    });
  }

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
      LoginModel(username: username.text, password: password.text),
    ).then(
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

  void _downloadApk() {
    _showLoader(true, value: 0);
    ApkRepository.downloadApk(
      progessCallback: (value) {
        _showLoader(true, value: value);
      },
    ).then((value) {
      _showLoader(false);
      if (!kIsWeb) {
        ScaffoldMessenger.of(context).showSnackBar(
          messageSnackBar(
            message: "Download avvenuto con successo!",
            isSuccess: true,
          ),
        );
      }
    }).onError((error, stackTrace) {
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
      progress: progress,
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
                  FormInputPassword(controller: password),
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
              Visibility(
                visible: kIsWeb,
                child: DownloadButton(
                  label: "Download APK",
                  onPressed: () => _downloadApk(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
