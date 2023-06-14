import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/widgets/api_input.dart';

class KeyButton extends StatelessWidget {
  const KeyButton({
    super.key,
    required this.isServerUp,
  });

  final bool isServerUp;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        if (!isServerUp) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.grey,
              content: Text(
                "Server is Down 🔻. Try again later!",
                style: TextStyle(
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ApiInput();
            },
          );
        }
      },
      icon: const Icon(Icons.key),
    );
  }
}
