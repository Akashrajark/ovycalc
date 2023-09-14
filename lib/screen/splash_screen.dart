import 'dart:async';

import 'package:calc/screen/home.dart';
import 'package:calc/util/value.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 1),
      () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
            (route) => false);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Text(
          "Ovy Calc",
          style: GoogleFonts.chewy(
            letterSpacing: 2,
            textStyle: Theme.of(context).textTheme.headlineLarge,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
          ),
        ),
      ),
    );
  }
}
