import 'package:flutter/material.dart';
import 'package:signica/core/theme/themes.dart';

class UnselectedCheckbox extends StatelessWidget {
  const UnselectedCheckbox({super.key});

  static const double size = 38;
  static const double borderWidth = 2.5;

  static const double _shadowPadding = 4;

  static const Offset shadowOffset = Offset(0, 1);
  static const double shadowBlur = 2;
  static const Color shadowColor = Color(0x99000000);
  static const Color borderColor = Palette.white;

  @override
  Widget build(BuildContext context) {
    const paintSize = size + _shadowPadding * 2;
    return const SizedBox(
      width: paintSize,
      height: paintSize,
      child: CustomPaint(
        painter: _UnselectedCheckboxPainter(),
      ),
    );
  }
}

class _UnselectedCheckboxPainter extends CustomPainter {
  const _UnselectedCheckboxPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const radius =
        (UnselectedCheckbox.size - UnselectedCheckbox.borderWidth) / 2;

    final shadowPaint = Paint()
      ..color = UnselectedCheckbox.shadowColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = UnselectedCheckbox.borderWidth
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        UnselectedCheckbox.shadowBlur / 2,
      );

    canvas.drawCircle(
      center + UnselectedCheckbox.shadowOffset,
      radius,
      shadowPaint,
    );

    final borderPaint = Paint()
      ..color = UnselectedCheckbox.borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = UnselectedCheckbox.borderWidth;

    canvas.drawCircle(center, radius, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _UnselectedCheckboxPainter oldDelegate) => false;
}
