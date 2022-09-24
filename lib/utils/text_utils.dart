import 'package:flutter/material.dart';

class TextUtils {
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  static void init({required MediaQueryData? mediaQueryData}) {
    screenWidth = mediaQueryData!.size.width;
    screenHeight = mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
  }
}
