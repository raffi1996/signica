import 'package:injectable/injectable.dart';
import 'package:signica/core/base/repositories/base_repository.dart';
import 'package:signica/core/exceptions/result.dart';
import 'package:signica/features/main/domain/repositories/main_repository.dart';

@LazySingleton(as: MainRepository)
class MainRepositoryImpl extends BaseRepository implements MainRepository {
  @override
  Future<Result<void>> fetchInitialData() {
    return asyncExecute(() async {
      // TODO(signica): load documents from the local database (drift).
    });
  }
}
