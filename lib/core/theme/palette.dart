import 'package:flutter/material.dart';

class Palette {
  Palette._();

  static const black = Color(0xff0d0d0d);
  static const Color scaffoldBackground = Color(0xfff0f0f0);
  static const Color appBarColor = Color(0xFF242424);
  static const Color white = Colors.white;
  static const Color menuGlassColor = Color(0x99F5F5F5);
  static const Color menuTextColor = Color(0xFF262626);
  static const Color tabBarTrack = Color(0xFFE4E4E4);
  static const Color tabBarDivider = Color(0xFFD4D4D4);
  static const Color addDocumentSourceGradientStart = Color(0x33FFFFFF);
  static const Color addDocumentSourceGradientEnd = Color(0x331D1D1D);
  static const Color addDocumentOverlayTint = Color(0x33FFFFFF);

  static const LinearGradient addDocumentSourceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF0F0F0),
      Color(0xFFF7F7F7),
      Color(0xFFFFFFFF),
    ],
    stops: [
      0.0,
      0.55,
      1.0,
    ],
  );

  static const LinearGradient closeIconGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF0F0F0),
      Color(0xFFF7F7F7),
      Color(0xFFFFFFFF),
    ],
    stops: [
      0.0,
      0.55,
      1.0,
    ],
  );
  static const LinearGradient searchFabGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      addDocumentSourceGradientStart,
      addDocumentSourceGradientEnd,
    ],
  );

  static const LinearGradient addDocumentFabGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0xFF87E64C),
      Color(0xFFA1FF67),
    ],
  );

  static const LinearGradient addDocumentFabGlassOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0x33E6E6E6),
      Color(0x4D333333),
      Color(0x33FFFFFF),
      Color(0x4FFFFFFF),
    ],
    stops: [
      0.0,
      0.33,
      0.66,
      1.0,
    ],
  );


  static const darkGray1 = Color(0xff1d1d1d);
  static const darkGray2 = Color(0xFF414141);
  static const darkGray3 = Color(0xFF999999);

  static const gray1 = Color(0xffd7d7d7);

  static const lightGray1 = Color(0xffededed);

  static const deepCoral = Color(0xffd64051);
  static const coral = Color(0xfff35d6e);

  static const lightCoral = Color(0xffffe7e9);

  static const orange = Color(0xffffa570);
  static const deepOrange = Color(0xffe25102);
  static const lightOrange = Color(0xffffe5c2);

  static const deepBlue = Color(0xff5074bc);
  static const blue = Color(0xff4d97ff);
  static const emerald = Color(0xff008a91);
  static const lightBlue = Color(0xffdce5f7);

  static const mediumAquamarine = Color(0xFF43DF89);
  static const delivered = Color(0xff8ddbab);
  static const deepGreen = Color(0xff07903e);
  static const lightGreen = Color(0xffcef2dc);

  /// Multi-select selection indicator (Figma).
  static const Color documentSelectionSelected = Color(0xFF87E64C);
  static const Color documentSelectionUnselectedFill = Color(0x66FFFFFF);
  static const Color documentSelectionUnselectedBorder = Color(0xE6FFFFFF);
  static const Color multiSelectActionDisabled = Color(0x66333333);
  static const Color multiSelectTopBarGlass = Color(0x33FFFFFF);
  static const Color multiSelectTopBarText = Color(0xFFFFFFFF);

  static const lightPurple = Color(0xffe7dcf7);
  static const purple = Color(0xff8a50dc);

  static const defaultStroke = Color(0x1A0D0D0D);
  static const activeStroke = Color(0xffa977f1);

  static const exploreTag = Color(0x80505050);
  static const reelCard = Color(0x409A9A9A);
  static const searchTab = Color(0x33C9C9C9);

  static const loadingColor = Color(0xffee1144);

  static const Color textColor = white;
  static const Color errorColor = coral;

  static const primary = Color(0xFFFF183B);
  static const border = Color(0xff666666);
  static const mediumGray = Color(0xFF969696);

  static const Color backgroundColor = white;
}
