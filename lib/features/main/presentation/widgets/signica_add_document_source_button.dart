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

  static const double height = 56;
  static const double borderRadius = 100;
  static const EdgeInsets contentPadding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 16);

  static const LiquidGlassSettings glassSettings = LiquidGlassSettings(
    blur: 4,
    glassColor: Color(0x00000000),
    lightIntensity: 1.1,
    fresnelStrength: 0,
  );

  @override
  Widget build(BuildContext context) {
    return GlassButton.custom(
      height: height,
      useOwnLayer: true,
      settings: glassSettings,
      shape: const LiquidRoundedRectangle(borderRadius: borderRadius),
      stretch: 0.15,
      label: label,
      onTap: onTap ?? () {},
      child: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: Palette.addDocumentSourceGradient,
            ),
          ),
          Padding(
            padding: contentPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                const SizedBox(width: marginSizeSmall),
                Text(
                  label,
                  style: AppTextStyles.addDocumentSourceLabel.copyWith(
                    color: Palette.menuTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
