import 'package:flutter/material.dart';

import 'constnats.dart';

screenwidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

screenheight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

void showsnackar(context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
    ),
    backgroundColor: Constant().greekcolor,
  ));
}
