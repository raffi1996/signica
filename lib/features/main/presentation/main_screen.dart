import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/di/app_di.dart';
import 'package:signica/core/theme/themes.dart';
import 'package:signica/features/main/domain/entities/document.dart';
import 'package:signica/features/main/presentation/bloc/main_bloc.dart';
import 'package:signica/features/main/presentation/widgets/signica_add_document_fab.dart';
import 'package:signica/features/main/presentation/widgets/signica_add_document_overlay.dart';
import 'package:signica/features/main/presentation/widgets/signica_app_bar.dart';
import 'package:signica/features/main/presentation/widgets/signica_document_tab_bar.dart';
import 'package:signica/features/main/presentation/widgets/signica_documents_grid.dart';
import 'package:signica/features/main/presentation/widgets/signica_empty_documents_view.dart';
import 'package:signica/features/main/presentation/widgets/signica_more_button.dart';
import 'package:signica/features/main/presentation/widgets/signica_multi_select_action_button.dart';
import 'package:signica/features/main/presentation/widgets/signica_multi_select_top_bar.dart';
import 'package:signica/features/main/presentation/widgets/signica_rounded_body.dart';
import 'package:signica/features/main/presentation/widgets/signica_search_fab.dart';
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

  Duration get fabTransitionDuration => const Duration(milliseconds: 220);

  bool get _areFabsHidden =>
      _isAddDocumentOverlayVisible ||
      _isSearchOverlayVisible ||
      _isSelectionMode;

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
  ) async {
    if (_selectedIds.isEmpty) {
      return;
    }

    final selected = documents
        .where((doc) => _selectedIds.contains(doc.id))
        .toList(growable: false);

    final files = <XFile>[];
    for (final document in selected) {
      final file = File(document.pdfPath);
      if (await file.exists()) {
        files.add(XFile(document.pdfPath, name: '${document.name}.pdf'));
      }
    }

    if (!context.mounted) {
      return;
    }

    if (files.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('main.multi_select.share_unavailable'.tr())),
      );
      return;
    }

    final box = context.findRenderObject() as RenderBox?;
    final origin = box == null
        ? null
        : box.localToGlobal(Offset.zero) & box.size;

    await SharePlus.instance.share(
      ShareParams(
        files: files,
        sharePositionOrigin: origin,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<MainBloc>(),
      child: Builder(
        builder: (context) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Scaffold(
                backgroundColor: Palette.appBarColor,
                resizeToAvoidBottomInset: !_isSearchOverlayVisible,
                appBar: const SignicaAppBar(),
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
                              (previous.errorMessage != current.errorMessage &&
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
                                context.read<MainBloc>().add(
                                  MainToggleSignedEvent(document.id),
                                );
                              },
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
                    final allSelected = visibleIds.isNotEmpty &&
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
              if (_isSelectionMode) ...[
                Positioned(
                  left: marginSizeMedium,
                  bottom: mainFabBottomInset(context),
                  child: SignicaMultiSelectActionButton(
                    enabled: _selectedIds.isNotEmpty,
                    label: 'main.multi_select.delete'.tr(),
                    onTap: () => _deleteSelected(context),
                    icon: Assets.deleteIcon.svg(
                      width: multiSelectActionIconSize,
                      height: multiSelectActionIconSize,
                      color: _selectedIds.isEmpty
                          ? Palette.multiSelectActionDisabled
                          : Palette.coral,
                    ),
                  ),
                ),
                Positioned(
                  right: marginSizeMedium,
                  bottom: mainFabBottomInset(context),
                  child: BlocBuilder<MainBloc, MainState>(
                    builder: (context, state) {
                      return SignicaMultiSelectActionButton(
                        enabled: _selectedIds.isNotEmpty,
                        label: 'main.multi_select.share'.tr(),
                        onTap: () => _shareSelected(context, state.documents),
                        icon: Assets.shareIcon.svg(
                          width: multiSelectActionIconSize,
                          height: multiSelectActionIconSize,
                          color: _selectedIds.isEmpty
                              ? Palette.multiSelectActionDisabled
                              : Palette.menuTextColor,
                        ),
                      );
                    },
                  ),
                ),
              ] else ...[
                Positioned(
                  left: marginSizeMedium,
                  bottom: mainFabBottomInset(context),
                  child: IgnorePointer(
                    ignoring: _areFabsHidden,
                    child: AnimatedOpacity(
                      opacity: _areFabsHidden ? 0 : 1,
                      duration: fabTransitionDuration,
                      curve: Curves.easeOutCubic,
                      child: AnimatedScale(
                        scale: _areFabsHidden ? 0.9 : 1,
                        duration: fabTransitionDuration,
                        curve: Curves.easeOutCubic,
                        child: SignicaSearchFab(
                          onTap: _openSearchOverlay,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: marginSizeMedium,
                  bottom: mainFabBottomInset(context),
                  child: IgnorePointer(
                    ignoring: _areFabsHidden,
                    child: AnimatedOpacity(
                      opacity: _areFabsHidden ? 0 : 1,
                      duration: fabTransitionDuration,
                      curve: Curves.easeOutCubic,
                      child: AnimatedScale(
                        scale: _areFabsHidden ? 0.9 : 1,
                        duration: fabTransitionDuration,
                        curve: Curves.easeOutCubic,
                        child: SignicaAddDocumentFab(
                          onTap: _openAddDocumentOverlay,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
