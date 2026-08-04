import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/theme/themes.dart';

class SignicaMoreButton extends StatelessWidget {
  const SignicaMoreButton({super.key});

  static const double size = 38;

  static double topForToolbar(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    return topInset + (kToolbarHeight - size) / 2;
  }

  static double get appBarActionWidth => size + marginSizeMedium;

  @override
  Widget build(BuildContext context) {
    return GlassButton(
      width: size,
      height: size,
      settings: const LiquidGlassSettings(
        blur: 4,
        glassColor: Color(0x1AFFFFFF),
        lightIntensity: 1.1,
        fresnelStrength: 0,
      ),
      shape: const LiquidRoundedRectangle(
        borderRadius: 15.2,
      ),
      onTap: () {
        // TODO(signica): open more menu.
      },
      icon: Assets.moreIcon.svg(),
    );
  }
}
