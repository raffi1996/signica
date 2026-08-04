import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:signica/core/database/app_database.dart';
import 'package:signica/core/di/app_di.config.dart';
import 'package:signica/core/navigation/app_router.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: true)
void configureDependencies() => getIt.init();

@module
abstract class AppModule {
  @singleton
  AppRouter get appRouter => AppRouter();

  @lazySingleton
  AppDatabase appDatabase() => AppDatabase();
}
