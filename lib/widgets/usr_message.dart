import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';

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
    return Align(
      alignment: Alignment.centerRight,
      child: UnconstrainedBox(
        child: Container(
          decoration: BoxDecoration(
            color: kUsrMsgBg,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          margin: const EdgeInsets.all(8),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: kWhite,
            ),
          ),
        ),
      ),
    );
  }
}
