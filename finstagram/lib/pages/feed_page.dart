import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    // not return Scaffold as it's in home page
    return Container(
      color: Colors.green,
    );
  }
}