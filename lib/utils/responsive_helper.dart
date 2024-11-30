import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 && 
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static double getWidth(BuildContext context, {double percentage = 1}) =>
      MediaQuery.of(context).size.width * percentage;

  static double getHeight(BuildContext context, {double percentage = 1}) =>
      MediaQuery.of(context).size.height * percentage;

  // Card sizes
  static double getCardWidth(BuildContext context) {
    if (isMobile(context)) return getWidth(context, percentage: 0.85);
    if (isTablet(context)) return 400;
    return 450; // desktop
  }

  static double getCardHeight(BuildContext context) {
    if (isMobile(context)) return 200;
    if (isTablet(context)) return 220;
    return 250; // desktop
  }

  // Padding and margins
  static double getPadding(BuildContext context) {
    if (isMobile(context)) return 24;
    if (isTablet(context)) return 32;
    return 40; // desktop
  }

  // Font sizes
  static double getTitleSize(BuildContext context) {
    if (isMobile(context)) return 18;
    if (isTablet(context)) return 20;
    return 24; // desktop
  }

  static double getBodySize(BuildContext context) {
    if (isMobile(context)) return 14;
    if (isTablet(context)) return 16;
    return 18; // desktop
  }

  // Layout constraints
  static double getMaxWidth(BuildContext context) {
    if (isMobile(context)) return double.infinity;
    if (isTablet(context)) return 800;
    return 1200; // desktop
  }
} 