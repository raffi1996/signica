import 'package:signica/features/main/domain/entities/document.dart';

abstract interface class DocumentAcquisition {
  Future<Document?> pickPdfFile();

  Future<Document?> pickPhotos();

  Future<Document?> scanDocument();
}
