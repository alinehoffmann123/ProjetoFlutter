import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diário de Gratidão',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: WelcomeScreen(),
    );
  }
}
