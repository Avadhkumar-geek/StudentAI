import 'package:flutter/material.dart';
import 'package:student_ai/data/models/chat_model.dart';
import 'package:student_ai/presentation/screens/chat/widgets/usr_message.dart';

import 'ai_message.dart';

class Message extends StatelessWidget {
  const Message({Key? key, required this.text, required this.sender})
      : super(key: key);

  final String text;
  final ChatSender sender;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: sender == ChatSender.user
          ? UsrMessage(text: text.trim())
          : AiMessage(text: text.trim()),
    );
  }
}
