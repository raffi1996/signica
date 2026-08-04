import 'package:flutter/material.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/theme/themes.dart';

/// Centered selection indicator for document preview (Figma multi-select).
///
/// Unselected: empty circle icon.
/// Selected: green check circle icon.
class DocumentSelectionOverlay extends StatelessWidget {
  const DocumentSelectionOverlay({
    required this.isSelected,
    super.key,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final asset = isSelected
        ? Assets.selectionSelectedIcon
        : Assets.selectionUnselectedIcon;

    return SizedBox(
      width: documentSelectionIndicatorSize,
      height: documentSelectionIndicatorSize,
      child: asset.svg(
        width: documentSelectionIndicatorSize,
        height: documentSelectionIndicatorSize,
      ),
    );
  }
}
