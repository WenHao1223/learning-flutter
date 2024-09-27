import 'package:flutter/material.dart';
import 'package:friviaa/pages/game_page.dart';
import 'package:friviaa/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frivia',
      theme: ThemeData(
        fontFamily: "ArchitectsDaughter",
        scaffoldBackgroundColor: const Color.fromRGBO(31, 31, 31, 1.0),
        useMaterial3: false,
      ),
      // home: const GamePage(),
      home: const HomePage(),
    );
  }
}