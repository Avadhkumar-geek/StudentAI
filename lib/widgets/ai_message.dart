import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              backgroundColor: kWhite.withOpacity(0.3),
              child: SvgPicture.asset(
                'assets/logo.svg',
                width: 25,
              )),
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: kLightGreen.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
              // border: Border.all(width: 2, color: Colors.lightGreen),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.all(8),
            child: Markdown(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              selectable: true,
              styleSheet:
                  MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                p: const TextStyle(fontSize: 14),
                code: const TextStyle(
                    fontSize: 14, color: kBlack, backgroundColor: kTransparent),
                codeblockDecoration: BoxDecoration(
                  color: kBlack.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: kGreen,
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
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: () => Clipboard.setData(
              ClipboardData(text: text),
            ),
            child: const Icon(
              Icons.copy_rounded,
              size: 15,
            ),
          ),
        ),
      ],
    );
  }
}
