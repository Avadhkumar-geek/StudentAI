import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_ai/data/app_color.dart';
import 'package:student_ai/data/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  _launchUrl(String url) async {
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalNonBrowserApplication);
    } catch (e) {
      throw e.toString();
    }
  }

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
        margin: const EdgeInsets.all(25),
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
              'assets/akLogo.svg',
              height: 100,
              colorFilter: const ColorFilter.mode(kTextColor, BlendMode.srcIn),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _launchUrl('https://github.com/Avadhkumar-geek/StudentAI'),
                  child: const Image(
                    height: 40,
                    image: AssetImage('assets/github1.png'),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                GestureDetector(
                  onTap: () =>
                      _launchUrl('https://www.linkedin.com/in/avadhkumar-kachhadiya-022175204/'),
                  child: const Image(
                    height: 40,
                    image: AssetImage('assets/linkedin.png'),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              '  © All Rights Reserved',
              style: TextStyle(fontWeight: FontWeight.bold, color: kTextColor),
            )
          ],
        ),
      ),
    );
  }
}
