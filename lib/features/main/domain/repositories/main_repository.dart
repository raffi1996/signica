import 'package:signica/core/exceptions/result.dart';
import 'package:signica/features/main/domain/entities/document.dart';

abstract class MainRepository {
  Stream<List<Document>> watchDocuments();

  Future<Result<List<Document>>> getDocuments();

  Future<Result<Document>> addDocument(Document document);

  Future<Result<Document>> toggleSigned(String id);
}
