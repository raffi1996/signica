import 'package:flutter/material.dart';

const double marginSizeSmall = 8;
const double marginSizeNormal = 12;
const double marginSizeMedium = 16;
const double marginSizeDefault = 20;
const double marginSizeLarge = 24;
const double marginSizeXLarge = 32;
const double marginSizeXXLarge = 40;

const double appBarLogoHeight = 38;
const double appBarToolbarHeight = 66;
const double appBarLogoTopSpacing =
    appBarToolbarHeight - appBarLogoHeight - marginSizeMedium;

const double emptyStateImageTopSpacing = 66;

const double paddingSizeSmall = 8;
const double paddingSizeNormal = 12;
const double paddingSizeMedium = 16;
const double paddingSizeDefault = 20;
const double paddingSizeLarge = 24;
const double paddingSizeXLarge = 32;
const double paddingSizeXLarge36 = 36;
const double paddingSizeXXLarge = 40;

const double radiusSizeSmall = 8;
const double radiusSizeNormal = 12;
const double radiusSizeMedium = 16;
const double radiusSizeDefault = 20;
const double radiusSizeLarge = 24;
const double radiusSizeXLarge = 32;
const double radiusSizeXXLarge = 40;

const double fontSizeMicro = 12;
const double fontSizeSmall = 14;
const double fontSizeMedium = 16;
const double fontSizeLarge = 20;
const double fontSizeXLarge = 32;
const double fontSizeXXLarge = 45;
const double fontSizeXXXLarge = 56;

const double touchSizeMedium = 48;

const double kDefaultBorderRadius = 0;

const double moreButtonSize = 38;
const double moreButtonAppBarActionWidth = moreButtonSize + marginSizeMedium;
const double searchFabSize = 63;

/// Multi-select top bar (Figma).
const double multiSelectCloseButtonSize = 38;
const double multiSelectSelectAllHeight = 38;
const double multiSelectSelectAllRadius = 19;
const double multiSelectSelectAllHorizontalPadding = 16;
const double multiSelectTopBarHorizontalInset = marginSizeMedium;

/// Multi-select bottom glass action buttons (Figma).
const double multiSelectActionButtonSize = searchFabSize;
const double multiSelectActionIconSize = 34;

/// Document card selection indicator (Figma).
const double documentSelectionIndicatorSize = 42;

double mainFabBottomInset(BuildContext context) =>
    marginSizeMedium + MediaQuery.paddingOf(context).bottom;
