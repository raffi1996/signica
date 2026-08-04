import 'dart:io';
import 'dart:ui' as ui;

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart' show PdfPageFormat;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfrx/pdfrx.dart';
import 'package:signica/features/main/domain/entities/document.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class DocumentAcquisitionService {
  DocumentAcquisitionService();

  final Uuid _uuid = const Uuid();
  final ImagePicker _imagePicker = ImagePicker();

  static const int _previewWidth = 480;

  Future<Document?> pickPdfFile() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
    );
    if (result == null || result.files.isEmpty) {
      return null;
    }
    final path = result.files.single.path;
    if (path == null) {
      return null;
    }
    final originalName = result.files.single.name;
    return _persistPdf(
      sourcePdfPath: path,
      displayName: _nameWithoutExtension(originalName),
    );
  }

  Future<Document?> pickPhotos() async {
    final images = await _imagePicker.pickMultiImage();
    if (images.isEmpty) {
      return null;
    }
    return _persistImages(
      imagePaths: images.map((e) => e.path).toList(),
      displayName: _defaultDocumentName(),
    );
  }

  Future<Document?> scanDocument() async {
    final images = await CunningDocumentScanner.getPictures();
    if (images == null || images.isEmpty) {
      return null;
    }
    return _persistImages(
      imagePaths: images,
      displayName: _defaultDocumentName(),
    );
  }

  Future<Document> _persistPdf({
    required String sourcePdfPath,
    required String displayName,
  }) async {
    final id = _uuid.v4();
    final dir = await _documentDirectory(id);
    final pdfPath = p.join(dir.path, '$id.pdf');
    await File(sourcePdfPath).copy(pdfPath);
    final previews = await _generatePreviews(
      pdfPath: pdfPath,
      id: id,
      dir: dir,
    );
    return Document(
      id: id,
      name: displayName,
      pdfPath: pdfPath,
      firstPagePreviewPath: previews.firstPath,
      lastPagePreviewPath: previews.lastPath,
      pageCount: previews.pageCount,
      isSigned: false,
      createdAt: DateTime.now(),
    );
  }

  Future<Document> _persistImages({
    required List<String> imagePaths,
    required String displayName,
  }) async {
    final id = _uuid.v4();
    final dir = await _documentDirectory(id);
    final pdfPath = p.join(dir.path, '$id.pdf');
    await _writePdfFromImages(imagePaths: imagePaths, outputPath: pdfPath);
    final previews = await _generatePreviews(
      pdfPath: pdfPath,
      id: id,
      dir: dir,
    );
    return Document(
      id: id,
      name: displayName,
      pdfPath: pdfPath,
      firstPagePreviewPath: previews.firstPath,
      lastPagePreviewPath: previews.lastPath,
      pageCount: previews.pageCount,
      isSigned: false,
      createdAt: DateTime.now(),
    );
  }

  Future<Directory> _documentDirectory(String id) async {
    final root = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(root.path, 'documents', id));
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  Future<void> _writePdfFromImages({
    required List<String> imagePaths,
    required String outputPath,
  }) async {
    final pdf = pw.Document();
    for (final imagePath in imagePaths) {
      final bytes = await File(imagePath).readAsBytes();
      final image = pw.MemoryImage(bytes);
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Center(child: pw.Image(image));
          },
        ),
      );
    }
    final file = File(outputPath);
    await file.writeAsBytes(await pdf.save());
  }

  Future<({String firstPath, String? lastPath, int pageCount})>
  _generatePreviews({
    required String pdfPath,
    required String id,
    required Directory dir,
  }) async {
    final document = await PdfDocument.openFile(pdfPath);
    try {
      final pageCount = document.pages.length;
      if (pageCount == 0) {
        throw StateError('PDF has no pages');
      }

      final firstPath = p.join(dir.path, '${id}_first.png');
      await _renderPageToPng(
        page: document.pages.first,
        outputPath: firstPath,
      );

      String? lastPath;
      if (pageCount > 1) {
        lastPath = p.join(dir.path, '${id}_last.png');
        await _renderPageToPng(
          page: document.pages.last,
          outputPath: lastPath,
        );
      }

      return (firstPath: firstPath, lastPath: lastPath, pageCount: pageCount);
    } finally {
      await document.dispose();
    }
  }

  Future<void> _renderPageToPng({
    required PdfPage page,
    required String outputPath,
  }) async {
    final scale = _previewWidth / page.width;
    final height = page.height * scale;
    final pageImage = await page.render(
      fullWidth: _previewWidth.toDouble(),
      fullHeight: height,
    );
    if (pageImage == null) {
      throw StateError('Failed to render PDF page');
    }

    try {
      final image = await pageImage.createImage();
      try {
        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData == null) {
          throw StateError('Failed to encode preview PNG');
        }
        await File(outputPath).writeAsBytes(byteData.buffer.asUint8List());
      } finally {
        image.dispose();
      }
    } finally {
      pageImage.dispose();
    }
  }

  String _nameWithoutExtension(String fileName) {
    final base = p.basenameWithoutExtension(fileName).trim();
    if (base.isEmpty) {
      return _defaultDocumentName();
    }
    return base;
  }

  String _defaultDocumentName() {
    return 'main.document_names.new_document'.tr();
  }
}
