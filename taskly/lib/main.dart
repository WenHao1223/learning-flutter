import 'package:flutter/material.dart';
import './pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main () async {
  await Hive.initFlutter("hive_boxes");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskly',
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: false,
      ),
      home: const HomePage(),
    );
  }
}