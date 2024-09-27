import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio dio = Dio();
  final maxQuestions = 10;
  int currentQuestionCount = 0;

  List? questions;

  BuildContext context;
  GamePageProvider({required this.context}) {
    dio.options.baseUrl = "https://opentdb.com/api.php";
    _getQuestionsFromApi();
  }

  Future<void> _getQuestionsFromApi() async {
    var response = await dio.get(
      "",
      queryParameters: {
        "amount": 10,
        "type": "boolean",
        "difficulty": "easy",
      },
    );
    var data = jsonDecode(response.toString());
    questions = data["results"];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return questions![currentQuestionCount]["question"];
  }

  void answerQuestion(String answer) async {
    bool isCorrect =
        questions![currentQuestionCount]["correct_answer"] == answer;
    currentQuestionCount++;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          title: Icon(
            isCorrect ? Icons.check_circle : Icons.cancel_sharp,
            color: Colors.white,
          ),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
    if(currentQuestionCount == maxQuestions) {
      endGame();
    } else {
      notifyListeners(); // rebuild ui with next question
    }
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Colors.blue,
          title: Text(
            "End Game!",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          content: Text("Score: 0/0"),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context); // remove alert
    Navigator.pop(context); // go back to main page
    currentQuestionCount = 0;
  }
}
