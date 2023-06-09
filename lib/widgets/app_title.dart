import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_ai/widgets/frosted_glass.dart';
import 'package:student_ai/widgets/info_card.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return const FrostedGlass(widget: InfoCard());
              }),
          child: SvgPicture.asset(
            'assets/logo.svg',
            width: 35,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const Text(
          "StudentAI",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
