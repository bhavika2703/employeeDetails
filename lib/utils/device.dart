
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DeviceUtils {
  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static double getScaledSize(BuildContext context, double scale) =>
      scale *
          (MediaQuery.of(context).orientation == Orientation.portrait
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.height);


  static double getScaledWidth(BuildContext context, double scale) =>
      scale * MediaQuery.of(context).size.width;


  static double getScaledHeight(BuildContext context, double scale) =>
      scale * MediaQuery.of(context).size.height;

  static double getDeviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getDeviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static bool isMobile(){
    return SizerUtil.deviceType == DeviceType.mobile;
  }
}
