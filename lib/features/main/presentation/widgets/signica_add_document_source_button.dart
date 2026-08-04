import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/core/theme/themes.dart';

class SignicaAddDocumentSourceButton extends StatelessWidget {
  const SignicaAddDocumentSourceButton({
    required this.icon,
    required this.label,
    this.onTap,
    super.key,
  });

  final Widget icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final labelStyle = AppTextStyles.addDocumentSourceLabel.copyWith(
      color: Palette.menuTextColor,
    );
    final textScaler = MediaQuery.textScalerOf(context);
    final textPainter = TextPainter(
      text: TextSpan(text: label, style: labelStyle),
      textDirection: Directionality.of(context),
      textScaler: textScaler,
      maxLines: 1,
    )..layout();

    final width = addDocumentSourceButtonPadding.horizontal +
        addDocumentSourceButtonIconSize +
        marginSizeSmall +
        textPainter.width;

    return GlassButton.custom(
      width: width,
      height: addDocumentSourceButtonHeight,
      useOwnLayer: true,
      settings: addDocumentSourceGlassSettings,
      shape: LiquidRoundedRectangle(
        borderRadius: addDocumentSourceButtonBorderRadius,
      ),
      stretch: 0.15,
      label: label,
      onTap: onTap ?? () {},
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: Palette.addDocumentSourceGradient,
        ),
        child: Padding(
          padding: addDocumentSourceButtonPadding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              SizedBox(width: marginSizeSmall),
              Text(label, style: labelStyle),
            ],
          ),
        ),
      ),
    );
  }
}
