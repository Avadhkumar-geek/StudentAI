import 'package:flutter/material.dart';
import 'package:student_ai/data/app_color.dart';

class MadeWith extends StatelessWidget {
  const MadeWith({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 100, bottom: 50),
        child: Text.rich(
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: colors.kTextColor),
          TextSpan(
            text: 'Made with ',
            children: [
              WidgetSpan(
                child: Image.asset(
                  'assets/heart.png',
                  height: 20,
                  width: 20,
                ),
              ),
              const TextSpan(text: ' by ∆vadh in 🇮🇳'),
            ],
          ),
        ),
      ),
    );
  }
}
