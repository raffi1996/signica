import 'package:signica/core/exceptions/result.dart';

abstract class MainRepository {
  /// Fetches the initial data for the main feature.
  Future<Result<void>> fetchInitialData();
}
