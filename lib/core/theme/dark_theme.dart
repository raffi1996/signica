import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signica/core/theme/themes.dart';

final darkBase = ThemeData(
  fontFamily: FontFamily.rubik,
  useMaterial3: false,
  brightness: Brightness.dark,
);

final ThemeData darkTheme = darkBase.copyWith(
  splashColor: Palette.white,
  highlightColor: Palette.white,
  hoverColor: Palette.white,
  primaryColor: Palette.primary,
  expansionTileTheme: darkBase.expansionTileTheme.copyWith(
    collapsedIconColor: Palette.textColor,
    collapsedTextColor: Palette.textColor,
    clipBehavior: Clip.none,
    shape: const Border(bottom: BorderSide()),
    collapsedShape: const Border(bottom: BorderSide()),
    tilePadding: const EdgeInsets.symmetric(horizontal: 20),
  ),
  cardTheme: CardThemeData(
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    clipBehavior: Clip.none,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  scaffoldBackgroundColor: Palette.white,
  drawerTheme: const DrawerThemeData(backgroundColor: Palette.white),
  dividerColor: Palette.border,
  dividerTheme: darkBase.dividerTheme.copyWith(
    space: 1,
    thickness: 1,
    indent: 0,
    endIndent: 0,
    color: Palette.border,
  ),
  primaryIconTheme: darkBase.primaryIconTheme.copyWith(color: Palette.primary),
  iconTheme: darkBase.iconTheme.copyWith(color: Palette.border),
  appBarTheme: darkBase.appBarTheme.copyWith(
    centerTitle: false,
    titleSpacing: 8,
    iconTheme: const IconThemeData(color: Palette.primary),
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: Palette.primary,
    shadowColor: Palette.primary.withValues(alpha: 0.15),
    titleTextStyle: darkBase.primaryTextTheme.titleLarge!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w600,
      fontSize: 26,
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
    toolbarTextStyle: darkBase.textTheme
        .copyWith(
          bodyLarge: darkBase.textTheme.bodyLarge!.copyWith(
            color: Palette.primary,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: darkBase.textTheme.titleLarge!.copyWith(
            color: Palette.textColor,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: darkBase.textTheme.displaySmall!.copyWith(
            color: Palette.primary,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: darkBase.textTheme.headlineMedium!.copyWith(
            color: Palette.primary,
            fontWeight: FontWeight.w500,
          ),
        )
        .bodyMedium,
  ),
  bottomNavigationBarTheme: darkBase.bottomNavigationBarTheme.copyWith(
    backgroundColor: Palette.backgroundColor,
    selectedItemColor: Palette.primary,
    unselectedItemColor: Palette.white,
    selectedLabelStyle: darkBase.textTheme.bodyMedium,
    unselectedLabelStyle: darkBase.textTheme.bodyLarge,
    elevation: 4,
    type: BottomNavigationBarType.shifting,
  ),
  chipTheme: darkBase.chipTheme.copyWith(
    backgroundColor: Palette.white,
    labelPadding: const EdgeInsets.symmetric(horizontal: 20),
    labelStyle: const TextStyle(
      color: Palette.primary,
      fontWeight: FontWeight.w500,
    ),
    selectedColor: Palette.primary,
    secondaryLabelStyle: const TextStyle(
      color: Palette.primary,
      fontWeight: FontWeight.w500,
    ),
    secondarySelectedColor: Palette.white,
  ),
  sliderTheme: darkBase.sliderTheme.copyWith(
    activeTrackColor: Palette.primary,
    inactiveTrackColor: Palette.primary,
    overlayColor: Palette.white,
    thumbColor: Palette.primary,
    thumbShape: SliderComponentShape.noOverlay,
    valueIndicatorColor: Palette.primary,
  ),
  textSelectionTheme: darkBase.textSelectionTheme.copyWith(
    cursorColor: Palette.primary,
    selectionHandleColor: Palette.primary,
  ),
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: Palette.primary,
  ),
  brightness: Brightness.dark,
  inputDecorationTheme: darkBase.inputDecorationTheme.copyWith(
    prefixStyle: darkBase.textTheme.bodyLarge!.copyWith(color: Palette.border),
    disabledBorder: InputBorder.none,
    errorStyle: const TextStyle(
      color: Palette.errorColor,
      fontWeight: FontWeight.w400,
      height: 1.2,
    ),
    hintStyle: darkBase.primaryTextTheme.labelSmall!.copyWith(
      color: Palette.mediumGray,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.17,
    ),
    fillColor: Palette.border,
    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Palette.border),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Palette.border),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Palette.border),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Palette.border),
    ),
    filled: true,
    labelStyle: TextStyle(
      color: Palette.border.withValues(alpha: .6),
      fontWeight: FontWeight.w400,
      fontSize: 40,
      height: 1,
    ),
  ),
  buttonTheme: darkBase.buttonTheme.copyWith(
    textTheme: ButtonTextTheme.primary,
    buttonColor: Palette.primary,
  ),
  toggleButtonsTheme: ToggleButtonsThemeData(
    borderRadius: BorderRadius.circular(4),
    borderColor: Palette.primary,
    color: Palette.primary,
    selectedBorderColor: Palette.primary,
    selectedColor: Palette.primary,
    fillColor: Palette.primary,
    constraints: const BoxConstraints(minHeight: 38, minWidth: 64),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 36, vertical: 16),
      ),
      elevation: const WidgetStatePropertyAll(0),
      textStyle: WidgetStatePropertyAll(darkBase.textTheme.bodyLarge),
      shape: WidgetStateProperty.resolveWith((states) {
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: states.contains(WidgetState.disabled)
                ? Palette.border
                : Palette.primary,
          ),
        );
      }),
      foregroundColor: const WidgetStatePropertyAll(Palette.white),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.disabled)
            ? Palette.border
            : Palette.white;
      }),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
      elevation: const WidgetStatePropertyAll(0),
      textStyle: WidgetStatePropertyAll(darkBase.textTheme.bodyLarge),
      shape: WidgetStateProperty.resolveWith((states) {
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: states.contains(WidgetState.disabled)
                ? Palette.border
                : Palette.primary,
          ),
        );
      }),
      foregroundColor: const WidgetStatePropertyAll(Palette.white),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.disabled)
            ? Palette.border
            : Palette.white;
      }),
    ),
  ),
  tooltipTheme: TooltipThemeData(
    preferBelow: false,
    decoration: BoxDecoration(
      color: Palette.primary,
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 44)),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 26, vertical: 13.5),
      ),
      overlayColor: WidgetStatePropertyAll(
        Palette.mediumGray.withValues(alpha: .2),
      ),
      elevation: const WidgetStatePropertyAll(0),
      textStyle: WidgetStatePropertyAll(
        darkBase.textTheme.bodyLarge!.copyWith(
          color: Palette.white,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.disabled)
            ? Palette.textColor
            : Palette.white;
      }),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.disabled)
            ? Palette.border
            : Palette.primary;
      }),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 44)),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 32, vertical: 11.5),
      ),
      overlayColor: WidgetStatePropertyAll(
        Palette.mediumGray.withValues(alpha: .1),
      ),
      elevation: const WidgetStatePropertyAll(0),
      textStyle: WidgetStatePropertyAll(
        darkBase.textTheme.bodyLarge!.copyWith(
          color: Palette.textColor,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1.17,
        ),
      ),
      side: const WidgetStatePropertyAll(BorderSide(color: Colors.transparent)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.transparent),
        ),
      ),
      foregroundColor: const WidgetStatePropertyAll(Palette.textColor),
      backgroundColor: const WidgetStatePropertyAll(Palette.border),
    ),
  ),
  textTheme: darkBase.textTheme.copyWith(
    titleLarge: darkBase.textTheme.titleLarge!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      letterSpacing: 0,
    ),
    displayLarge: darkBase.textTheme.displayLarge!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w700,
      fontSize: 30,
      letterSpacing: 0,
      height: 1.26,
    ),
    labelMedium: darkBase.textTheme.labelMedium!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w600,
      fontSize: 26,
      letterSpacing: 0,
    ),
    displayMedium: darkBase.textTheme.displayMedium!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w700,
      fontSize: 22,
      letterSpacing: 0,
      height: 1.26,
    ),
    displaySmall: darkBase.textTheme.displaySmall!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      letterSpacing: 0,
      height: 1.19,
    ),
    headlineMedium: darkBase.textTheme.headlineMedium!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      letterSpacing: 0,
      height: 1.24,
    ),
    headlineLarge: darkBase.textTheme.headlineLarge!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      height: 1.21,
      letterSpacing: 0,
    ),
    headlineSmall: darkBase.textTheme.headlineSmall!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: 0,
      height: 1.17,
    ),
    bodyLarge: darkBase.textTheme.bodyLarge!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w300,
      fontSize: 14,
      letterSpacing: 0,
      height: 1.17,
    ),
    bodyMedium: darkBase.textTheme.bodyMedium!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: 0,
      height: 1.14,
    ),
    labelSmall: darkBase.textTheme.labelSmall!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: 0,
      height: 1.17,
    ),
    titleMedium: darkBase.textTheme.titleMedium!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.17,
    ),
    labelLarge: darkBase.textTheme.labelLarge!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      letterSpacing: 0,
      height: 1.14,
    ),
    titleSmall: darkBase.textTheme.titleSmall!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w400,
      fontSize: 10,
      letterSpacing: 0,
      height: 1.12,
    ),
    bodySmall: darkBase.textTheme.bodySmall!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w300,
      fontSize: 10,
      letterSpacing: 0,
      height: 1.12,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return Palette.primary;
      }
      return null;
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return Palette.primary;
      }
      return null;
    }),
  ),
  switchTheme: darkBase.switchTheme
      .copyWith(
        trackColor: const WidgetStatePropertyAll(Palette.primary),
        thumbColor: const WidgetStatePropertyAll(Palette.primary),
      )
      .copyWith(
        thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return Palette.primary;
          }
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return Palette.primary;
          }
          return null;
        }),
      ),
);
