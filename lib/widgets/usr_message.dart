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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: kLightGreen,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            margin: const EdgeInsets.all(8),
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: const CircleAvatar(
              backgroundColor: kWhite70,
              child: Icon(
                Icons.school_outlined,
                size: 30,
              )),
        ),
      ],
    );
  }
}
