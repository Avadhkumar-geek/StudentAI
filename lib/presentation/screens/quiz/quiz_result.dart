import 'package:flutter/material.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/constants.dart';

class QuizResult extends StatelessWidget {
  final int total;
  final int correct;

  const QuizResult({Key? key, required this.total, required this.correct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: colors.kTertiaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'RESULT',
              style: TextStyle(
                  color: kWhite, fontSize: 40, fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: correct == total
                    ? kGreen
                    : correct / total >= 0.4
                        ? kBlue
                        : kRed,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.only(
                  top: 50, bottom: 60, left: 60, right: 60),
              child: Text(
                '$correct/$total',
                style: TextStyle(
                    color: kWhite,
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    fontFamily:
                        Theme.of(context).textTheme.bodyLarge!.fontFamily),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
