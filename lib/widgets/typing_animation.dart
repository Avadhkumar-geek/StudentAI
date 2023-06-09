import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_ai/data/constants.dart';

class TypingAnimation extends StatelessWidget {
  const TypingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(
          width: 30,
          child: SpinKitThreeInOut(
            color: kRadiumGreen,
            size: 15,
          ),
        ),
        Text(
          'typing',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: kRadiumGreen),
        )
      ],
    );
  }
}
