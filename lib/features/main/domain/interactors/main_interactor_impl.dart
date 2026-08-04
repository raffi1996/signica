import 'package:injectable/injectable.dart';
import 'package:signica/core/exceptions/result.dart';
import 'package:signica/features/main/domain/interactors/main_interactor.dart';
import 'package:signica/features/main/domain/repositories/main_repository.dart';

@LazySingleton(as: MainInteractor)
class MainInteractorImpl implements MainInteractor {
  final MainRepository _mainRepository;

  MainInteractorImpl(this._mainRepository);

  @override
  Future<Result<void>> loadInitialData() => _mainRepository.fetchInitialData();
}
