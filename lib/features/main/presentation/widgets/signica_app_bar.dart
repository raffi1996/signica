import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/theme/themes.dart';

class SignicaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SignicaAppBar({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.appBarColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleSpacing: marginSizeMedium,
      automaticallyImplyLeading: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      title: Assets.signicaLogo.svg(),
      actionsPadding: const EdgeInsets.only(right: marginSizeMedium),
      actions: [
        Center(
          child: GlassButton(
            width: 38,
            height: 38,
            settings: const LiquidGlassSettings(
              blur: 4,
              glassColor: Color(0x1AFFFFFF),
              lightIntensity: 1.1,
              fresnelStrength: 0,
            ),
            shape: const LiquidRoundedRectangle(
              borderRadius: 15.2,
            ),
            onTap: () {},
            icon: Assets.moreIcon.svg(),
          )
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
