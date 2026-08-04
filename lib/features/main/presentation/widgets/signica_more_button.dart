import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/theme/themes.dart';

double moreButtonTopForToolbar(BuildContext context) {
  final topInset = MediaQuery.paddingOf(context).top;
  return topInset + (appBarToolbarHeight - moreButtonSize) / 2;
}

class SignicaMoreButton extends StatelessWidget {
  const SignicaMoreButton({super.key});

  double get size => moreButtonSize;

  @override
  Widget build(BuildContext context) {
    final menuTitleStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
      color: Palette.menuTextColor,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );
    return GlassMenu(
      menuWidth: 262,
      menuHeight: 100,
      menuBorderRadius: 34,
      menuAlignment: GlassMenuAlignment.topRight,
      autoAdjustToScreen: true,
      menuPadding: const EdgeInsets.only(right: marginSizeMedium),
      settings: const LiquidGlassSettings(
        blur: 4,
        glassColor: Palette.menuGlassColor,
        lightIntensity: 1.1,
        fresnelStrength: 0,
      ),
      triggerBuilder: (context, toggleMenu) {
        return GlassButton(
          width: size,
          height: size,
          settings: const LiquidGlassSettings(
            blur: 4,
            glassColor: Color(0x1AFFFFFF),
            lightIntensity: 1.1,
            fresnelStrength: 0,
          ),
          shape: const LiquidRoundedRectangle(borderRadius: 15.2),
          onTap: toggleMenu,
          icon: Assets.moreIcon.svg(),
          label: 'main.more_menu.more_options'.tr(),
        );
      },
      items: [
        GlassMenuItem(
          title: 'main.more_menu.select'.tr(),
          icon: Assets.selectMenuIcon.png(width: 24, height: 24),
          height: 37,
          iconSize: 24,
          titleStyle: menuTitleStyle,
          onTap: () {
            // TODO(signica): enter selection mode.
          },
        ),
        GlassMenuItem(
          title: 'main.more_menu.add_document'.tr(),
          icon: Assets.addDocumentMenuIcon.png(width: 24, height: 24),
          height: 37,
          iconSize: 24,
          titleStyle: menuTitleStyle,
          onTap: () {
            // TODO(signica): add document flow.
          },
        ),
      ],
    );
  }
}
