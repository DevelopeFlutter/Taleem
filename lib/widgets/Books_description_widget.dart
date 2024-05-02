// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

descriptionText(text,fontsize,color,fontweight) {
  return Expanded(child: Text(
       text,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.kanit(
                             color: color,
                              fontSize: fontsize,
                              fontWeight: fontweight),
  ));
}
