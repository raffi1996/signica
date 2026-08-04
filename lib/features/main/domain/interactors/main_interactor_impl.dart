import 'package:injectable/injectable.dart';
import 'package:signica/core/exceptions/result.dart';
import 'package:signica/features/main/data/services/document_acquisition_service.dart';
import 'package:signica/features/main/domain/entities/document.dart';
import 'package:signica/features/main/domain/interactors/main_interactor.dart';
import 'package:signica/features/main/domain/repositories/main_repository.dart';

@LazySingleton(as: MainInteractor)
class MainInteractorImpl implements MainInteractor {
  MainInteractorImpl(this._mainRepository, this._acquisitionService);

  final MainRepository _mainRepository;
  final DocumentAcquisitionService _acquisitionService;

  @override
  Stream<List<Document>> watchDocuments() => _mainRepository.watchDocuments();

  @override
  Future<Result<List<Document>>> getDocuments() =>
      _mainRepository.getDocuments();

  @override
  Future<Result<Document?>> addFromFiles() {
    return Result.asyncHandle(() async {
      final acquired = await _acquisitionService.pickPdfFile();
      if (acquired == null) {
        return null;
      }
      final result = await _mainRepository.addDocument(acquired);
      return result.fold(
        success: (doc) => doc,
        error: (e, _) => throw e,
      );
    });
  }

  @override
  Future<Result<Document?>> addFromPhotos() {
    return Result.asyncHandle(() async {
      final acquired = await _acquisitionService.pickPhotos();
      if (acquired == null) {
        return null;
      }
      final result = await _mainRepository.addDocument(acquired);
      return result.fold(
        success: (doc) => doc,
        error: (e, _) => throw e,
      );
    });
  }

  @override
  Future<Result<Document?>> addFromScanner() {
    return Result.asyncHandle(() async {
      final acquired = await _acquisitionService.scanDocument();
      if (acquired == null) {
        return null;
      }
      final result = await _mainRepository.addDocument(acquired);
      return result.fold(
        success: (doc) => doc,
        error: (e, _) => throw e,
      );
    });
  }

  @override
  Future<Result<Document>> toggleSigned(String id) =>
      _mainRepository.toggleSigned(id);
}
