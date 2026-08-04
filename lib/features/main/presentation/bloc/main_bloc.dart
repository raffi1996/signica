import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:signica/core/base/bloc_state_status.dart';
import 'package:signica/core/exceptions/result.dart';
import 'package:signica/features/main/domain/entities/document.dart';
import 'package:signica/features/main/domain/interactors/main_interactor.dart';
import 'package:signica/features/main/presentation/widgets/signica_document_tab_bar.dart';

part 'main_event.dart';
part 'main_state.dart';

@injectable
class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc(this._mainInteractor) : super(const MainState()) {
    on<MainInitEvent>(_onInit);
    on<MainDocumentsUpdatedEvent>(_onDocumentsUpdated);
    on<MainAddFromFilesEvent>(_onAddFromFiles);
    on<MainAddFromPhotosEvent>(_onAddFromPhotos);
    on<MainAddFromScannerEvent>(_onAddFromScanner);
    on<MainToggleSignedEvent>(_onToggleSigned);
    on<MainTabSelectedEvent>(_onTabSelected);
    on<MainSearchQueryChangedEvent>(_onSearchQueryChanged);
    add(const MainInitEvent());
  }

  final MainInteractor _mainInteractor;
  StreamSubscription<List<Document>>? _documentsSubscription;

  Future<void> _onInit(MainInitEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result = await _mainInteractor.getDocuments();
    result.fold(
      success: (documents) {
        emit(
          state.copyWith(
            status: BlocStateStatus.success,
            documents: documents,
            clearErrorMessage: true,
          ),
        );
      },
      error: (e, _) {
        emit(
          state.copyWith(
            status: BlocStateStatus.error,
            errorMessage: e.toString(),
          ),
        );
      },
    );

    await _documentsSubscription?.cancel();
    _documentsSubscription = _mainInteractor.watchDocuments().listen(
      (documents) => add(MainDocumentsUpdatedEvent(documents)),
    );
  }

  void _onDocumentsUpdated(
    MainDocumentsUpdatedEvent event,
    Emitter<MainState> emit,
  ) {
    emit(
      state.copyWith(
        status: BlocStateStatus.success,
        documents: event.documents,
        clearErrorMessage: true,
      ),
    );
  }

  Future<void> _onAddFromFiles(
    MainAddFromFilesEvent event,
    Emitter<MainState> emit,
  ) async {
    await _handleAdd(_mainInteractor.addFromFiles, emit);
  }

  Future<void> _onAddFromPhotos(
    MainAddFromPhotosEvent event,
    Emitter<MainState> emit,
  ) async {
    await _handleAdd(_mainInteractor.addFromPhotos, emit);
  }

  Future<void> _onAddFromScanner(
    MainAddFromScannerEvent event,
    Emitter<MainState> emit,
  ) async {
    await _handleAdd(_mainInteractor.addFromScanner, emit);
  }

  Future<void> _handleAdd(
    Future<Result<Document?>> Function() action,
    Emitter<MainState> emit,
  ) async {
    emit(state.copyWith(isProcessing: true, clearErrorMessage: true));
    final result = await action();
    result.fold(
      success: (_) {
        emit(state.copyWith(isProcessing: false));
      },
      error: (e, _) {
        emit(
          state.copyWith(
            isProcessing: false,
            errorMessage: e.toString(),
          ),
        );
      },
    );
  }

  Future<void> _onToggleSigned(
    MainToggleSignedEvent event,
    Emitter<MainState> emit,
  ) async {
    final result = await _mainInteractor.toggleSigned(event.id);
    result.fold(
      success: (_) {},
      error: (e, _) {
        emit(state.copyWith(errorMessage: e.toString()));
      },
    );
  }

  void _onTabSelected(MainTabSelectedEvent event, Emitter<MainState> emit) {
    emit(state.copyWith(selectedTab: event.tab));
  }

  void _onSearchQueryChanged(
    MainSearchQueryChangedEvent event,
    Emitter<MainState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
  }

  @override
  Future<void> close() async {
    await _documentsSubscription?.cancel();
    return super.close();
  }
}
