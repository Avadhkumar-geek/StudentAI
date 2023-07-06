import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_ai/data/constants.dart';

class AppTitle extends StatelessWidget {
  final bool isDarkMode;
  const AppTitle({
    super.key,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/logo.svg',
          height: 40,
          colorFilter: isDarkMode
              ? const ColorFilter.mode(
                  kPrimaryColor,
                  BlendMode.srcIn,
                )
              : null,
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
