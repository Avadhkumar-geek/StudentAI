import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/constants.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: colors.kTertiaryColor,
      appBar: AppBar(
        backgroundColor: colors.kTertiaryColor,
        foregroundColor: colors.kTextColor,
        title: Text(
          "About",
          style: TextStyle(color: colors.kTextColor),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(40.0),
        margin: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svgs/akLogo.svg',
              height: 150,
              colorFilter: ColorFilter.mode(colors.kTextColor!, BlendMode.srcIn),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => launchURL('https://github.com/Avadhkumar-geek/StudentAI'),
                  child: const Image(
                    height: 40,
                    image: AssetImage('assets/pngs/github1.png'),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                GestureDetector(
                  onTap: () =>
                      launchURL('https://www.linkedin.com/in/avadhkumar-kachhadiya-022175204/'),
                  child: const Image(
                    height: 40,
                    image: AssetImage('assets/pngs/linkedin.png'),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                GestureDetector(
                  onTap: () => launchURL('https://twitter.com/Avadhkumar007'),
                  child: SvgPicture.asset(
                    'assets/svgs/x.svg',
                    width: 40,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              '  © All Rights Reserved',
              style: TextStyle(fontWeight: FontWeight.bold, color: colors.kTextColor),
            )
          ],
        ),
      ),
    );
  }
}
