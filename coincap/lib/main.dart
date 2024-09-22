import 'dart:convert';
import 'dart:io';

import 'package:coincap/models/app_config.dart';
import 'package:coincap/pages/home_page.dart';
import 'package:coincap/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // to ensure that the Flutter framework is properly initialized before any other code runs
  await loadConfig();
  registerHTTPService();
  runApp(const MyApp());
}

Future<void> loadConfig () async {
  String _configContent = await rootBundle.loadString("assets/config/main.json"); // provides access to the application's assets, such as images, text files, and other resources
  Map _configData = jsonDecode(_configContent);
  // `GetIt` - register and retrieve instances of classes
  // `registerSingleton` - ensures that only one instance of the class exists throughout the application's lifecycle
  GetIt.instance.registerSingleton<AppConfig>(
    AppConfig(COIN_API_BASE_URL: _configData["COIN_API_BASE_URL"])
  );
}

void registerHTTPService() {
  GetIt.instance.registerSingleton<HttpService>(
    HttpService(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromRGBO(88, 60, 197, 1.0),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
