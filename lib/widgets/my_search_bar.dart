import 'package:flutter/material.dart';
import 'package:student_ai/data/app_color.dart';
import 'package:student_ai/data/constants.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar(
      {Key? key,
      required this.chatController,
      required this.hintText,
      required this.suffixIcon,
      required this.onComplete,
      required this.onChanged})
      : super(key: key);

  final TextEditingController chatController;
  final String hintText;
  final Widget suffixIcon;
  final VoidCallback onComplete;
  final VoidCallback onChanged;
  static const double borderWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        cursorColor: kPrimaryColor,
        maxLines: 4,
        minLines: 1,
        style: TextStyle(
            color: colors.kTextColor,
            fontSize: 20,
            decorationThickness: double.nan,
            fontWeight: FontWeight.w500),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: colors.kTextColor),
          filled: true,
          fillColor: colors.kSecondaryColor,
          suffixIcon: suffixIcon,
        ),
        controller: chatController,
        textInputAction: TextInputAction.search,
        onEditingComplete: () {
          onComplete();
          FocusScope.of(context).unfocus();
        },
        onChanged: (val) {
          onChanged();
        },
      ),
    );
  }
}
