import 'package:flutter/material.dart';
import 'package:student_ai/data/app_color.dart';
import 'package:student_ai/widgets/chat_bubble.dart';

class UsrMessage extends StatelessWidget {
  const UsrMessage({
    super.key,
    required this.sender,
    required this.text,
  });

  final String sender;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: colors.kSecondaryColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              // margin: const EdgeInsets.all(8),
              child: Text(
                text,
                style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: colors.kTextColor),
              ),
            ),
          ),
          CustomPaint(painter: ChatBubble(colors.kSecondaryColor!)),
        ],
      ),
    );
  }
}
