import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio dio = Dio();
  final maxQuestions = 10;
  int currentQuestionCount = 0;
  int correctQuestionCount = 0;

  List? questions;
  String? level;

  BuildContext context;
  GamePageProvider({required this.context, required this.level}) {
    dio.options.baseUrl = "https://opentdb.com/api.php";
    _getQuestionsFromApi();
  }

  Future<void> _getQuestionsFromApi() async {
    Map<String, Object> queryParam = {
      "amount": "10",
      "type": "boolean",
      "difficulty": level!.toLowerCase(),
    };

    // Construct the full URL
    // Uri uri = Uri.https(
    //   Uri.parse(dio.options.baseUrl).authority,
    //   Uri.parse(dio.options.baseUrl).path,
    //   queryParam,
    // );
    // print('Request URL: $uri');

    var response = await dio.get(
      "",
      queryParameters: queryParam,
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
    if (isCorrect) correctQuestionCount++;
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
    if (currentQuestionCount == maxQuestions) {
      endGame();
    } else {
      notifyListeners(); // rebuild ui with next question
    }
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text(
            "End Game!",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          content: Text(
            "Score: $correctQuestionCount/$maxQuestions",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context); // remove alert
    Navigator.pop(context); // go back to main page
    currentQuestionCount = 0;
    correctQuestionCount = 0;
  }
}
