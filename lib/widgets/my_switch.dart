import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';

class MySwitch extends StatefulWidget {
  const MySwitch({super.key});


  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  bool openai = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: openai,
      activeColor: kRed,
      onChanged: (bool value) {
        setState(() {
          openai = value;
        });
      },
    );
  }
}
