import 'package:flutter/cupertino.dart';

class BmiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BmiPageState();
  }
}

class _BmiPageState extends State<BmiPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        color: CupertinoColors.systemRed,
      ),
    );
  }
}
