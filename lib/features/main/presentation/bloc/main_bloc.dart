import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:signica/core/base/bloc_state_status.dart';
import 'package:signica/features/main/domain/interactors/main_interactor.dart';

part 'main_event.dart';
part 'main_state.dart';

@injectable
class MainBloc extends Bloc<MainEvent, MainState> {
  final MainInteractor _mainInteractor;

  MainBloc(this._mainInteractor) : super(const MainState()) {
    on<MainInitEvent>(_onInit);
    add(const MainInitEvent());
  }

  Future<void> _onInit(MainInitEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));
    final result = await _mainInteractor.loadInitialData();
    result.fold(
      success: (_) => emit(state.copyWith(status: BlocStateStatus.success)),
      error: (e, _) => emit(
        state.copyWith(status: BlocStateStatus.error, errorMessage: e.toString()),
      ),
    );
  }
}
