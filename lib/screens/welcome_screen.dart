// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_call_super, sort_child_properties_last, library_private_types_in_public_api

import 'dart:async';

import 'package:course_hub/screens/categoryscreen.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

// import 'Homepage.dart';
import 'login_signup.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>{
  final splashDelay = 7;

  @override
  void initState() {
    super.initState;
    _loadWidget();
  }

  _loadWidget() async {
    var duration = Duration(seconds: splashDelay);
    return Timer(duration, navigationPage);
  }

  navigationPage() {
    if (mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LogIn_reg()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0F3460),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('assets/images/welcome.png'),
                width: 350,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Taleem',
              style: GoogleFonts.kanit(
                  color: Colors.white,
                  fontSize: 35,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'everything for- free',
              style: GoogleFonts.kanit(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w200),
            ),
          ],
        ),
      ),
    );
  }
}

class Splashscreen2 extends StatefulWidget {
  const Splashscreen2({Key? key}) : super(key: key);

  @override
  _Splashscreen2State createState() => _Splashscreen2State();
}

class _Splashscreen2State extends State<Splashscreen2> {
  final splashDelay = 7;

  @override
  void initState() {
    super.initState;
    _loadWidget();
  }

  _loadWidget() async {
    var duration = Duration(seconds: splashDelay);
    return Timer(duration, navigationPage);
  }

  navigationPage() {
    if (mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Gotohome()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0F3460),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('assets/images/welcome.png'),
                width: 350,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Taleem',
              style: GoogleFonts.kanit(
                  color: Colors.white,
                  fontSize: 35,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'Everything for- free',
              style: GoogleFonts.kanit(
                  color: Colors.white,
                  fontSize: 15,
                  // letterSpacing: 1,
                  fontWeight: FontWeight.w200),
            ),
          ],
        ),
      ),
    );
  }
}
