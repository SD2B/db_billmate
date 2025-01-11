import 'package:flutter/material.dart';

class ResponsiveHelper {
  static double mobileBrakePoint = 600;
  static double tabletBrakePoint = 1024;
  static double desktopBrakePoint = 1440;
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;
  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width < 1024;
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1024;
  static bool isWidthLessThan(BuildContext context, double width) => MediaQuery.of(context).size.width < width;
  static bool isHeightLessThan(BuildContext context, double height) => MediaQuery.of(context).size.height < height;
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
}
