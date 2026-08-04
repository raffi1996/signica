import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signica/core/di/app_di.dart';
import 'package:signica/core/navigation/app_router.gr.dart';
import 'package:signica/core/theme/themes.dart';
import 'package:signica/features/main/domain/entities/document.dart';
import 'package:signica/features/main/presentation/bloc/main_bloc.dart';
import 'package:signica/features/main/presentation/models/signica_document_tab.dart';
import 'package:signica/features/main/presentation/utils/document_share_print.dart';
import 'package:signica/features/main/presentation/widgets/main_screen_bottom_chrome.dart';
import 'package:signica/features/main/presentation/widgets/signica_add_document_overlay.dart';
import 'package:signica/features/main/presentation/widgets/signica_app_bar.dart';
import 'package:signica/features/main/presentation/widgets/signica_document_actions_overlay.dart';
import 'package:signica/features/main/presentation/widgets/signica_document_tab_bar.dart';
import 'package:signica/features/main/presentation/widgets/signica_documents_grid.dart';
import 'package:signica/features/main/presentation/widgets/signica_empty_documents_view.dart';
import 'package:signica/features/main/presentation/widgets/signica_more_button.dart';
import 'package:signica/features/main/presentation/widgets/signica_multi_select_top_bar.dart';
import 'package:signica/features/main/presentation/widgets/signica_rounded_body.dart';
import 'package:signica/features/main/presentation/widgets/signica_search_overlay.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isAddDocumentOverlayVisible = false;
  bool _isSearchOverlayVisible = false;
  bool _isSelectionMode = false;
  final Set<String> _selectedIds = <String>{};
  Document? _actionsDocument;
  Rect? _actionsCardRect;

  Duration get fabTransitionDuration => const Duration(milliseconds: 220);

  bool get _isActionsOverlayVisible =>
      _actionsDocument != null && _actionsCardRect != null;

  bool get _areFabsHidden =>
      _isAddDocumentOverlayVisible ||
      _isSearchOverlayVisible ||
      _isSelectionMode ||
      _isActionsOverlayVisible;

  void _openAddDocumentOverlay() {
    setState(() => _isAddDocumentOverlayVisible = true);
  }

  void _onAddDocumentOverlayDismissed() {
    setState(() => _isAddDocumentOverlayVisible = false);
  }

  void _openSearchOverlay() {
    setState(() => _isSearchOverlayVisible = true);
  }

  void _onSearchOverlayDismissed() {
    setState(() => _isSearchOverlayVisible = false);
  }

  void _enterSelectionMode() {
    setState(() {
      _isSelectionMode = true;
      _selectedIds.clear();
      _isAddDocumentOverlayVisible = false;
      _isSearchOverlayVisible = false;
      _actionsDocument = null;
      _actionsCardRect = null;
    });
  }

  void _exitSelectionMode() {
    setState(() {
      _isSelectionMode = false;
      _selectedIds.clear();
    });
  }

  void _toggleDocumentSelection(Document document) {
    setState(() {
      if (_selectedIds.contains(document.id)) {
        _selectedIds.remove(document.id);
      } else {
        _selectedIds.add(document.id);
      }
    });
  }

  void _onSelectAllTap(List<Document> visibleDocuments) {
    setState(() {
      final visibleIds = visibleDocuments.map((d) => d.id).toSet();
      final allSelected =
          visibleIds.isNotEmpty && visibleIds.every(_selectedIds.contains);
      if (allSelected) {
        _selectedIds.removeAll(visibleIds);
      } else {
        _selectedIds.addAll(visibleIds);
      }
    });
  }

  void _openDocumentActions(Document document, Rect cardRect) {
    if (_isSelectionMode) {
      return;
    }
    setState(() {
      _actionsDocument = document;
      _actionsCardRect = cardRect;
      _isAddDocumentOverlayVisible = false;
      _isSearchOverlayVisible = false;
    });
  }

  void _onDocumentActionsDismissed() {
    setState(() {
      _actionsDocument = null;
      _actionsCardRect = null;
    });
  }

  void _openDocumentViewer(BuildContext context, Document document) {
    unawaited(
      context.router.push(
        DocumentViewerRoute(
          pdfPath: document.pdfPath,
          title: document.name,
        ),
      ),
    );
  }

  void _addFromFiles(BuildContext context) {
    context.read<MainBloc>().add(const MainAddFromFilesEvent());
  }

  void _addFromPhotos(BuildContext context) {
    context.read<MainBloc>().add(const MainAddFromPhotosEvent());
  }

  void _addFromScanner(BuildContext context) {
    context.read<MainBloc>().add(const MainAddFromScannerEvent());
  }

  void _deleteSelected(BuildContext context) {
    if (_selectedIds.isEmpty) {
      return;
    }

    final ids = _selectedIds.toList(growable: false);
    context.read<MainBloc>().add(MainDeleteDocumentsEvent(ids));
    _exitSelectionMode();
  }

  Future<void> _shareSelected(
    BuildContext context,
    List<Document> documents,
  ) {
    return shareSelectedDocuments(
      context: context,
      documents: documents,
      selectedIds: _selectedIds,
    );
  }

  Future<void> _printDocument(BuildContext context, Document document) {
    return printDocument(context: context, document: document);
  }

  Future<void> _shareDocument(BuildContext context, Document document) {
    return shareDocument(context: context, document: document);
  }

  void _deleteDocument(BuildContext context, Document document) {
    context.read<MainBloc>().add(MainDeleteDocumentsEvent([document.id]));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<MainBloc>(),
      child: Builder(
        builder: (context) {
          return PopScope(
            canPop: !_isActionsOverlayVisible,
            onPopInvokedWithResult: (didPop, _) {
              if (didPop || !_isActionsOverlayVisible) {
                return;
              }
              _onDocumentActionsDismissed();
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Scaffold(
                  backgroundColor: Palette.appBarColor,
                  resizeToAvoidBottomInset: !_isSearchOverlayVisible,
                  appBar: SignicaAppBar(hideLogo: _isSelectionMode),
                  body: SignicaRoundedBody(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            marginSizeMedium,
                            marginSizeMedium,
                            marginSizeMedium,
                            0,
                          ),
                          child: BlocBuilder<MainBloc, MainState>(
                            buildWhen: (previous, current) =>
                                previous.selectedTab != current.selectedTab ||
                                previous.documents.isEmpty !=
                                    current.documents.isEmpty,
                            builder: (context, state) {
                              return SignicaDocumentTabBar(
                                selectedTab: state.selectedTab,
                                disabledTabs: state.documents.isEmpty
                                    ? const {
                                        SignicaDocumentTab.signed,
                                        SignicaDocumentTab.unsigned,
                                      }
                                    : const {},
                                onTabSelected: (tab) {
                                  context.read<MainBloc>().add(
                                    MainTabSelectedEvent(tab),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: BlocConsumer<MainBloc, MainState>(
                            listenWhen: (previous, current) =>
                                (previous.errorMessage !=
                                        current.errorMessage &&
                                    current.errorMessage != null) ||
                                (previous.documents.isNotEmpty &&
                                    current.documents.isEmpty &&
                                    _isSelectionMode),
                            listener: (context, state) {
                              if (state.documents.isEmpty && _isSelectionMode) {
                                _exitSelectionMode();
                              }
                              final message = state.errorMessage;
                              if (message == null) {
                                return;
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(message)),
                              );
                            },
                            builder: (context, state) {
                              if (state.status.isLoading &&
                                  state.documents.isEmpty) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (state.documents.isEmpty) {
                                return SignicaEmptyDocumentsView(
                                  onFilesTap: () => _addFromFiles(context),
                                  onPhotosTap: () => _addFromPhotos(context),
                                  onScannerTap: () => _addFromScanner(context),
                                );
                              }

                              final visible = state.visibleDocuments;
                              if (visible.isEmpty) {
                                return Center(
                                  child: Text('main.no_search_results'.tr()),
                                );
                              }

                              return SignicaDocumentsGrid(
                                documents: visible,
                                selectionMode: _isSelectionMode,
                                selectedIds: _selectedIds,
                                onDocumentTap: (document) {
                                  if (_isSelectionMode) {
                                    _toggleDocumentSelection(document);
                                    return;
                                  }
                                  _openDocumentViewer(context, document);
                                },
                                onDocumentLongPress: _isSelectionMode
                                    ? null
                                    : _openDocumentActions,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<MainBloc, MainState>(
                  buildWhen: (previous, current) =>
                      previous.isProcessing != current.isProcessing,
                  builder: (context, state) {
                    if (!state.isProcessing) {
                      return const SizedBox.shrink();
                    }
                    return const Positioned.fill(
                      child: ColoredBox(
                        color: Color(0x33000000),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  },
                ),
                if (_isSelectionMode)
                  BlocBuilder<MainBloc, MainState>(
                    builder: (context, state) {
                      final visible = state.visibleDocuments;
                      final visibleIds = visible.map((d) => d.id).toSet();
                      final selectedVisibleCount = _selectedIds
                          .where(visibleIds.contains)
                          .length;
                      final allSelected =
                          visibleIds.isNotEmpty &&
                          selectedVisibleCount == visibleIds.length;
                      return SignicaMultiSelectTopBar(
                        selectedCount: selectedVisibleCount,
                        allSelected: allSelected,
                        onSelectAllTap: () => _onSelectAllTap(visible),
                        onCloseTap: _exitSelectionMode,
                      );
                    },
                  )
                else
                  Positioned(
                    top: moreButtonTopForToolbar(context),
                    right: marginSizeMedium,
                    child: SignicaMoreButton(
                      onAddDocumentTap: _openAddDocumentOverlay,
                      onSelectTap: () {
                        final hasDocuments = context
                            .read<MainBloc>()
                            .state
                            .documents
                            .isNotEmpty;
                        if (!hasDocuments) {
                          return;
                        }
                        _enterSelectionMode();
                      },
                    ),
                  ),
                SignicaAddDocumentOverlay(
                  visible: _isAddDocumentOverlayVisible,
                  onDismissed: _onAddDocumentOverlayDismissed,
                  onFilesTap: () => _addFromFiles(context),
                  onPhotosTap: () => _addFromPhotos(context),
                  onScannerTap: () => _addFromScanner(context),
                ),
                SignicaSearchOverlay(
                  visible: _isSearchOverlayVisible,
                  onDismissed: _onSearchOverlayDismissed,
                  onQueryChanged: (query) {
                    context.read<MainBloc>().add(
                      MainSearchQueryChangedEvent(query),
                    );
                  },
                ),
                SignicaDocumentActionsOverlay(
                  visible: _isActionsOverlayVisible,
                  document: _actionsDocument,
                  cardRect: _actionsCardRect,
                  onDismissed: _onDocumentActionsDismissed,
                  onPrintTap: (document) =>
                      unawaited(_printDocument(context, document)),
                  onShareTap: (document) =>
                      unawaited(_shareDocument(context, document)),
                  onDeleteTap: (document) => _deleteDocument(context, document),
                ),
                MainScreenBottomChrome(
                  isSelectionMode: _isSelectionMode,
                  areFabsHidden: _areFabsHidden,
                  fabTransitionDuration: fabTransitionDuration,
                  selectedIds: _selectedIds,
                  onDeleteSelected: () => _deleteSelected(context),
                  onShareSelected: (documents) =>
                      unawaited(_shareSelected(context, documents)),
                  onSearchTap: _openSearchOverlay,
                  onAddDocumentTap: _openAddDocumentOverlay,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
