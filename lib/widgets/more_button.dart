import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/widgets/frosted_glass.dart';

class MoreButton extends StatelessWidget {
  const MoreButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FrostedGlass(
      widget: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: kWhite.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          children: [
            Text(
              'More',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 4,
            ),
            Icon(
              Icons.window_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
