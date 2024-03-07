import 'package:flutter/material.dart';
import 'dart:async';
import 'package:notesapp/screen/home_screen.dart';
import 'package:notesapp/screen/nav.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacityLevel = 0.0;

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 1),
      () {
        setState(() {
          opacityLevel = 1.0;
        });
      },
    );
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Nav()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          duration: Duration(seconds: 2),
          opacity: opacityLevel,
          child: Image.asset('assets/me_note.png', width: 300, height: 300),
        ),
      ),
    );
  }
}
