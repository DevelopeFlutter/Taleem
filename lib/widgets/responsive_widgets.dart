import 'package:flutter/cupertino.dart';

import '../main.dart';

responsiveLeftRightPadding({left,right,child}) {
  return Padding(padding: EdgeInsets.only(left:mwidth*left/mwidth,right:mwidth*right/mwidth),child:child);
}
responsiveLeftRighBottomToptPadding({left,right,bottom,top,child}) {
  return Padding(padding: EdgeInsets.only(left:mwidth*left/mwidth,right:mwidth*right/mwidth,
  
  bottom: mheight*bottom/mheight,
  top:  mheight*top/mheight,
  ),child:child);
}