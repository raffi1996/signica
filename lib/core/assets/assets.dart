import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:signica/core/theme/palette.dart';

class Assets {
  Assets._();

  static const String signicaLogo = 'assets/icons/app_logo.svg';
  static const String moreIcon = 'assets/icons/more_icon.svg';
  static const String selectMenuIcon = 'assets/icons/select_menu_icon.png';
  static const String addDocumentMenuIcon = 'assets/icons/add_document_menu_icon.png';
}

extension AssetsHelper on String {
  String get name {
    final startIndex = lastIndexOf('/');
    final endIndex = indexOf('.');

    return substring(startIndex + 1, endIndex).replaceAll('_', ' ');
  }

  String get upperCaseName => '${name[0].toUpperCase()}${name.substring(1)}';

  SvgPicture svg({
    Key? key,
    Color? color,
    double? height,
    double? width,
    BlendMode colorBlendMode = BlendMode.srcIn,
    BoxFit fit = BoxFit.contain,
  }) {
    return SvgPicture.asset(
      this,
      key: key,
      colorFilter: color != null ? ColorFilter.mode(color, colorBlendMode) : null,
      height: height,
      width: width,
      fit: fit,
    );
  }

  Image png({double? width, double? height, BoxFit? fit}) {
    return Image.asset(this, width: width, height: height, fit: fit);
  }

  Image imageFromPath({
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.file(File(this), width: width, height: height, fit: fit);
  }

  Color fromHex() {
    try {
      final buffer = StringBuffer();
      if (length == 6 || length == 7) {
        buffer.write('ff');
      }
      buffer.write(replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return Palette.white;
    }
  }
}
