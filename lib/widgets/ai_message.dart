import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:student_ai/data/app_color.dart';
import 'package:student_ai/widgets/chat_bubble.dart';

import '../data/constants.dart';

class AiMessage extends StatelessWidget {
  const AiMessage({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

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
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8),
          child: CustomPaint(
            painter: ChatBubble(kPrimaryColor),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Markdown(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                selectable: true,
                styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                  p: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  code: TextStyle(
                      fontSize: 14, color: colors.kTextColor, backgroundColor: kTransparent),
                  codeblockDecoration: BoxDecoration(
                    color: colors.kSecondaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: kPrimaryColor,
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
