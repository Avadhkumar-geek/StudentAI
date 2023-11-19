import 'package:flutter/material.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, required this.colors, required this.message});

  final String message;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: TextStyle(
            fontSize: 25,
            color: colors.kTextColor,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 80.0),
          child: LinearProgressIndicator(
            minHeight: 3,
            color: kPrimaryColor,
          ),
        ),
      ],
    );
  }
}
