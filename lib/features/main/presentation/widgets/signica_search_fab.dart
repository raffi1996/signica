import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/theme/themes.dart';

class SignicaSearchFab extends StatelessWidget {
  const SignicaSearchFab({
    this.onTap,
    super.key,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GlassButton.custom(
      width: searchFabSize,
      height: searchFabSize,
      useOwnLayer: true,
      settings: const LiquidGlassSettings(
        blur: 4,
        glassColor: Color(0x00000000),
        lightIntensity: 1.1,
        fresnelStrength: 0,
      ),
      stretch: 0.15,
      label: 'Search',
      onTap: onTap ?? () {},
      child: Center(
        child: Assets.searchIcon.png(),
      ),
    );
  }
}
