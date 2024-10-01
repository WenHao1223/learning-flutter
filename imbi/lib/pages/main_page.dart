import 'package:flutter/cupertino.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("IBMI"),
        // backgroundColor: CupertinoColors.activeOrange,
      ),
      child: Container(),
    );
  }
}
