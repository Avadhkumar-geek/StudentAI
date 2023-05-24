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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment:
          sender == 'user' ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: kLightGreen,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 8, bottom: 8, left: 40),
            child: Text(text),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          child: const CircleAvatar(
              child: Icon(
            Icons.school_outlined,
            size: 30,
          )),
        ),
      ],
    );
  }
}
