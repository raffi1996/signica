import 'package:injectable/injectable.dart';
import 'package:signica/core/exceptions/result.dart';
import 'package:signica/features/main/domain/entities/document.dart';
import 'package:signica/features/main/domain/interactors/main_interactor.dart';
import 'package:signica/features/main/domain/repositories/main_repository.dart';
import 'package:signica/features/main/domain/services/document_acquisition.dart';
import 'package:signica/features/main/domain/utils/unique_document_name.dart';

@LazySingleton(as: MainInteractor)
class MainInteractorImpl implements MainInteractor {
  MainInteractorImpl(this._mainRepository, this._acquisition);

  final MainRepository _mainRepository;
  final DocumentAcquisition _acquisition;

  @override
  Stream<List<Document>> watchDocuments() => _mainRepository.watchDocuments();

  @override
  Future<Result<List<Document>>> getDocuments() =>
      _mainRepository.getDocuments();

  @override
  Future<Result<Document?>> addFromFiles() {
    return Result.asyncHandle(() async {
      final acquired = await _acquisition.pickPdfFile();
      return _persistAcquired(acquired);
    });
  }

  @override
  Future<Result<Document?>> addFromPhotos() {
    return Result.asyncHandle(() async {
      final acquired = await _acquisition.pickPhotos();
      return _persistAcquired(acquired);
    });
  }

  @override
  Future<Result<Document?>> addFromScanner() {
    return Result.asyncHandle(() async {
      final acquired = await _acquisition.scanDocument();
      return _persistAcquired(acquired);
    });
  }

  Future<Document?> _persistAcquired(Document? acquired) async {
    if (acquired == null) {
      return null;
    }

    final existingResult = await _mainRepository.getDocuments();
    final existingNames = existingResult.fold(
      success: (documents) => documents.map((doc) => doc.name),
      error: (e, _) => throw e,
    );

    final uniqueName = uniqueDocumentName(
      desiredName: acquired.name,
      existingNames: existingNames,
    );
    final document = acquired.copyWith(name: uniqueName);

    final result = await _mainRepository.addDocument(document);
    return result.fold(
      success: (doc) => doc,
      error: (e, _) => throw e,
    );
  }

  @override
  Future<Result<Document>> toggleSigned(String id) =>
      _mainRepository.toggleSigned(id);

  @override
  Future<Result<void>> deleteDocuments(List<String> ids) =>
      _mainRepository.deleteDocuments(ids);
}
