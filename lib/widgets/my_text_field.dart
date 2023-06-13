import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.field,
    required this.formFieldControllers,
  });

  final MapEntry<String, dynamic> field;
  final Map<String, TextEditingController> formFieldControllers;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: () {
        FocusScope.of(context).nextFocus();
      },
      maxLines: 3,
      minLines: 1,
      keyboardType: typeMap[field.value['type']],
      controller: formFieldControllers[field.key],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintText: field.value['placeholder'],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kAiMsgBg,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kRed,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kAiMsgBg,
            width: 2,
          ),
        ),
        errorStyle: const TextStyle(color: kRed),
        filled: true,
        fillColor: kWhite70,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field can't be empty";
        } else {
          return null;
        }
      },
    );
  }
}
