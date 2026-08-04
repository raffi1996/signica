import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/theme/themes.dart';
import 'package:signica/features/main/domain/entities/document.dart';

class SignicaDocumentCard extends StatelessWidget {
  const SignicaDocumentCard({
    required this.document,
    this.onTap,
    super.key,
  });

  final Document document;
  final VoidCallback? onTap;

  static final _dateFormat = DateFormat('dd.MM.yyyy', 'en');

  /// Portrait sheet size matching the mockup proportions.
  static const double sheetWidth = 104;
  static const double sheetHeight = 136;
  static const double sheetRadius = 22;
  static const double signatureSize = 42;
  static const double stackHeight = 168;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          SizedBox(
            height: stackHeight,
            width: double.infinity,
            child: Center(
              child: _DocumentStack(document: document),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            document.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: AppTextStyles.documentTitle.copyWith(
              color: Palette.black,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            _dateFormat.format(document.createdAt),
            textAlign: TextAlign.center,
            style: AppTextStyles.documentDate.copyWith(
              color: const Color(0xFF8E8E93),
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentStack extends StatelessWidget {
  const _DocumentStack({required this.document});

  final Document document;

  @override
  Widget build(BuildContext context) {
    final firstPath = document.firstPagePreviewPath;
    final lastPath = document.lastPagePreviewPath ?? firstPath;

    return SizedBox(
      width: SignicaDocumentCard.sheetWidth + 36,
      height: SignicaDocumentCard.stackHeight,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          if (document.isMultiPage) ...[
            // Back sheet — ~10° counter-clockwise
            Transform.rotate(
              angle: -10 * math.pi / 180,
              child: Transform.translate(
                offset: const Offset(-6, 2),
                child: _Sheet(
                  imagePath: lastPath,
                  opacity: 0.92,
                ),
              ),
            ),
            // Middle sheet — ~5° counter-clockwise
            Transform.rotate(
              angle: -5 * math.pi / 180,
              child: Transform.translate(
                offset: const Offset(4, 0),
                child: _Sheet(
                  imagePath: lastPath,
                  opacity: 0.96,
                ),
              ),
            ),
          ],
          // Front sheet — ~8° clockwise (or flat for single page)
          Transform.rotate(
            angle: document.isMultiPage ? 8 * math.pi / 180 : 0,
            child: _Sheet(imagePath: firstPath),
          ),
          if (document.isSigned)
            const Positioned(
              bottom: 4,
              child: _SignedBadge(),
            ),
        ],
      ),
    );
  }
}

class _Sheet extends StatelessWidget {
  const _Sheet({
    required this.imagePath,
    this.opacity = 1,
  });

  final String imagePath;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: SignicaDocumentCard.sheetWidth,
        height: SignicaDocumentCard.sheetHeight,
        decoration: BoxDecoration(
          color: Palette.white,
          borderRadius: BorderRadius.circular(SignicaDocumentCard.sheetRadius),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.file(
          File(imagePath),
          width: SignicaDocumentCard.sheetWidth,
          height: SignicaDocumentCard.sheetHeight,
          fit: BoxFit.cover,
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
