import 'package:flutter/material.dart';

const double marginSizeSmall = 8;
const double marginSizeNormal = 12;
const double marginSizeMedium = 16;
const double marginSizeLarge = 24;
const double marginSizeXLarge = 32;

const double appBarLogoHeight = 38;
const double appBarToolbarHeight = 66;

const double emptyStateImageTopSpacing = 66;

const double radiusSizeXLarge = 32;

const double moreButtonSize = 38;
const double moreButtonAppBarActionWidth = moreButtonSize + marginSizeMedium;
const double searchFabSize = 63;

const double multiSelectCloseButtonSize = 38;
const double multiSelectSelectAllHeight = 38;
const double multiSelectSelectAllRadius = 19;
const double multiSelectSelectAllHorizontalPadding = 16;
const double multiSelectTopBarHorizontalInset = marginSizeMedium;

const double multiSelectActionButtonSize = searchFabSize;
const double multiSelectActionIconSize = 34;

const double documentSelectionIndicatorSize = 42;

double mainFabBottomInset(BuildContext context) =>
    marginSizeMedium + MediaQuery.paddingOf(context).bottom;
