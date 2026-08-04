import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/theme/themes.dart';

class SignicaMoreButton extends StatelessWidget {
  const SignicaMoreButton({super.key});

  static const double size = 38;

  static const _buttonGlassSettings = LiquidGlassSettings(
    blur: 4,
    glassColor: Color(0x1AFFFFFF),
    lightIntensity: 1.1,
    fresnelStrength: 0,
  );

  static const double _menuWidth = 262;
  static const double _menuHeight = 100;
  static const double _menuBorderRadius = 34;
  static const Color _menuGlassColor = Color(0x99F5F5F5);
  static const Color _menuTextColor = Color(0xFF262626);
  static const double _menuItemLeftInset = 32;

  static const double _menuItemLeftChrome = 12 + 16;
  static const double _menuItemIconLeftPadding =
      _menuItemLeftInset - _menuItemLeftChrome;

  static const double _menuInnerVerticalPadding = 12 + 12 + 2;

  static const _menuGlassSettings = LiquidGlassSettings(
    blur: 4,
    glassColor: _menuGlassColor,
    lightIntensity: 1.1,
    fresnelStrength: 0,
  );

  static const _buttonShape = LiquidRoundedRectangle(borderRadius: 15.2);

  static double topForToolbar(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    return topInset + (kToolbarHeight - size) / 2;
  }

  static double get appBarActionWidth => size + marginSizeMedium;

  static Widget _menuItemIcon(Widget icon) {
    return Padding(
      padding: const EdgeInsets.only(left: _menuItemIconLeftPadding),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    const itemHeight = (_menuHeight - _menuInnerVerticalPadding) / 2;

    final menuTitleStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
          color: _menuTextColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        );

    return GlassMenu(
      menuWidth: _menuWidth,
      menuHeight: _menuHeight,
      menuBorderRadius: _menuBorderRadius,
      menuAlignment: GlassMenuAlignment.topRight,
      autoAdjustToScreen: true,
      menuPadding: const EdgeInsets.only(right: marginSizeMedium),
      settings: _menuGlassSettings,
      triggerBuilder: (context, toggleMenu) {
        return GlassButton(
          width: size,
          height: size,
          settings: _buttonGlassSettings,
          shape: _buttonShape,
          onTap: toggleMenu,
          icon: Assets.moreIcon.svg(),
          label: 'main.more_menu.more_options'.tr(),
        );
      },
      items: [
        GlassMenuItem(
          title: 'main.more_menu.select'.tr(),
          icon: _menuItemIcon(
            Assets.selectMenuIcon.png(width: 24, height: 24),
          ),
          height: itemHeight,
          iconSize: 24,
          titleStyle: menuTitleStyle,
          onTap: () {
            // TODO(signica): enter selection mode.
          },
        ),
        GlassMenuItem(
          title: 'main.more_menu.add_document'.tr(),
          icon: _menuItemIcon(
            Assets.addDocumentMenuIcon.png(width: 24, height: 24),
          ),
          height: itemHeight,
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
