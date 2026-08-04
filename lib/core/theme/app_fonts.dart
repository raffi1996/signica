import 'package:flutter/material.dart';

class FontFamily {
  FontFamily._();

  static String get rubik => 'Rubik';
  static String get inter => 'Inter';
}

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get tabBarLabel => TextStyle(
    fontFamily: FontFamily.inter,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 18 / 14,
    letterSpacing: -0.08,
  );

  static TextStyle get emptyStateTitle => TextStyle(
    fontFamily: FontFamily.inter,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 1.2,
    letterSpacing: 0,
  );

  static TextStyle get emptyStateSubtitle => TextStyle(
    fontFamily: FontFamily.inter,
    fontWeight: FontWeight.w400,
    fontSize: 15,
    height: 1.3,
    letterSpacing: 0,
  );

  static TextStyle get addDocumentSourceLabel => TextStyle(
    fontFamily: FontFamily.inter,
    fontWeight: FontWeight.w700,
    fontSize: 15,
    height: 1.3,
    letterSpacing: 0,
  );
}
