import 'package:flutter/material.dart';

import '../helper/constnats.dart';

Widget customtextfeild(Icon icon, String httxt,
    FormFieldValidator fieldValidator, TextEditingController ctr) {
      
  return TextFormField(
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
    validator: fieldValidator,
    controller: ctr,
  );
}
