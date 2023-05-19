import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:student_ai/data/constants.dart';

class Message extends StatelessWidget {
  const Message({Key? key, required this.text, required this.sender})
      : super(key: key);

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            sender == 'user' ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            child: CircleAvatar(
                child: sender == 'user'
                    ? const Icon(
                        Icons.school_outlined,
                        size: 30,
                      )
                    : SvgPicture.asset(
                        'assets/logo.svg',
                        width: 25,
                      )),
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: kLightGreen,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Markdown(
                physics: const NeverScrollableScrollPhysics(),
                selectable: true,
                styleSheet:
                    MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                  p: const TextStyle(fontSize: 16),
                  code: const TextStyle(
                      color: kWhite, backgroundColor: kCodeBgColor),
                  codeblockDecoration: BoxDecoration(
                    color: kCodeBgColor,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: kBlack,
                      width: 1.0,
                    ),
                  ),
                ),
                extensionSet: md.ExtensionSet(
                  md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                  [
                    md.EmojiSyntax(),
                    md.CodeSyntax(),
                    md.ColorSwatchSyntax(),
                    ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                  ],
                ),
                data: text,
                shrinkWrap: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
