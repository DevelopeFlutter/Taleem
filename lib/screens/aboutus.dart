// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/helper.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({Key? key}) : super(key: key);

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff0F3460),
        body: Column(children: [
          Container(
            height: screenheight(context) / 8,
            decoration: BoxDecoration(
              color: Color(0xffE94560),
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(30.0)),
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Color(0xffF8F8F8),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                  Spacer(),
                  Text(
                    'COURSE HUB',
                    style: GoogleFonts.kanit(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        color: Colors.white),
                  ),
                  Spacer(),
                  // CircleAvatar(
                  //   backgroundColor: Color(0xffF8F8F8),
                  // )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: AssetImage('assets/images/Profile.jpg'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Ahmad Jamal',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Mobile Application(Flutter) Developer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 18.0,
                    letterSpacing: 2.5,
                    color: Colors.blue.shade50,
                  ),
                ),
                Container(
                  width: 200.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 48.0, vertical: 8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Color(0xff0F3460),
                    ),
                    title: Text(
                      '+92 309 5030486',
                      style: TextStyle(
                        color: Color(0xff0F3460),
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 46.0, vertical: 6.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Color(0xff0F3460),
                    ),
                    title: Text(
                      'Heartech786@gmail.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff0F3460),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
