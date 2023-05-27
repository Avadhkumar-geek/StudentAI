import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_ai/data/constants.dart';

class TypingAnimation extends StatelessWidget {
  const TypingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        SizedBox(
          width: 30,
          child: SpinKitThreeInOut(
            color: kBlue,
            size: 15,
          ),
        ),
        Text(
          'typing',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: kBlue),
        )
      ],
    );
  }
}
