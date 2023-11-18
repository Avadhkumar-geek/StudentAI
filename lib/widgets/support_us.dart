import 'package:flutter/material.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/widgets/feedback_card.dart';
import 'package:student_ai/widgets/rate_card.dart';
import 'package:student_ai/widgets/share_card.dart';

class SupportUs extends StatelessWidget {
  const SupportUs({super.key});

  @override
  Widget build(BuildContext context) {
    AppColors colors(context) => Theme.of(context).extension<AppColors>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Support Us",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: colors(context).kTextColor),
          ),
        ),
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            ShareCard(),
            RateCard(),
            FeedbackCard(),
          ],
        ),
      ],
    );
  }
}
