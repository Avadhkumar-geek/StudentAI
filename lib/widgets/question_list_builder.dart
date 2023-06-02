import 'package:flutter/material.dart';
import 'package:student_ai/data/quiz_model.dart';
import 'package:student_ai/widgets/mcq.dart';

class QuestionListBuilder extends StatelessWidget {
  const QuestionListBuilder({
    super.key,
    required this.questionJSON,
    required this.selectedOptions,
    required bool isSubmitted,
  }) : _isSubmitted = isSubmitted;

  final List<Question> questionJSON;
  final Map<int, String> selectedOptions;
  final bool _isSubmitted;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: questionJSON.length,
      itemBuilder: (context, index) {
        var mcq = questionJSON.elementAt(index);
        return MCQ(
          index: index,
          mcq: mcq,
          selectedOptions: selectedOptions,
          isSumitted: _isSubmitted,
        );
      },
    );
  }
}
