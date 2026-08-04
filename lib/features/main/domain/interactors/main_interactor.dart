import 'package:signica/core/exceptions/result.dart';

abstract class MainInteractor {
  /// Loads the initial data for the main screen.
  Future<Result<void>> loadInitialData();
}
