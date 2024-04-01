// ignore_for_file: prefer_const_constructors

import 'package:course_hub/screens/Homepage.dart';
import 'package:course_hub/screens/bookhome.dart';
import 'package:course_hub/screens/pptscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/helper.dart';
import 'aboutus.dart';
import 'login_reg.dart';

Widget drawer(BuildContext context) {
  return Drawer(
    backgroundColor: Color(0xff0F3460),
    child: Column(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.pink),
          child: SizedBox(
            width: screenwidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Taleem',
                  style: GoogleFonts.kanit(
                      fontSize: 30, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: ListTile(
        //     title: Text(
        //       'Share App',
        //       style: GoogleFonts.kanit(
        //           fontSize: 20,
        //           color: Colors.white,
        //           fontWeight: FontWeight.w600),
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeScreenbook()));
            },
            title: Text(
              'Books',
              style: GoogleFonts.kanit(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeScreenPPT()));
            },
            title: Text(
              'PPT',
              style: GoogleFonts.kanit(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeScreen()));
            },
            title: Text(
              'Udemy courses',
              style: GoogleFonts.kanit(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Aboutus()));
            },
            title: Text(
              'About Us',
              style: GoogleFonts.kanit(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () async {
              final url = Uri.parse('https://wa.link/qdvyku');
              if (await canLaunchUrl(url)) {
                launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                // ignore: avoid_print
                print("Can't launch $url");
              }
            },
            title: Text(
              'Contact US',
              style: GoogleFonts.kanit(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 20),
          child: ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LogIn_reg()),
                  (route) => false);
            },
            title: Text(
              'Log Out',
              style: GoogleFonts.kanit(
                  fontSize: 20,
                  color: Colors.pink,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    ),
  );
}
