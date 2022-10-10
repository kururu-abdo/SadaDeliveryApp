import 'package:flutter/material.dart';
import 'package:joseeder_delivery_boy/utill/color_resources.dart';
import 'package:joseeder_delivery_boy/utill/dimensions.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Cairo',

  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF161C24),
  hintColor: Colors.white,
  canvasColor: const Color(0xFFF9FAFA),
  primaryColorLight: ColorResources.colorWhite,


  shadowColor: const Color(0xfff7f7f7),
  backgroundColor: const Color(0xFF121212), // for background color
  cardColor: const Color(0xFF1E1E1E), // for surface color
  primaryColor: const Color(0xFFfaf274), // for primary color
  highlightColor: const Color(0xFFFFFFFF), // for on background text
  focusColor: const Color(0xFF8D8D8D),  // for On Surface text color
  dividerColor: const Color(0xFF2A2A2A), // for Any line
  errorColor: const Color(0xFFCF6679),  // for error color
  primaryColorDark: const Color(0xFF000000),  // for on primary color


  textTheme: const TextTheme(
    button: TextStyle(color: Color(0xFFF9FAFA)),
    headline1: TextStyle(fontWeight: FontWeight.w300, color: Color(0xFFF9FAFA), fontSize: Dimensions.fontSizeDefault),
    headline2: TextStyle(fontWeight: FontWeight.w400, color: Color(0xFFF9FAFA), fontSize: Dimensions.fontSizeDefault),
    headline3: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFF9FAFA), fontSize: Dimensions.fontSizeDefault),
    headline4: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFFF9FAFA), fontSize: Dimensions.fontSizeDefault),
    headline5: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFFF9FAFA), fontSize: Dimensions.fontSizeDefault),
    headline6: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFFF9FAFA), fontSize: Dimensions.fontSizeDefault),
    caption: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFFF9FAFA), fontSize: Dimensions.fontSizeDefault),
    subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
    bodyText2: TextStyle(fontSize: 12.0),
    bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
  ),
);
