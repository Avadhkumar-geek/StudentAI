import 'package:flutter/material.dart';
import 'package:student_ai/screen/settings.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Settings(),
          ),
        );
      },
      icon: const Icon(Icons.settings),
    );
  }
}
