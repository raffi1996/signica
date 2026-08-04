import 'package:flutter/material.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/theme/themes.dart';
import 'package:signica/features/main/presentation/widgets/unselected_checkbox.dart';

/// Centered selection indicator for document preview (Figma multi-select).
///
/// Unselected: [UnselectedCheckbox] widget.
/// Selected: green check circle icon.
class DocumentSelectionOverlay extends StatelessWidget {
  const DocumentSelectionOverlay({
    required this.isSelected,
    super.key,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    if (!isSelected) {
      return const UnselectedCheckbox();
    }

    return SizedBox(
      width: documentSelectionIndicatorSize,
      height: documentSelectionIndicatorSize,
      child: Assets.selectionSelectedIcon.svg(
        width: documentSelectionIndicatorSize,
        height: documentSelectionIndicatorSize,
      ),
    );
  }
}
