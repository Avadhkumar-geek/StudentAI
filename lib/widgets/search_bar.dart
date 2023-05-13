import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/globals.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.chatController,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  final TextEditingController chatController;
  final VoidCallback onTap;
  final Color color;

  static const double borderWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(width: borderWidth, color: color),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                maxLines: 4,
                minLines: 1,
                style: TextStyle(fontSize: 18, color: color),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Ask anything",
                  hintStyle: TextStyle(color: color),
                ),
                controller: chatController,
              ),
            ),
            InkWell(
              onTap: () {
                if (apiKey == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enter a valid API Key'),
                      backgroundColor: kRed,
                    ),
                  );
                } else {
                  onTap();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                width: 38,
                height: 38,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    'assets/openai.svg',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
