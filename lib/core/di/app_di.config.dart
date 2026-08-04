// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/main/data/repositories_impl/main_repository_impl.dart'
    as _i702;
import '../../features/main/data/services/document_acquisition_service.dart'
    as _i87;
import '../../features/main/domain/interactors/main_interactor.dart' as _i215;
import '../../features/main/domain/interactors/main_interactor_impl.dart'
    as _i653;
import '../../features/main/domain/repositories/main_repository.dart' as _i298;
import '../../features/main/domain/services/document_acquisition.dart' as _i305;
import '../../features/main/presentation/bloc/main_bloc.dart' as _i1014;
import '../database/app_database.dart' as _i982;
import '../navigation/app_router.dart' as _i630;
import 'app_di.dart' as _i246;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.singleton<_i630.AppRouter>(() => appModule.appRouter);
    gh.lazySingleton<_i982.AppDatabase>(() => appModule.appDatabase());
    gh.lazySingleton<_i305.DocumentAcquisition>(
      () => _i87.DocumentAcquisitionService(),
    );
    gh.lazySingleton<_i298.MainRepository>(
      () => _i702.MainRepositoryImpl(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<_i215.MainInteractor>(
      () => _i653.MainInteractorImpl(
        gh<_i298.MainRepository>(),
        gh<_i305.DocumentAcquisition>(),
      ),
    );
    gh.factory<_i1014.MainBloc>(
      () => _i1014.MainBloc(gh<_i215.MainInteractor>()),
    );
    return this;
  }
}

class _$AppModule extends _i246.AppModule {}
