import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/constants.dart';
import 'package:student_ai/data/models/quiz_model.dart';
import 'package:student_ai/logic/blocs/api/api_bloc.dart';
import 'package:student_ai/presentation/screens/quiz/quiz_result.dart';
import 'package:student_ai/presentation/screens/quiz/widgets/question_list_builder.dart';
import 'package:student_ai/widgets/loading_widget.dart';

class Quiz extends StatefulWidget {
  final String query;

  const Quiz({Key? key, required this.query}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool _isSubmitted = false;

  List<Question> questionJSON = [];
  List<String> answers = [];
  Map<int, String> selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colors.kTertiaryColor,
      appBar: AppBar(
        backgroundColor: kTransparent,
        foregroundColor: colors.kTextColor,
        title: const Text('MCQ Quiz'),
      ),
      body: BlocBuilder<APIBloc, APIState>(
        builder: (context, state) {
          if (state is APIRequestState) {
            return LoadingWidget(colors: colors, message: 'Generating Quiz...');
          }
          if (state is APISuccessState) {
            if (questionJSON.isEmpty) {
              _extractQuizFromJSON(state.response);
            }
            return SingleChildScrollView(
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
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: colors.kSecondaryColor,
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
            );
          }
          if (state is APIFailedState) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Something went wrong!!',
                    style: TextStyle(
                      fontSize: 25,
                      color: colors.kTextColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () {
                      context.read<APIBloc>().add(APIRequestEvent(query: widget.query));
                    },
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Retry',
                        style: TextStyle(
                          color: colors.kSecondaryColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return LoadingWidget(colors: colors, message: 'Generating Quiz...');
        },
      ),
    );
  }

  void _extractQuizFromJSON(String response) async {
    try {
      final jsonValidator = RegExp(r'(\{[^]*\})', dotAll: true);
      final match = jsonValidator.firstMatch(response);

      log("fetchRes: ${jsonValidator.hasMatch(response)}");

      Map<String, dynamic> quizJSON = jsonDecode(match!.group(0)!);
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

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizResult(total: answers.length, correct: correctAns),
        ));
  }
}
