import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/theme/themes.dart';

class SignicaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SignicaAppBar({
    this.hideLogo = false,
    super.key,
  });

  final bool hideLogo;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.appBarColor,
      toolbarHeight: appBarToolbarHeight,
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
      title: hideLogo
          ? const SizedBox.shrink()
          : Assets.signicaLogo.svg(height: appBarLogoHeight),
      actions: const [
        SizedBox(width: moreButtonAppBarActionWidth),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(appBarToolbarHeight);
}
