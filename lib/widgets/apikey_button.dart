import 'package:flutter/material.dart';
import 'package:student_ai/widgets/api_input.dart';

class KeyButton extends StatelessWidget {
  const KeyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ApiInput();
          },
        );
      },
      icon: const Icon(Icons.key),
    );
  }
}
