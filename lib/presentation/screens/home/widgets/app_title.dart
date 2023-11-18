import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_ai/data/constants/constants.dart';

class AppTitle extends StatelessWidget {
  final bool isDarkMode;
  const AppTitle({
    super.key,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/svgs/logo.svg',
      height: 40,
      colorFilter: isDarkMode
          ? const ColorFilter.mode(
              kPrimaryColor,
              BlendMode.srcIn,
            )
          : null,
    );
  }
}
