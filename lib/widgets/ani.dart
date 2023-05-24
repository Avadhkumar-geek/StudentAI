import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_ai/data/constants.dart';

class TypingAnimation2 extends StatelessWidget {
  const TypingAnimation2({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 35,
      child: SpinKitThreeInOut(
        color: kWhite,
        size: 15,
      ),
    );
  }
}
