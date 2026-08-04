import 'package:signica/core/exceptions/result.dart';

mixin class BaseRepository {
  Future<Result<T>> asyncExecute<T>(Future<T> Function() operation) {
    return Result.asyncHandle<T>(operation);
  }
}
