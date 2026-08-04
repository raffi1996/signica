part of 'main_bloc.dart';

final class MainState extends Equatable {
  const MainState({
    this.status = BlocStateStatus.initial,
    this.errorMessage,
    this.documents = const [],
    this.selectedTab = SignicaDocumentTab.all,
    this.searchQuery = '',
    this.isProcessing = false,
  });

  final BlocStateStatus status;
  final String? errorMessage;
  final List<Document> documents;
  final SignicaDocumentTab selectedTab;
  final String searchQuery;
  final bool isProcessing;

  List<Document> get visibleDocuments {
    final query = searchQuery.trim().toLowerCase();
    return documents.where((doc) {
      final matchesTab = switch (selectedTab) {
        SignicaDocumentTab.all => true,
        SignicaDocumentTab.signed => doc.isSigned,
        SignicaDocumentTab.unsigned => !doc.isSigned,
      };
      if (!matchesTab) {
        return false;
      }
      if (query.isEmpty) {
        return true;
      }
      return doc.name.toLowerCase().contains(query);
    }).toList();
  }

  MainState copyWith({
    BlocStateStatus? status,
    String? errorMessage,
    bool clearErrorMessage = false,
    List<Document>? documents,
    SignicaDocumentTab? selectedTab,
    String? searchQuery,
    bool? isProcessing,
  }) {
    return MainState(
      status: status ?? this.status,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
      documents: documents ?? this.documents,
      selectedTab: selectedTab ?? this.selectedTab,
      searchQuery: searchQuery ?? this.searchQuery,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    documents,
    selectedTab,
    searchQuery,
    isProcessing,
  ];
}
