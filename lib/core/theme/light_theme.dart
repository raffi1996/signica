import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signica/core/theme/themes.dart';

final lightBase = ThemeData(
  fontFamily: FontFamily.rubik,
  useMaterial3: false,
  brightness: Brightness.light,
);

final ThemeData lightTheme = lightBase.copyWith(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  primaryColor: Palette.primary,
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Palette.white),
  expansionTileTheme: lightBase.expansionTileTheme.copyWith(
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
  scaffoldBackgroundColor: Palette.scaffoldBackground,
  drawerTheme: const DrawerThemeData(backgroundColor: Palette.white),
  dividerColor: Palette.border,
  dividerTheme: lightBase.dividerTheme.copyWith(
    space: 1,
    thickness: 1,
    indent: 0,
    endIndent: 0,
    color: Palette.border,
  ),
  primaryIconTheme: lightBase.primaryIconTheme.copyWith(color: Palette.primary),
  iconTheme: lightBase.iconTheme.copyWith(color: Palette.border),
  appBarTheme: lightBase.appBarTheme.copyWith(
    centerTitle: false,
    titleSpacing: 8,
    iconTheme: const IconThemeData(color: Palette.primary),
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: Palette.white,
    shadowColor: Palette.primary.withValues(alpha: 0.15),
    titleTextStyle: lightBase.primaryTextTheme.titleLarge!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w600,
      fontSize: 26,
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
    toolbarTextStyle: lightBase.textTheme
        .copyWith(
          bodyLarge: lightBase.textTheme.bodyLarge!.copyWith(
            color: Palette.primary,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: lightBase.textTheme.titleLarge!.copyWith(
            color: Palette.textColor,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: lightBase.textTheme.displaySmall!.copyWith(
            color: Palette.primary,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: lightBase.textTheme.headlineMedium!.copyWith(
            color: Palette.primary,
            fontWeight: FontWeight.w500,
          ),
        )
        .bodyMedium,
  ),
  bottomNavigationBarTheme: lightBase.bottomNavigationBarTheme.copyWith(
    backgroundColor: Palette.backgroundColor,
    selectedItemColor: Palette.primary,
    unselectedItemColor: Palette.white,
    selectedLabelStyle: lightBase.textTheme.bodyMedium,
    unselectedLabelStyle: lightBase.textTheme.bodyLarge,
    elevation: 4,
    type: BottomNavigationBarType.shifting,
  ),
  chipTheme: lightBase.chipTheme.copyWith(
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
  sliderTheme: lightBase.sliderTheme.copyWith(
    activeTrackColor: Palette.primary,
    inactiveTrackColor: Palette.primary,
    overlayColor: Palette.white,
    thumbColor: Palette.primary,
    thumbShape: SliderComponentShape.noOverlay,
    valueIndicatorColor: Palette.primary,
  ),
  textSelectionTheme: lightBase.textSelectionTheme.copyWith(
    cursorColor: Palette.primary,
    selectionHandleColor: Palette.primary,
  ),
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: Palette.primary,
  ),
  brightness: Brightness.light,
  inputDecorationTheme: lightBase.inputDecorationTheme.copyWith(
    prefixStyle: lightBase.textTheme.bodyLarge!.copyWith(color: Palette.border),
    disabledBorder: InputBorder.none,
    errorStyle: const TextStyle(
      color: Palette.errorColor,
      fontWeight: FontWeight.w400,
      height: 1.2,
    ),
    hintStyle: lightBase.primaryTextTheme.labelSmall!.copyWith(
      color: Palette.darkGray3,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.5,
    ),
    fillColor: Palette.darkGray1,
    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Palette.errorColor),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Palette.activeStroke),
    ),
    filled: true,
    labelStyle: TextStyle(
      color: Palette.border.withValues(alpha: .6),
      fontWeight: FontWeight.w400,
      fontSize: 40,
      height: 1,
    ),
  ),
  buttonTheme: lightBase.buttonTheme.copyWith(
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
        EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      ),
      elevation: const WidgetStatePropertyAll(0),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(
          color: Palette.textColor,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0,
          height: 1,
        ),
      ),
      shape: WidgetStateProperty.resolveWith((states) {
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
      }),
      overlayColor: const WidgetStatePropertyAll(Palette.lightGray1),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.disabled)
            ? Palette.darkGray3
            : Palette.textColor;
      }),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.disabled)
            ? Palette.lightGray1
            : Palette.white;
      }),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
      elevation: const WidgetStatePropertyAll(0),
      textStyle: WidgetStatePropertyAll(lightBase.textTheme.bodyLarge),
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
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Palette.white,
    strokeWidth: 1.5,
    constraints: BoxConstraints(
      maxWidth: 20,
      maxHeight: 20,
      minHeight: 20,
      minWidth: 20,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 48)),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 26, vertical: 12),
      ),
      overlayColor: const WidgetStatePropertyAll(Palette.deepCoral),
      elevation: const WidgetStatePropertyAll(0),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(
          color: Palette.textColor,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0,
          height: 1,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.disabled)
            ? Palette.gray1
            : Palette.white;
      }),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.disabled)
            ? Palette.darkGray3
            : Palette.coral;
      }),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 48)),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 26, vertical: 12),
      ),
      overlayColor: const WidgetStatePropertyAll(Palette.darkGray2),
      elevation: const WidgetStatePropertyAll(0),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(
          color: Palette.textColor,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0,
          height: 1,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.disabled)
            ? Palette.darkGray3
            : Palette.coral;
      }),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.disabled)
            ? Palette.darkGray1
            : Palette.darkGray1;
      }),
    ),
  ),
  textTheme: lightBase.textTheme.copyWith(
    titleLarge: lightBase.textTheme.titleLarge!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w600,
      fontSize: 24,
      letterSpacing: 0,
      height: 1.30,
    ),
    titleMedium: lightBase.textTheme.titleMedium!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w500,
      fontSize: 18,
      letterSpacing: 0,
      height: 1.22,
    ),
    titleSmall: lightBase.textTheme.titleSmall!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      letterSpacing: 0,
      height: 1.20,
    ),
    headlineLarge: lightBase.textTheme.headlineLarge!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      height: 1.18,
      letterSpacing: 0,
    ),
    displayLarge: lightBase.textTheme.displayLarge!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      letterSpacing: 0,
      height: 1,
    ),
    displayMedium: lightBase.textTheme.displayMedium!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      letterSpacing: 0,
      height: 1,
    ),
    bodyLarge: lightBase.textTheme.bodyLarge!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: 0,
      height: 1.5,
    ),
    bodyMedium: lightBase.textTheme.bodyMedium!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: 0,
      height: 1.5,
    ),
    labelLarge: lightBase.textTheme.labelLarge!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w600,
      fontSize: 12,
      letterSpacing: 0,
      height: 1,
    ),
    labelMedium: lightBase.textTheme.labelMedium!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 1,
      letterSpacing: 0,
    ),
    headlineSmall: lightBase.textTheme.headlineSmall!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w600,
      fontSize: 10,
      letterSpacing: 0,
      height: 1,
    ),
    displaySmall: lightBase.textTheme.displaySmall!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w400,
      fontSize: 10,
      letterSpacing: 0,
      height: 1.1,
    ),
    labelSmall: lightBase.textTheme.labelSmall!.copyWith(
      color: Palette.textColor,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: 0,
      height: 1.17,
    ),
    bodySmall: lightBase.textTheme.bodySmall!.copyWith(
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
  switchTheme: lightBase.switchTheme
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
