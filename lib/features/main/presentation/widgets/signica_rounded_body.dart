import 'package:flutter/material.dart';
import 'package:signica/core/theme/themes.dart';

class SignicaRoundedBody extends StatelessWidget {
  const SignicaRoundedBody({
    required this.child,
    super.key,
  });

  final Widget child;

  static const double topRadius = radiusSizeXLarge;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(topRadius),
      ),
      child: ColoredBox(
        color: Palette.scaffoldBackground,
        child: child,
      ),
    );
  }
}
