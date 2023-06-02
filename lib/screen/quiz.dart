import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/globals.dart';
import 'package:student_ai/data/quiz_model.dart';
import 'package:student_ai/screen/score.dart';
import 'package:student_ai/services/api_service.dart';
import 'package:student_ai/widgets/mcq.dart';

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
  List<String> selectedOptions = [];

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
        print("Error: $e");
      }
    }
  }

  void _submitQuiz() {
    int correctAns = 0;
    for (var option in selectedOptions) {
      if (answers.contains(option)) correctAns++;
      // selectedOptions.remove(option);
    }
    setState(() {
      _isSubmitted = true;
    });
    if (kDebugMode) {
      print(answers);
      print(selectedOptions);
    }

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Score(total: answers.length, correct: correctAns),
        ));
  }

  @override
  void initState() {
    super.initState();
    fetchData(widget.queryController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MCQ Quiz'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _isTyping
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    ListView.builder(
                      padding: const EdgeInsets.only(bottom: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: questionJSON.length,
                      itemBuilder: (context, index) {
                        var mcq = questionJSON.elementAt(index);
                        return MCQ(
                          mcq: mcq,
                          selectedOptions: selectedOptions,
                          isSumitted: _isSubmitted,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MaterialButton(
                      onPressed: _submitQuiz,
                      color: kButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: kWhite,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
