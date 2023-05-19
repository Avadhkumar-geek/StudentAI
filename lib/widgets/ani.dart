import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class TypingAnimation2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TyperAnimatedText('Typing...',
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
