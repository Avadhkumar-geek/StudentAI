import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/widgets/support_card.dart';

class RateCard extends StatelessWidget {
  const RateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const SupportCard(
        title: "Rate Us",
        disc: "Review on PlayStore",
        imgSrc: "assets/rate.svg",
        color: kSupportCard2,
      ),
    );
  }
}
