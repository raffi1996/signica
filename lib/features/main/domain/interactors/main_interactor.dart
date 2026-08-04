import 'package:signica/core/exceptions/result.dart';
import 'package:signica/features/main/domain/entities/document.dart';

abstract class MainInteractor {
  Stream<List<Document>> watchDocuments();

  Future<Result<List<Document>>> getDocuments();

  Future<Result<Document?>> addFromFiles();

  Future<Result<Document?>> addFromPhotos();

  Future<Result<Document?>> addFromScanner();

  Future<Result<Document>> toggleSigned(String id);

  Future<Result<void>> deleteDocuments(List<String> ids);
}
