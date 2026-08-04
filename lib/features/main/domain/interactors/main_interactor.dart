import 'package:signica/core/exceptions/result.dart';
import 'package:signica/features/main/domain/entities/document.dart';

abstract class MainInteractor {
  Stream<List<Document>> watchDocuments();

  Future<Result<List<Document>>> getDocuments();

  /// Returns `null` document when the user cancels picking.
  Future<Result<Document?>> addFromFiles();

  /// Returns `null` document when the user cancels picking.
  Future<Result<Document?>> addFromPhotos();

  /// Returns `null` document when the user cancels scanning.
  Future<Result<Document?>> addFromScanner();

  Future<Result<Document>> toggleSigned(String id);
}
