import 'package:flutter/material.dart';
import 'package:joseeder_delivery_boy/utill/color_resources.dart';
import 'package:joseeder_delivery_boy/utill/dimensions.dart';


ThemeData light = ThemeData(
  fontFamily: 'Cairo',
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFfaf274),
  hintColor: Colors.grey,
  primaryColorLight: const Color(0xFFfaf274),
  canvasColor: const Color(0xFFfaf274),

  shadowColor: const Color(0xfffcf9f4),
  backgroundColor: const Color(0xffF4F7FC), // for background color
  cardColor: const Color(0xFFFFFFFF), // for surface color
 primaryColor: Color(0xFFfaf274),
   highlightColor: const Color(0xFF1F1F1F), // for on background text
  focusColor: const Color(0xFF1F1F1F),  // for On Surface text color
  dividerColor: const Color(0xFF2A2A2A), // for Any line
  errorColor: const Color(0xFFFC6A57),  // for error color
  primaryColorDark: const Color(0xFFFFFFFF),  // for on primary color

  textTheme: const TextTheme(
    button: TextStyle(color: Colors.white),

    headline1: TextStyle(fontWeight: FontWeight.w300, color: ColorResources.colorBlack, fontSize: Dimensions.fontSizeDefault),
    headline2: TextStyle(fontWeight: FontWeight.w400, color: ColorResources.colorBlack, fontSize: Dimensions.fontSizeDefault),
    headline3: TextStyle(fontWeight: FontWeight.w500, color: ColorResources.colorBlack, fontSize: Dimensions.fontSizeDefault),
    headline4: TextStyle(fontWeight: FontWeight.w600, color: ColorResources.colorBlack, fontSize: Dimensions.fontSizeDefault),
    headline5: TextStyle(fontWeight: FontWeight.w700, color: ColorResources.colorBlack, fontSize: Dimensions.fontSizeDefault),
    headline6: TextStyle(fontWeight: FontWeight.w800, color: ColorResources.colorBlack, fontSize: Dimensions.fontSizeDefault),
    caption: TextStyle(fontWeight: FontWeight.w900, color: ColorResources.colorBlack, fontSize: Dimensions.fontSizeDefault),



    subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
    bodyText2: TextStyle(fontSize: 12.0),
    bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
  ),
);