part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object?> get props => [];
}

final class MainInitEvent extends MainEvent {
  const MainInitEvent();
}

final class MainDocumentsUpdatedEvent extends MainEvent {
  const MainDocumentsUpdatedEvent(this.documents);

  final List<Document> documents;

  @override
  List<Object?> get props => [documents];
}

final class MainAddFromFilesEvent extends MainEvent {
  const MainAddFromFilesEvent();
}

final class MainAddFromPhotosEvent extends MainEvent {
  const MainAddFromPhotosEvent();
}

final class MainAddFromScannerEvent extends MainEvent {
  const MainAddFromScannerEvent();
}

final class MainToggleSignedEvent extends MainEvent {
  const MainToggleSignedEvent(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class MainTabSelectedEvent extends MainEvent {
  const MainTabSelectedEvent(this.tab);

  final SignicaDocumentTab tab;

  @override
  List<Object?> get props => [tab];
}

final class MainSearchQueryChangedEvent extends MainEvent {
  const MainSearchQueryChangedEvent(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}
