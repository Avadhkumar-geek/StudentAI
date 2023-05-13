import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_ai/screen/home.dart';

void main() {
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
