import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/theme/themes.dart';
import 'package:signica/features/main/domain/entities/document.dart';
import 'package:signica/features/main/presentation/widgets/document_selection_overlay.dart';

class SignicaDocumentCard extends StatelessWidget {
  const SignicaDocumentCard({
    required this.document,
    this.onTap,
    this.onLongPress,
    this.selectionMode = false,
    this.isSelected = false,
    super.key,
  });

  final Document document;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool selectionMode;
  final bool isSelected;

  static final _dateFormat = DateFormat('dd.MM.yyyy', 'en');

  static const double sheetWidth = 123.72;
  static const double sheetHeight = 167.84;
  static const double sheetRadius = 12;
  static const double sheetBorderWidth = 1;
  static const Color sheetBorderColor = Color(0x96DADADA);
  static const Offset sheetShadowOffset = Offset(0, 4);
  static const double sheetShadowBlur = 11.1;
  static const double sheetShadowSpread = 0;
  static const Color sheetShadowColor = Color(0x14000000);

  static const double backSheetAngleDeg = -6;
  static const double middleSheetAngleDeg = -3;
  static const double frontSheetAngleDeg = 3;
  static const Offset backSheetOffset = Offset(-4, 0);
  static const Offset middleSheetOffset = Offset(-1.5, 0);

  static const double stackWidth = 152;
  static const double stackHeight = 192;

  static const double previewTitleSpacing = 12;
  static const double titleDateSpacing = 2;
  static const Color documentDateColor = Color(0xFF999999);

  static const double signatureSize = 42;

  static const double cardContentHeight =
      stackHeight + previewTitleSpacing + 40 + titleDateSpacing + 16;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          SizedBox(
            height: stackHeight,
            width: double.infinity,
            child: Center(
              child: _DocumentStack(
                document: document,
                selectionMode: selectionMode,
                isSelected: isSelected,
              ),
            ),
          ),
          const SizedBox(height: previewTitleSpacing),
          Text(
            document.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: AppTextStyles.documentTitle.copyWith(
              color: Palette.black,
            ),
          ),
          const SizedBox(height: titleDateSpacing),
          Text(
            _dateFormat.format(document.createdAt),
            textAlign: TextAlign.center,
            style: AppTextStyles.documentDate.copyWith(
              color: documentDateColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentStack extends StatelessWidget {
  const _DocumentStack({
    required this.document,
    required this.selectionMode,
    required this.isSelected,
  });

  final Document document;
  final bool selectionMode;
  final bool isSelected;

  static double _rad(double deg) => deg * math.pi / 180;

  @override
  Widget build(BuildContext context) {
    final firstPath = document.firstPagePreviewPath;
    final lastPath = document.lastPagePreviewPath ?? firstPath;

    return SizedBox(
      width: SignicaDocumentCard.stackWidth,
      height: SignicaDocumentCard.stackHeight,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          if (document.isMultiPage) ...[
            Transform.rotate(
              angle: _rad(SignicaDocumentCard.backSheetAngleDeg),
              child: Transform.translate(
                offset: SignicaDocumentCard.backSheetOffset,
                child: _Sheet(
                  imagePath: lastPath,
                  showShadow: false,
                ),
              ),
            ),
            Transform.rotate(
              angle: _rad(SignicaDocumentCard.middleSheetAngleDeg),
              child: Transform.translate(
                offset: SignicaDocumentCard.middleSheetOffset,
                child: _Sheet(
                  imagePath: lastPath,
                  showShadow: false,
                ),
              ),
            ),
            Transform.rotate(
              angle: _rad(SignicaDocumentCard.frontSheetAngleDeg),
              child: _Sheet(imagePath: firstPath),
            ),
          ] else
            _Sheet(imagePath: firstPath),
          if (document.isSigned)
            const Positioned(
              bottom: 8,
              child: _SignedBadge(),
            ),
          if (selectionMode) DocumentSelectionOverlay(isSelected: isSelected),
        ],
      ),
    );
  }
}

class _Sheet extends StatelessWidget {
  const _Sheet({
    required this.imagePath,
    this.showShadow = true,
  });

  final String imagePath;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SignicaDocumentCard.sheetWidth,
      height: SignicaDocumentCard.sheetHeight,
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(SignicaDocumentCard.sheetRadius),
        border: Border.all(
          color: SignicaDocumentCard.sheetBorderColor,
          // ignore: avoid_redundant_argument_values — Figma: 1px
          width: SignicaDocumentCard.sheetBorderWidth,
        ),
        boxShadow: showShadow
            ? const [
                BoxShadow(
                  color: SignicaDocumentCard.sheetShadowColor,
                  offset: SignicaDocumentCard.sheetShadowOffset,
                  blurRadius: SignicaDocumentCard.sheetShadowBlur,
                  // ignore: avoid_redundant_argument_values — Figma: 0
                  spreadRadius: SignicaDocumentCard.sheetShadowSpread,
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          SignicaDocumentCard.sheetRadius -
              SignicaDocumentCard.sheetBorderWidth,
        ),
        child: ColoredBox(
          color: Palette.white,
          child: Image.file(
            File(imagePath),
            width: SignicaDocumentCard.sheetWidth,
            height: SignicaDocumentCard.sheetHeight,
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
            errorBuilder: (_, _, _) => const ColoredBox(
              color: Palette.white,
              child: Center(
                child: Icon(
                  Icons.insert_drive_file_outlined,
                  color: Palette.darkGray3,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignedBadge extends StatelessWidget {
  const _SignedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SignicaDocumentCard.signatureSize,
      height: SignicaDocumentCard.signatureSize,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x29000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Assets.signatureIcon.png(
        width: SignicaDocumentCard.signatureSize,
        height: SignicaDocumentCard.signatureSize,
      ),
    );
  }
}
