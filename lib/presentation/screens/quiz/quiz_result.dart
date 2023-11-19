import 'package:flutter/material.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/constants.dart';
import 'package:student_ai/data/models/quiz_model.dart';
import 'package:student_ai/presentation/screens/quiz/widgets/quiz_review.dart';

class QuizResult extends StatelessWidget {
  final int total;
  final int correct;
  final List<Question> questionJSON;
  final List<String> answers;
  final Map<int, String> selectedOptions;

  const QuizResult(
      {Key? key,
      required this.total,
      required this.correct,
      required this.questionJSON,
      required this.answers,
      required this.selectedOptions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: colors.kTertiaryColor,
      appBar: AppBar(
        backgroundColor: kTransparent,
        foregroundColor: colors.kTextColor,
        title: const Text('Quiz Result'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: colors.kSecondaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'RESULT',
                  style: TextStyle(
                      color: colors.kTextColor, fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: correct == total
                        ? kSuccessColor
                        : correct / total >= 0.4
                            ? kBlue
                            : kErrorColor,
                  ),
                  child: Text(
                    '$correct/$total',
                    style: const TextStyle(
                      color: kWhite,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          QuizReview(
              questionJSON: questionJSON,
              selectedOptions: selectedOptions,
              answers: answers,
              colors: colors),
        ],
      ),
    );
  }
}
