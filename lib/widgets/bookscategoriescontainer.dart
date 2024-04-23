// ignore_for_file: non_constant_identifier_names

import 'package:course_hub/helper/helper.dart';
import 'package:course_hub/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

CategoriesContainer(BuildContext context, text, icon, width, iconwidth) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.pinkAccent[200], borderRadius: BorderRadius.circular(10)),
    height: mheight * 80 / mheight,
    width: width,
    child: Center(
        child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: GoogleFonts.kanit(
                color: Color(0xff0F3460),
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ),
        Spacer(),
        Image(
          color: Colors.white,
          image: AssetImage(
            icon,
          ),
          width: iconwidth,
        ),
        SizedBox(
          width: mwidth * 5 / mwidth,
        ),
      ],
    )),
  );
}
