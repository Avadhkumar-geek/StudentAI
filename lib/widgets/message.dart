import 'package:flutter/material.dart';
import 'package:student_ai/widgets/usr_message.dart';

import 'ai_message.dart';

class Message extends StatelessWidget {
  const Message({Key? key, required this.text, required this.sender})
      : super(key: key);

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: sender == 'user'
          ? UsrMessage(sender: sender, text: text.trim())
          : AiMessage(text: text.trim()),
    );
  }
}
