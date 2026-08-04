import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

double get marginSizeSmall => 8;
double get marginSizeNormal => 12;
double get marginSizeMedium => 16;
double get marginSizeDefault => 20;
double get marginSizeLarge => 24;
double get marginSizeXLarge => 32;
double get marginSizeXXLarge => 40;

double get appBarLogoHeight => 38;
double get appBarToolbarHeight => 66;
double get appBarLogoTopSpacing =>
    appBarToolbarHeight - appBarLogoHeight - marginSizeMedium;

double get emptyStateImageTopSpacing => 66;

double get documentTabBarHeight => 36;
double get documentTabBarInnerPadding => 4;
double get documentTabBarDividerHeight => 28;

double get addDocumentSourceButtonHeight => 56;
double get addDocumentSourceButtonIconSize => 24;
double get addDocumentSourceButtonBorderRadius => 100;
EdgeInsets get addDocumentSourceButtonPadding =>
    const EdgeInsets.symmetric(horizontal: 20, vertical: 16);

LiquidGlassSettings get addDocumentSourceGlassSettings =>
    const LiquidGlassSettings(
      blur: 4,
      glassColor: Color(0x00000000),
      lightIntensity: 1.1,
      fresnelStrength: 0,
    );

double get moreButtonSize => 38;
double get moreButtonAppBarActionWidth => moreButtonSize + marginSizeMedium;

double get paddingSizeSmall => 8;
double get paddingSizeNormal => 12;
double get paddingSizeMedium => 16;
double get paddingSizeDefault => 20;
double get paddingSizeLarge => 24;
double get paddingSizeXLarge => 32;
double get paddingSizeXLarge36 => 36;
double get paddingSizeXXLarge => 40;

double get radiusSizeSmall => 8;
double get radiusSizeNormal => 12;
double get radiusSizeMedium => 16;
double get radiusSizeDefault => 20;
double get radiusSizeLarge => 24;
double get radiusSizeXLarge => 32;
double get radiusSizeXXLarge => 40;

double get fontSizeMicro => 12;
double get fontSizeSmall => 14;
double get fontSizeMedium => 16;
double get fontSizeLarge => 20;
double get fontSizeXLarge => 32;
double get fontSizeXXLarge => 45;
double get fontSizeXXXLarge => 56;

double get touchSizeMedium => 48;

double get kDefaultBorderRadius => 0;
