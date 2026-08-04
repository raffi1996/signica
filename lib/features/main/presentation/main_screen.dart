import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signica/core/di/app_di.dart';
import 'package:signica/core/theme/themes.dart';
import 'package:signica/features/main/presentation/bloc/main_bloc.dart';
import 'package:signica/features/main/presentation/widgets/signica_add_document_fab.dart';
import 'package:signica/features/main/presentation/widgets/signica_add_document_overlay.dart';
import 'package:signica/features/main/presentation/widgets/signica_app_bar.dart';
import 'package:signica/features/main/presentation/widgets/signica_document_tab_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<MainBloc>(),
      child: Stack(
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
                  const Padding(
                    padding: EdgeInsets.fromLTRB(
                      marginSizeMedium,
                      marginSizeMedium,
                      marginSizeMedium,
                      0,
                    ),
                    child: SignicaDocumentTabBar(),
                  ),
                  Expanded(
                    child: BlocBuilder<MainBloc, MainState>(
                      builder: (context, state) {
                        if (state.status.isLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return const SignicaEmptyDocumentsView();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: moreButtonTopForToolbar(context),
            right: marginSizeMedium,
            child: const SignicaMoreButton(),
          ),
          SignicaAddDocumentOverlay(
            visible: _isAddDocumentOverlayVisible,
            onDismissed: _onAddDocumentOverlayDismissed,
          ),
          SignicaSearchOverlay(
            visible: _isSearchOverlayVisible,
            onDismissed: _onSearchOverlayDismissed,
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
      ),
    );
  }
}
