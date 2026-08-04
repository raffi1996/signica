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
      width: 63,
      height: 63,
      useOwnLayer: true,
      settings: searchFabGlassSettings,
      stretch: 0.15,
      label: 'Search',
      onTap: onTap ?? () {},
      child: Assets.searchIcon.png(),
    );
  }
}
