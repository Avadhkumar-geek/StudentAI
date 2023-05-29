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
              color: kOrange.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
              // border: Border.all(width: 2, color: kOrange),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.all(8),
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: CircleAvatar(
              backgroundColor: kWhite.withOpacity(0.3),
              child: const Icon(
                Icons.school_outlined,
                size: 30,
              )),
        ),
      ],
    );
  }
}
