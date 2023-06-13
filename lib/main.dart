import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/globals.dart';
import 'package:student_ai/data/secrets.dart';
import 'package:student_ai/screen/home.dart';
import 'package:wiredash/wiredash.dart';

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
  getAPIKeyFromStorage();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      feedbackOptions: const WiredashFeedbackOptions(
        labels: [
          Label(
            id: label1,
            title: 'Bug',
          ),
          Label(
            id: label2,
            title: 'Improvement',
          ),
          Label(
            id: label13,
            title: 'Feature Request',
          ),
        ],
      ),
      theme: WiredashThemeData.fromColor(
        primaryColor: kAiMsgBg,
        secondaryColor: kChatBackGround,
        brightness: Brightness.dark,
      ),
      projectId: projectId,
      secret: secretKey,
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.getTextTheme('Ubuntu'),
        ),
        home: const Home(),
      ),
    );
  }
}
