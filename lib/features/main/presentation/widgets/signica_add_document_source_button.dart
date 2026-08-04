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
    thickness: 28,
    blur: 4,
    glassColor: Color(0x20FFFFFF),
    lightIntensity: 0.85,
    fresnelStrength: 0.25,
  );

  @override
  Widget build(BuildContext context) {
    final labelStyle = AppTextStyles.addDocumentSourceLabel.copyWith(
      color: Palette.menuTextColor,
      decoration: TextDecoration.none,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: labelStyle,
      ),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
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
      shape: LiquidRoundedRectangle(
        borderRadius: borderRadius,
      ),
      stretch: 0.15,
      label: label,
      onTap: onTap ?? () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const Opacity(
              opacity: 0.35,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: Palette.addDocumentSourceGradient,
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: const Color(0x35FFFFFF),
                  width: 0.8,
                ),
                gradient: Palette.addDocumentSourceGradient,
              ),
            ),

            Padding(
              padding: contentPadding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Center(child: icon),
                  ),
                  const SizedBox(width: marginSizeSmall),
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: labelStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
