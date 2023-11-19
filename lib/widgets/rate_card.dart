import 'package:flutter/material.dart';
import 'package:student_ai/data/constants/constants.dart';
import 'package:student_ai/widgets/support_card.dart';
import 'package:wiredash/wiredash.dart';

class RateCard extends StatelessWidget {
  const RateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        {
          Wiredash.of(context).showPromoterSurvey(
            options: const PsOptions(
              frequency: Duration(days: 0),
              initialDelay: Duration(days: 0),
              minimumAppStarts: 0,
            ),
          );
        }
      },
      child: const SupportCard(
        title: "Rate Us",
        disc: "Review on PlayStore",
        imgSrc: "assets/svgs/rate.svg",
        color: kSupportCard2,
      ),
    );
  }
}
