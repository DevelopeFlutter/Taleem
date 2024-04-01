// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../helper/helper.dart';
import '../screens/About.dart';

Widget coursecard(
  BuildContext context,
  String imglink,
  String coursename,
  String tutorname,
  String category,
  String about,
  String demolink,
  String downloadlink,
  String sendername
) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => Aboutscreen(
                      coursename: coursename,
                      imglink: imglink,
                      tutorname: tutorname,
                      about: about,
                      demolink: demolink,
                      downloadlink: downloadlink,
                      sendername: sendername ,
                    )));
      },
      child: Container(
        height: 300,
        width: 250,
        decoration: BoxDecoration(
          color: Color(0xffF8F8F8),
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(10), bottom: Radius.circular(10.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: screenwidth(context),
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                category,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(imglink))),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10,
                top: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      coursename,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.kanit(
                        fontSize: 20,
                        color: Color(0xff0F3460),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10,
                top: 2,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.manage_accounts,
                    color: Color(0xffE94560),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    tutorname,
                    style: GoogleFonts.kanit(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffE94560)),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget pptcard(
  BuildContext context,
  String imglink,
  String coursename,
  String tutorname,
  String category,
  String demolink,
  String downloadlink,
  String sendername,
) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => Aboutpptscreen(
                      coursename: coursename,
                      imglink: imglink,
                      tutorname: tutorname,
                      demolink: demolink,
                      downloadlink: downloadlink,
                      sendername: sendername,
                    )));
      },
      child: Container(
        height: 300,
        width: 250,
        decoration: BoxDecoration(
          color: Color(0xffF8F8F8),
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(10), bottom: Radius.circular(10.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: screenwidth(context),
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                category,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(imglink))),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10,
                top: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      coursename,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.kanit(
                        fontSize: 20,
                        color: Color(0xff0F3460),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10,
                top: 2,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.manage_accounts,
                    color: Color(0xffE94560),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    tutorname,
                    style: GoogleFonts.kanit(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffE94560)),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
