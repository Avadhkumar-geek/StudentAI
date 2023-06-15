import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';

class MadeWith extends StatelessWidget {
  const MadeWith({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 100, bottom: 50),
        child: Text.rich(
          style: const TextStyle(
            color: kWhite,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
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
