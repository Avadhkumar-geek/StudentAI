import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/widgets/feedback_card.dart';
import 'package:student_ai/widgets/rate_card.dart';
import 'package:student_ai/widgets/share_card.dart';

class SupportUs extends StatelessWidget {
  const SupportUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Support Us",
            style: TextStyle(
              color: kWhite,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
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
