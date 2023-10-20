import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/repositories/auth_repository.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text("Movies App"),
        titleTextStyle: bold_24.copyWith(color: Colors.white),
        actions: [
          GestureDetector(
            onTap: () => logout(context),
            child: const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.logout, color: Colors.white),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "Cataloga e gestisci i tuoi film preferiti in un unico posto!",
            style: medium_14,
          ),
          height_24,
        ],
      ),
    );
  }
}
