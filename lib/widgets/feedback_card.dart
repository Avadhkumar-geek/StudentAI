import 'package:flutter/material.dart';
import 'package:student_ai/data/constants/constants.dart';
import 'package:student_ai/widgets/support_card.dart';
import 'package:wiredash/wiredash.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Wiredash.of(context).show();
      },
      child: const SupportCard(
        title: "Feedback",
        disc: "Feature Request, Issue, Suggestions or Anything",
        imgSrc: "assets/svgs/feedback.svg",
        color: kSupportCard3,
      ),
    );
  }
}
