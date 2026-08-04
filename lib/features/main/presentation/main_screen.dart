import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signica/core/di/app_di.dart';
import 'package:signica/core/theme/themes.dart';
import 'package:signica/features/main/presentation/bloc/main_bloc.dart';
import 'package:signica/features/main/presentation/widgets/signica_add_document_fab.dart';
import 'package:signica/features/main/presentation/widgets/signica_add_document_overlay.dart';
import 'package:signica/features/main/presentation/widgets/signica_app_bar.dart';
import 'package:signica/features/main/presentation/widgets/signica_document_tab_bar.dart';
import 'package:signica/features/main/presentation/widgets/signica_documents_grid.dart';
import 'package:signica/features/main/presentation/widgets/signica_empty_documents_view.dart';
import 'package:signica/features/main/presentation/widgets/signica_more_button.dart';
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

  Duration get fabTransitionDuration => const Duration(milliseconds: 220);

  bool get _areFabsHidden =>
      _isAddDocumentOverlayVisible || _isSearchOverlayVisible;

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

  void _addFromFiles(BuildContext context) {
    context.read<MainBloc>().add(const MainAddFromFilesEvent());
  }

  void _addFromPhotos(BuildContext context) {
    context.read<MainBloc>().add(const MainAddFromPhotosEvent());
  }

  void _addFromScanner(BuildContext context) {
    context.read<MainBloc>().add(const MainAddFromScannerEvent());
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
                              previous.errorMessage != current.errorMessage &&
                              current.errorMessage != null,
                          listener: (context, state) {
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
                              onDocumentTap: (document) {
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
              Positioned(
                top: moreButtonTopForToolbar(context),
                right: marginSizeMedium,
                child: SignicaMoreButton(
                  onAddDocumentTap: _openAddDocumentOverlay,
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
          );
        },
      ),
    );
  }
}
