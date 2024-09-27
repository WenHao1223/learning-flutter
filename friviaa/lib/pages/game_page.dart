import 'package:flutter/material.dart';
import 'package:friviaa/providers/game_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:html_unescape/html_unescape.dart';

class GamePage extends StatefulWidget {
  String? level;

  GamePage({super.key, required this.level});

  @override
  State<StatefulWidget> createState() {
    return _GamePageState();
  }
}

class _GamePageState extends State<GamePage> {
  double? _deviceHeight, _deviceWidth;

  GamePageProvider? _pageProvider;
  final HtmlUnescape unescape = HtmlUnescape();

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(context: context, level: widget.level),
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(
      builder: (context) {
        _pageProvider = context.watch<GamePageProvider>();
        if (_pageProvider!.questions != null) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _deviceHeight! * 0.05,
                ),
                child: _gameUI(),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      }
    );
  }

  Widget _gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questionText(),
        Column(
          children: [
            _trueButton(),
            SizedBox(
              height: _deviceHeight! * 0.01,
            ),
            _falseButton(),
          ],
        ),
      ],
    );
  }

  Widget _questionText() {
    return Text(
      unescape.convert(_pageProvider!.getCurrentQuestionText()),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _trueButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider!.answerQuestion("True");
      },
      color: Colors.green,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      child: const Text(
        "True",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider!.answerQuestion("False");

      },
      color: Colors.red,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      child: const Text(
        "False",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
