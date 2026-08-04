import 'package:flutter/material.dart';

class FontFamily {
  FontFamily._();

  static const rubik = 'Rubik';
  static const inter = 'Inter';
}

class AppTextStyles {
  AppTextStyles._();

  static const tabBarLabel = TextStyle(
    fontFamily: FontFamily.inter,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 18 / 14,
    letterSpacing: -0.08,
  );

  static const emptyStateTitle = TextStyle(
    fontFamily: FontFamily.inter,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 1.2,
    letterSpacing: 0,
  );

  static const emptyStateSubtitle = TextStyle(
    fontFamily: FontFamily.inter,
    fontWeight: FontWeight.w400,
    fontSize: 15,
    height: 1.3,
    letterSpacing: 0,
  );

  static const addDocumentSourceLabel = TextStyle(
    fontFamily: FontFamily.inter,
    fontWeight: FontWeight.w700,
    fontSize: 15,
    height: 1.3,
    letterSpacing: 0,
  );
}
