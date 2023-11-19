import 'package:flutter/material.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/constants.dart';
import 'package:student_ai/data/models/quiz_model.dart';

class QuizReview extends StatelessWidget {
  const QuizReview({
    super.key,
    required this.questionJSON,
    required this.selectedOptions,
    required this.answers,
    required this.colors,
  });

  final List<Question> questionJSON;
  final Map<int, String> selectedOptions;
  final List<String> answers;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: questionJSON.length,
        itemBuilder: (context, index) {
          final questions = questionJSON[index];
          final selectedOption = selectedOptions[index];
          final correctAnswer = answers[index];
          final isCorrect = selectedOption == correctAnswer;
          return Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.kSecondaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Q${index + 1}. ${questions.question}',
                  style: TextStyle(
                      color: colors.kTextColor, fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: questions.options.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectedOption == questions.options[i]
                                ? isCorrect
                                    ? kSuccessColor
                                    : kErrorColor
                                : correctAnswer == questions.options[i]
                                    ? kSuccessColor
                                    : kGrey,
                          ),
                          child: Center(
                            child: Text(
                              '${i + 1}',
                              style: const TextStyle(
                                color: kWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          questions.options[i],
                          style: TextStyle(
                            color: colors.kTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}
