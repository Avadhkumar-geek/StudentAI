import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_ai/data/globals.dart';
import 'package:student_ai/screen/home.dart';

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent));
  // await dotenv.load(fileName: '.env');
  getAPIKeyFromStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.getTextTheme('Montserrat'),
      ),
      home: const Home(),
    );
  }
}
