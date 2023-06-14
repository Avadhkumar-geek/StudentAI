import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/widgets/frosted_glass.dart';

class MySearchBar extends StatefulWidget {
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
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: FrostedGlass(
        widget: TextField(
          cursorColor: kRadiumGreen,
          maxLines: 4,
          minLines: 1,
          style: const TextStyle(
            fontSize: 18,
            color: kWhite,
            fontWeight: FontWeight.w500,
          ),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(width: 3, color: kRadiumGreen),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(width: 3, color: kRadiumGreen),
            ),
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: kWhite),
            filled: true,
            fillColor: kBlack.withOpacity(0.5),
            suffixIcon: widget.suffixIcon,
          ),
          controller: widget.chatController,
          textInputAction: TextInputAction.search,
          onEditingComplete: () {
            widget.onComplete!();
            FocusScope.of(context).unfocus();
          },
          onChanged: (val) {
            widget.onChanged();
          },
        ),
      ),
    );
  }
}
