import 'package:flutter/material.dart';
import 'package:gamify_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gamify App',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false,
      ),
      home: HomePage(),
    );
  }
}