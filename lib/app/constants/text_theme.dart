import 'package:flutter/material.dart';
import 'package:tiktok/app/constants/font_family.dart';

class OvoTextStyle {
  OvoTextStyle._();

  static const ovoFont = FontFamily.ovo;

  static const FontWeight weightRegular = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightBold = FontWeight.bold;

  static const Color colorDefault = Colors.black;
  static const Color white = Colors.white;

  static TextStyle normal = const TextStyle(
    fontFamily: ovoFont,
    color: colorDefault,
  );
  static TextStyle normalWhite = const TextStyle(
    fontFamily: ovoFont,
    color: white,
    fontWeight: weightMedium,
  );
  static TextStyle normalWhiteBold = const TextStyle(
      fontFamily: ovoFont, color: white, fontWeight: weightBold);
  static TextStyle h4 = TextStyle(
      fontSize: 24,
      fontFamily: ovoFont,
      fontWeight: FontWeight.bold,
      color: white);
  static TextStyle h5 = TextStyle(
      fontSize: 18,
      fontFamily: ovoFont,
      fontWeight: FontWeight.bold,
      color: white);
  static TextStyle h7 =
      TextStyle(fontSize: 12, fontFamily: ovoFont, fontWeight: weightMedium);
}
