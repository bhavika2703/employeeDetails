import 'package:flutter/material.dart';
import 'package:realtime_innovations_assignment2/constants/colors.dart';
import 'package:realtime_innovations_assignment2/constants/font_family.dart';

class Styles {
  Styles._(); // this basically makes it so you can't instantiate this class

  static TextStyle body1TextStyle() => TextStyle(
        fontFamily: FontFamily.roboto,
        fontWeight: FontWeight.w700,
        fontSize: 16,
      );

  static TextStyle body2TextStyle() => TextStyle(
        fontFamily: FontFamily.roboto,
        fontWeight: FontWeight.w700,
        fontSize: 14,
      );

  static TextStyle heading2TextStyle() => TextStyle(
        fontFamily: FontFamily.roboto,
        fontWeight: FontWeight.w700,
        fontSize: 20,
      );

  static TextStyle body2SemiBoldTextStyle() => TextStyle(
        fontFamily: FontFamily.roboto,
        fontWeight: FontWeight.w600,
        color: AppColors.lightGrayColor,
        fontSize: 15,
      );

  static TextStyle subHeadBoldTextStyle() => TextStyle(
        fontFamily: FontFamily.roboto,
        fontWeight: FontWeight.w700,
        color: Color(0xFF212529),
        fontSize: 18,
      );

  static TextStyle caption3SemiBoldTextStyle() => TextStyle(
        fontFamily: FontFamily.roboto,
        fontWeight: FontWeight.w600,
        color: Color(0XFF4A525C),
        fontSize: 11,
      );
}
