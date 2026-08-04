import 'package:flutter/material.dart';
import 'package:signica/core/theme/themes.dart';

class SignicaRoundedBody extends StatelessWidget {
  const SignicaRoundedBody({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(radiusSizeXLarge),
      ),
      child: ColoredBox(
        color: Palette.scaffoldBackground,
        child: child,
      ),
    );
  }
}
