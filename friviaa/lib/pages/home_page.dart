import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;
  double _sliderValue = 0;
  List<String> level = ["Easy", "Medium", "Difficult"];

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
      child: _homeUI(),
    ));
  }

  Widget _homeUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _appTitle(),
        _sliderLevel(),
        _startButton(),
      ],
    );
  }

  Widget _appTitle() {
    return Center(
      child: Column(
        children: [
          _headingTitle(),
          _level(),
        ],
      ),
    );
  }

  Widget _headingTitle() {
    return const Text(
      "Frivia",
      style: TextStyle(
        color: Colors.white,
        fontSize: 48,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _level() {
    return Text(
      level[_sliderValue.toInt()],
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _sliderLevel() {
    return Slider(
      value: _sliderValue,
      min: 0,
      max: 2,
      divisions: 2,
      label: level[_sliderValue.toInt()],
      onChanged: (double value) {
        setState(() {
          _sliderValue = value;
        });
      },
    );
  }

  Widget _startButton() {
    return MaterialButton(
      onPressed: () {},
      color: Colors.blue,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      child: const Text(
        "Start",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
