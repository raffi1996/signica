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

  double get height => 56;

  double get iconSize => 24;

  double get borderRadius => 100;

  EdgeInsets get contentPadding =>
      const EdgeInsets.symmetric(horizontal: 20, vertical: 16);

  LiquidGlassSettings get glassSettings => const LiquidGlassSettings(
    blur: 4,
    glassColor: Color(0x00000000),
    lightIntensity: 1.1,
    fresnelStrength: 0,
  );

  @override
  Widget build(BuildContext context) {
    final labelStyle = AppTextStyles.addDocumentSourceLabel.copyWith(
      color: Palette.menuTextColor,
      decoration: TextDecoration.none,
    );
    final textScaler = MediaQuery.textScalerOf(context);
    final textPainter = TextPainter(
      text: TextSpan(text: label, style: labelStyle),
      textDirection: Directionality.of(context),
      textScaler: textScaler,
      maxLines: 1,
    )..layout();

    final width =
        contentPadding.horizontal +
        iconSize +
        marginSizeSmall +
        textPainter.width;

    return GlassButton.custom(
      width: width,
      height: height,
      useOwnLayer: true,
      settings: glassSettings,
      shape: LiquidRoundedRectangle(borderRadius: borderRadius),
      stretch: 0.15,
      label: label,
      onTap: onTap ?? () {},
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: Palette.addDocumentSourceGradient,
        ),
        child: Padding(
          padding: contentPadding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(width: marginSizeSmall),
              Text(label, style: labelStyle),
            ],
          ),
        ),
      ),
    );
  }
}
