import 'package:flutter/material.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/theme/themes.dart';

/// Centered selection indicator for document preview (Figma multi-select).
///
/// Unselected: empty circle icon with drop shadow.
/// Selected: green check circle icon.
class DocumentSelectionOverlay extends StatelessWidget {
  const DocumentSelectionOverlay({
    required this.isSelected,
    super.key,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final icon = (isSelected
            ? Assets.selectionSelectedIcon
            : Assets.selectionUnselectedIcon)
        .svg(
      width: documentSelectionIndicatorSize,
      height: documentSelectionIndicatorSize,
    );

    if (isSelected) {
      return SizedBox(
        width: documentSelectionIndicatorSize,
        height: documentSelectionIndicatorSize,
        child: icon,
      );
    }

    // Figma drop shadow: Offset(0, 1), blur 2, spread 0, #000000 60%.
    return SizedBox(
      width: documentSelectionIndicatorSize,
      height: documentSelectionIndicatorSize,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: documentSelectionUnselectedShadowColor,
              offset: documentSelectionUnselectedShadowOffset,
              blurRadius: documentSelectionUnselectedShadowBlur,
              // ignore: avoid_redundant_argument_values — Figma: 0
              spreadRadius: documentSelectionUnselectedShadowSpread,
            ),
          ],
        ),
        child: icon,
      ),
    );
  }
}
