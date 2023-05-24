import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/globals.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.chatController,
    required this.onTap,
    required this.buttonColor,
  }) : super(key: key);

  final TextEditingController chatController;
  final VoidCallback onTap;
  final Color buttonColor;

  static const double borderWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        maxLines: 4,
        minLines: 1,
        style: const TextStyle(
          fontSize: 18,
          color: kBlack,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 3),
          ),
          hintText: "Ask anything",
          filled: true,
          fillColor: kWhite70,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                if (isAPIValidated == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enter a valid API Key'),
                      backgroundColor: kRed,
                      duration: Duration(seconds: 1),
                    ),
                  );
                } else {
                  onTap();
                  FocusScope.of(context).unfocus();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  color: buttonColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SvgPicture.asset(
                    'assets/openai.svg',
                    width: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
        controller: chatController,
      ),
    );
  }
}
