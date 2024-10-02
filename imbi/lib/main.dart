import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:imbi/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  developer.log("\x1B[37mIBMI App Starting\x1B[0m");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: "IBMI",
      routes: {
        '/': (BuildContext context) => MainPage(),
      },
      initialRoute: "/",
    );
  }
}
