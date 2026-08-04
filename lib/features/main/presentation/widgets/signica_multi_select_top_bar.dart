import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/core/theme/themes.dart';
import 'package:signica/features/main/presentation/widgets/signica_more_button.dart';

/// Top glass chrome for multi-select: Select All / Deselect All + close.
class SignicaMultiSelectTopBar extends StatelessWidget {
  const SignicaMultiSelectTopBar({
    required this.selectedCount,
    required this.allSelected,
    required this.onSelectAllTap,
    required this.onCloseTap,
    super.key,
  });

  final int selectedCount;
  final bool allSelected;
  final VoidCallback onSelectAllTap;
  final VoidCallback onCloseTap;

  static const LiquidGlassSettings _glassSettings = LiquidGlassSettings(
    blur: 4,
    glassColor: Palette.multiSelectTopBarGlass,
    lightIntensity: 1.1,
    fresnelStrength: 0,
  );

  @override
  Widget build(BuildContext context) {
    final label = allSelected
        ? 'main.multi_select.deselect_all'.tr(
            namedArgs: {'count': '$selectedCount'},
          )
        : 'main.multi_select.select_all'.tr();

    final labelStyle = AppTextStyles.multiSelectActionLabel.copyWith(
      color: Palette.multiSelectTopBarText,
      decoration: TextDecoration.none,
    );

    final textPainter = TextPainter(
      text: TextSpan(text: label, style: labelStyle),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
      maxLines: 1,
    )..layout();

    final selectAllWidth =
        multiSelectSelectAllHorizontalPadding * 2 + textPainter.width;

    return Positioned(
      top: moreButtonTopForToolbar(context),
      left: multiSelectTopBarHorizontalInset,
      right: multiSelectTopBarHorizontalInset,
      child: Row(
        children: [
          GlassButton.custom(
            width: selectAllWidth,
            height: multiSelectSelectAllHeight,
            useOwnLayer: true,
            settings: _glassSettings,
            stretch: 0.1,
            shape: const LiquidRoundedRectangle(
              borderRadius: multiSelectSelectAllRadius,
            ),
            label: label,
            onTap: onSelectAllTap,
            child: Center(
              child: Text(label, style: labelStyle),
            ),
          ),
          const Spacer(),
          GlassButton.custom(
            width: multiSelectCloseButtonSize,
            height: multiSelectCloseButtonSize,
            useOwnLayer: true,
            settings: _glassSettings,
            stretch: 0.1,
            label: 'main.multi_select.close'.tr(),
            onTap: onCloseTap,
            child: const Center(
              child: Icon(
                Icons.close,
                color: Palette.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
