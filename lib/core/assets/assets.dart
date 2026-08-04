import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Assets {
  Assets._();

  static const String signicaLogo = 'assets/icons/app_logo.svg';
  static const String moreIcon = 'assets/icons/more_icon.svg';
  static const String selectMenuIcon = 'assets/icons/select_menu_icon.png';
  static const String addDocumentMenuIcon =
      'assets/icons/add_document_menu_icon.png';
  static const String addDocumentFabIcon =
      'assets/icons/add_document_fab_icon.png';
  static const String filesIcon = 'assets/icons/files_icon.png';
  static const String photosIcon = 'assets/icons/photos_icon.png';
  static const String scannerIcon = 'assets/icons/scanner_icon.png';
  static const String searchIcon = 'assets/icons/search_icon.png';
  static const String closeIcon = 'assets/icons/close_icon.png';
  static const String signatureIcon = 'assets/icons/signature_icon.png';
  static const String deleteIcon = 'assets/icons/delete_icon.svg';
  static const String shareIcon = 'assets/icons/share_icon.svg';
  static const String printIcon = 'assets/icons/print_icon.svg';
  static const String selectionSelectedIcon =
      'assets/icons/selection_selected_icon.svg';
  static const String emptyStateDocument =
      'assets/images/empty_state_document.png';
}

extension AssetsHelper on String {
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
      colorFilter: color != null
          ? ColorFilter.mode(color, colorBlendMode)
          : null,
      height: height,
      width: width,
      fit: fit,
    );
  }

  Image png({double? width, double? height, BoxFit? fit}) {
    return Image.asset(this, width: width, height: height, fit: fit);
  }
}
