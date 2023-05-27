import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markdown/markdown.dart' as md;

import '../data/constants.dart';

class AiMessage extends StatelessWidget {
  const AiMessage({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: CircleAvatar(
              backgroundColor: kWhite70,
              child: SvgPicture.asset(
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            margin: const EdgeInsets.all(8),
            child: Markdown(
              padding: EdgeInsets.zero,
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
        ),
        // Flexible(
        //     child: SizedBox(
        //   width: double.infinity,
        // ))
      ],
    );
  }
}
