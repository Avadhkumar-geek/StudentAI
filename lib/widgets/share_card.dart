import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:student_ai/data/constants/constants.dart';
import 'package:student_ai/widgets/support_card.dart';

class ShareCard extends StatelessWidget {
  const ShareCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final box = context.findRenderObject() as RenderBox?;

        Share.share(
            'https://github.com/Avadhkumar-geek/StudentAI/releases/tag/Latest',
            subject: 'Share App',
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
      },
      child: const SupportCard(
        title: "Share",
        disc: "Tell the World About Us",
        imgSrc: "assets/svgs/share.svg",
        color: kSupportCard1,
      ),
    );
  }
}
