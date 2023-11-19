import 'package:flutter/material.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/constants.dart';

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
    final colors = Theme.of(context).extension<AppColors>()!;

    return TextFormField(
      onEditingComplete: () {
        FocusScope.of(context).nextFocus();
      },
      style: TextStyle(
        color: colors.kTextColor,
        // fontSize: 16,
      ),
      maxLines: 3,
      minLines: 1,
      keyboardType: typeMap[field.value['type']],
      controller: formFieldControllers[field.key],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintText: field.value['placeholder'],
        hintStyle: TextStyle(
          color: colors.kTextColor?.withOpacity(0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kPrimaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kErrorColor,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kPrimaryColor,
            width: 2,
          ),
        ),
        errorStyle: const TextStyle(color: kErrorColor),
        filled: true,
        fillColor: colors.kTertiaryColor,
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
