import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/core/theme/themes.dart';

class SignicaMultiSelectActionButton extends StatelessWidget {
  const SignicaMultiSelectActionButton({
    required this.icon,
    required this.label,
    required this.enabled,
    this.onTap,
    super.key,
  });

  final Widget icon;
  final String label;
  final bool enabled;
  final VoidCallback? onTap;

  static const LiquidGlassSettings glassSettings = LiquidGlassSettings(
    blur: 4,
    glassColor: Color(0x00000000),
    lightIntensity: 1.1,
    fresnelStrength: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: AbsorbPointer(
        absorbing: !enabled,
        child: GlassButton.custom(
          width: multiSelectActionButtonSize,
          height: multiSelectActionButtonSize,
          useOwnLayer: true,
          settings: glassSettings,
          stretch: 0.15,
          label: label,
          onTap: enabled ? (onTap ?? () {}) : () {},
          child: Center(child: icon),
        ),
      ),
    );
  }
}
