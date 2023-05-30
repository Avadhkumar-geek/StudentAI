import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_ai/data/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key}) : super(key: key);

  _launchUrl(String url) async {
    try {
      await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalNonBrowserApplication);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kWhite.withOpacity(0.8),
      title: SvgPicture.asset(
        'assets/akLogo.svg',
        height: 70,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () =>
                    _launchUrl('https://github.com/Avadhkumar-geek/StudentAI'),
                child: const Image(
                  height: 30,
                  image: AssetImage('assets/github1.png'),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              GestureDetector(
                onTap: () => _launchUrl(
                    'https://www.linkedin.com/in/avadhkumar-kachhadiya-022175204/'),
                child: const Image(
                  height: 30,
                  image: AssetImage('assets/linkedin.png'),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            '  © All Rights Reserved',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
    ;
  }
}
