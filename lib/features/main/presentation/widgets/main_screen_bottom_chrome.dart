import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/theme/themes.dart';
import 'package:signica/features/main/domain/entities/document.dart';
import 'package:signica/features/main/presentation/bloc/main_bloc.dart';
import 'package:signica/features/main/presentation/widgets/signica_add_document_fab.dart';
import 'package:signica/features/main/presentation/widgets/signica_multi_select_action_button.dart';
import 'package:signica/features/main/presentation/widgets/signica_search_fab.dart';

class MainScreenBottomChrome extends StatelessWidget {
  const MainScreenBottomChrome({
    required this.isSelectionMode,
    required this.areFabsHidden,
    required this.fabTransitionDuration,
    required this.selectedIds,
    required this.onDeleteSelected,
    required this.onShareSelected,
    required this.onSearchTap,
    required this.onAddDocumentTap,
    super.key,
  });

  final bool isSelectionMode;
  final bool areFabsHidden;
  final Duration fabTransitionDuration;
  final Set<String> selectedIds;
  final VoidCallback onDeleteSelected;
  final ValueChanged<List<Document>> onShareSelected;
  final VoidCallback onSearchTap;
  final VoidCallback onAddDocumentTap;

  @override
  Widget build(BuildContext context) {
    if (isSelectionMode) {
      return Positioned.fill(
        child: Stack(
          children: [
            Positioned(
              left: marginSizeMedium,
              bottom: mainFabBottomInset(context),
              child: SignicaMultiSelectActionButton(
                enabled: selectedIds.isNotEmpty,
                label: 'main.multi_select.delete'.tr(),
                onTap: onDeleteSelected,
                icon: Assets.deleteIcon.svg(
                  width: multiSelectActionIconSize,
                  height: multiSelectActionIconSize,
                  color: selectedIds.isEmpty
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
                    enabled: selectedIds.isNotEmpty,
                    label: 'main.multi_select.share'.tr(),
                    onTap: () => onShareSelected(state.documents),
                    icon: Assets.shareIcon.svg(
                      width: multiSelectActionIconSize,
                      height: multiSelectActionIconSize,
                      color: selectedIds.isEmpty
                          ? Palette.multiSelectActionDisabled
                          : Palette.menuTextColor,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            left: marginSizeMedium,
            bottom: mainFabBottomInset(context),
            child: IgnorePointer(
              ignoring: areFabsHidden,
              child: AnimatedOpacity(
                opacity: areFabsHidden ? 0 : 1,
                duration: fabTransitionDuration,
                curve: Curves.easeOutCubic,
                child: AnimatedScale(
                  scale: areFabsHidden ? 0.9 : 1,
                  duration: fabTransitionDuration,
                  curve: Curves.easeOutCubic,
                  child: SignicaSearchFab(
                    onTap: onSearchTap,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: marginSizeMedium,
            bottom: mainFabBottomInset(context),
            child: IgnorePointer(
              ignoring: areFabsHidden,
              child: AnimatedOpacity(
                opacity: areFabsHidden ? 0 : 1,
                duration: fabTransitionDuration,
                curve: Curves.easeOutCubic,
                child: AnimatedScale(
                  scale: areFabsHidden ? 0.9 : 1,
                  duration: fabTransitionDuration,
                  curve: Curves.easeOutCubic,
                  child: SignicaAddDocumentFab(
                    onTap: onAddDocumentTap,
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
