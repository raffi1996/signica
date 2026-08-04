import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/theme/themes.dart';
import 'package:signica/features/main/presentation/widgets/signica_more_button.dart';

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
      actions: [
        SizedBox(width: SignicaMoreButton.appBarActionWidth),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
