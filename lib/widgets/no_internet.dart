import 'package:flutter/material.dart';
import 'package:student_ai/data/constants/app_color.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Center(
      child: Column(
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size: 40,
            color: colors.kTextColor,
          ),
          Text(
            "Internet not available",
            style: TextStyle(color: colors.kTextColor),
          ),
        ],
      ),
    );
  }
}
