import 'package:flutter/material.dart';

import '../helper/constnats.dart';

Widget customtextfeild(Icon icon, String httxt, TextEditingController ctr) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      prefixIcon: icon,
      hintText: httxt,
      hintStyle: const TextStyle(color: Colors.white),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Constant().pinkcolor, width: 1)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Constant().pinkcolor, width: 1)),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Required";
      }
      if (httxt == 'Enter full name here') {
        if (httxt.isEmpty) {
          return "Enter name";
        }
      }
      if (httxt == 'Enter email here') {
        if (!value.contains("@gmail.com")) {
          return ("Email must be valid");
        }
      }
      if (httxt == 'Enter password here') {
        if (ctr.text.length < 6) {
          return ("Password at least 6 characters");
        }
      }
    },
    controller: ctr,
  );
}
