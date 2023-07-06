import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_ai/data/app_color.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

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
            id: label3,
            title: 'Feature Request',
          ),
        ],
      ),
      theme: WiredashThemeData.fromColor(
        primaryColor: kPrimaryColor,
        secondaryColor: kSecondaryColor,
        brightness: currentTheme.getTheme ? Brightness.dark : Brightness.light,
      ),
      projectId: projectId,
      secret: secretKey,
      child: MaterialApp(
        darkTheme: ThemeData(
          extensions: const <ThemeExtension<AppColors>>[
            AppColors(
              kSecondaryColor: kSecondaryColor2,
              kTertiaryColor: kTertiaryColor2,
              kTextColor: kWhite,
            ),
          ],
          fontFamily: "Ubuntu",
          useMaterial3: true,
          textTheme: GoogleFonts.dmSansTextTheme(),
        ),
        theme: ThemeData(
          extensions: const <ThemeExtension<AppColors>>[
            AppColors(
              kSecondaryColor: kSecondaryColor,
              kTertiaryColor: kTertiaryColor,
              kTextColor: kTextColor,
            ),
          ],
          fontFamily: "Ubuntu",
          useMaterial3: true,
          textTheme: GoogleFonts.dmSansTextTheme(),
        ),
        themeMode: currentTheme.currentTheme(),
        home: const Home(),
      ),
    );
  }
}
