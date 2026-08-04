import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/theme/themes.dart';

class SignicaAddDocumentFab extends StatelessWidget {
  const SignicaAddDocumentFab({
    this.onTap,
    super.key,
  });

  final VoidCallback? onTap;

  double get height => 52;
  double get iconSize => 24;
  double get borderRadius => 100;
  EdgeInsets get contentPadding =>
      const EdgeInsets.symmetric(horizontal: 16, vertical: 14);

  @override
  Widget build(BuildContext context) {
    final label = 'main.more_menu.add_document'.tr();
    final labelStyle = AppTextStyles.addDocumentSourceLabel.copyWith(
      color: Palette.black,
    );
    final textScaler = MediaQuery.textScalerOf(context);
    final textPainter = TextPainter(
      text: TextSpan(text: label, style: labelStyle),
      textDirection: Directionality.of(context),
      textScaler: textScaler,
      maxLines: 1,
    )..layout();

    final width = contentPadding.horizontal +
        iconSize +
        marginSizeSmall +
        textPainter.width;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Ink(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: Palette.addDocumentFabGradient,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  gradient: Palette.addDocumentFabGlassOverlay,
                ),
              ),
              Padding(
                padding: contentPadding,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.addDocumentFabIcon.png(
                      width: iconSize,
                      height: iconSize,
                    ),
                    SizedBox(width: marginSizeSmall),
                    Text(label, style: labelStyle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
