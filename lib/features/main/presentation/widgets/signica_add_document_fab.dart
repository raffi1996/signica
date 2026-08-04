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

    final width = addDocumentFabPadding.horizontal +
        addDocumentFabIconSize +
        marginSizeSmall +
        textPainter.width;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(addDocumentFabBorderRadius),
        child: Ink(
          width: width,
          height: addDocumentFabHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(addDocumentFabBorderRadius),
            gradient: Palette.addDocumentFabGradient,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(addDocumentFabBorderRadius),
                  gradient: Palette.addDocumentFabGlassOverlay,
                ),
              ),
              Padding(
                padding: addDocumentFabPadding,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.addDocumentFabIcon.png(
                      width: addDocumentFabIconSize,
                      height: addDocumentFabIconSize,
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
