import 'package:flutter/material.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/theme/themes.dart';

/// Centered selection indicator for document preview (Figma multi-select).
class DocumentSelectionOverlay extends StatelessWidget {
  const DocumentSelectionOverlay({
    required this.isSelected,
    super.key,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: documentSelectionIndicatorSize,
      height: documentSelectionIndicatorSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? Palette.documentSelectionSelected
              : Palette.documentSelectionUnselectedFill,
          border: isSelected
              ? null
              : Border.all(
                  color: Palette.documentSelectionUnselectedBorder,
                  width: documentSelectionBorderWidth,
                ),
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                    color: Color(0x29000000),
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: isSelected
            ? Center(
                child: Assets.checkIcon.svg(
                  width: documentSelectionCheckSize,
                  height: documentSelectionCheckSize,
                ),
              )
            : null,
      ),
    );
  }
}
