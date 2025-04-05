import 'package:flutter/material.dart';

class CustomColor {
  static Color black = const Color(0xff000000);
  static Color white = const Color(0xffFFFFFF);
  static Color startSecondBgColor = const Color(0xff464447);
  static Color searchBorder = const Color(0xff33302E).withOpacity(0.10);
  static Color searchText = const Color.fromRGBO(0, 0, 0, 0.4);
  static const Color lightPurple = Color(0xffEDEFFF);
  static const Color blackOp80 = Color(0xff141414);

  static const Color blackOp60 = Color.fromRGBO(0, 0, 0, 0.7);
  static const Color borderGreyOp50 = Color.fromRGBO(207, 207, 207, 0.5);
  static const Color borderGreyOp80 = Color.fromRGBO(207, 207, 207, 0.8);
  static const Color labelGrey = Color(0xff9ca3af);
  static const Color darkBlue = Color(0xff2b2d42);
}

AdminText({required String text})  {
  return  Text(text,
    style:  TextStyle(
      fontSize:  16,
      fontWeight: FontWeight.w500,
      color: Color(0xFF000000),
      // 0xFF989898
    ),);
}