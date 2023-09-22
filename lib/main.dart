import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justfit/constants/main.dart';
import 'package:justfit/screens/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JustFit',
      theme: ThemeData(
        primaryColor: BRAND_COLOR,
        fontFamily: GoogleFonts.hankenGrotesk().fontFamily,
        colorScheme: const ColorScheme.dark(
          brightness: Brightness.dark,
          background: DARK_BG,
        ),
        scaffoldBackgroundColor: DARK_BG,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: DARK_BG,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
