import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:signica/core/theme/themes.dart';

@RoutePage()
class DocumentViewerScreen extends StatelessWidget {
  const DocumentViewerScreen({
    required this.pdfPath,
    required this.title,
    super.key,
  });

  final String pdfPath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: Palette.appBarColor,
        foregroundColor: Palette.white,
        elevation: 0,
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.documentTitle.copyWith(
            color: Palette.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: PdfViewer.file(pdfPath),
    );
  }
}
