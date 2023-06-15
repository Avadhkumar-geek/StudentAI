import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/globals.dart';
import 'package:student_ai/models/quiz_model.dart';
import 'package:student_ai/screen/quiz_result.dart';
import 'package:student_ai/services/api_service.dart';
import 'package:student_ai/widgets/frosted_glass.dart';
import 'package:student_ai/widgets/question_list_builder.dart';

class Quiz extends StatefulWidget {
  final String queryController;

  const Quiz({Key? key, required this.queryController}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool _isTyping = true;
  bool _isSubmitted = false;

  List<Question> questionJSON = [];
  List<String> answers = [];
  Map<int, String> selectedOptions = {};

  Future<void> fetchData(String qry) async {
    try {
      String fetchRes = await ApiService.fetchApi(apiKey!, qry);

      setState(() {
        _isTyping = false;
      });

      Map<String, dynamic> quizJSON = jsonDecode(fetchRes);
      List<dynamic> questions = quizJSON['questions'];

      questionJSON = questions.map((e) {
        answers.add(e['answer']);
        return Question.fromJson(e);
      }).toList();
    } catch (e) {
      if (kDebugMode) {
        print("Quiz error: $e");
      }
    }
  }

  void _submitQuiz() {
    int correctAns = 0;
    for (var i = 0; i < answers.length; i++) {
      if (answers[i] == selectedOptions[i]) correctAns++;
    }
    setState(() {
      _isSubmitted = true;
    });

    // if (kDebugMode) {
    //   print(answers);
    //   print(selectedOptions);
    // }

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizResult(total: answers.length, correct: correctAns),
        ));
  }

  @override
  void initState() {
    super.initState();
    fetchData(widget.queryController);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: FrostedGlass(
        widget: Scaffold(
          backgroundColor: kBlack.withOpacity(0.6),
          appBar: AppBar(
            backgroundColor: kTransparent,
            foregroundColor: kWhite,
            title: const Text('MCQ Quiz'),
          ),
          body: _isTyping
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Generating Quiz...',
                        style: TextStyle(color: kWhite, fontSize: 25),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 80.0),
                        child: LinearProgressIndicator(
                          minHeight: 3,
                          color: kAiMsgBg,
                        ),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        QuestionListBuilder(
                            questionJSON: questionJSON,
                            selectedOptions: selectedOptions,
                            isSubmitted: _isSubmitted),
                        MaterialButton(
                          onPressed: _submitQuiz,
                          color: kAiMsgBg,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
