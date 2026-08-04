import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:signica/core/theme/themes.dart';

enum SignicaDocumentTab {
  all,
  signed,
  unsigned,
}

class SignicaDocumentTabBar extends StatelessWidget {
  const SignicaDocumentTabBar({
    super.key,
    this.selectedTab = SignicaDocumentTab.all,
    this.onTabSelected,
    this.disabledTabs = const {
      SignicaDocumentTab.signed,
      SignicaDocumentTab.unsigned,
    },
  });

  static const double height = 36;
  static const double _innerPadding = 4;

  final SignicaDocumentTab selectedTab;
  final ValueChanged<SignicaDocumentTab>? onTabSelected;
  final Set<SignicaDocumentTab> disabledTabs;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tabWidth = (constraints.maxWidth - _innerPadding * 2) / 3;
        final selectedIndex = selectedTab.index;

        return Container(
          height: height,
          padding: const EdgeInsets.all(_innerPadding),
          decoration: BoxDecoration(
            color: Palette.tabBarTrack,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                left: tabWidth * selectedIndex,
                top: 0,
                bottom: 0,
                width: tabWidth,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Palette.white,
                    borderRadius: BorderRadius.circular(
                      (height - _innerPadding * 2) / 2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 4,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: SignicaDocumentTab.values.map((tab) {
                  final isEnabled = !disabledTabs.contains(tab);

                  return Expanded(
                    child: _TabButton(
                      label: _labelFor(tab).tr(),
                      onTap: isEnabled ? () => onTabSelected?.call(tab) : null,
                    ),
                  );
                }).toList(),
              ),
              Positioned(
                left: tabWidth * 2 - 0.5,
                top: 0,
                bottom: 0,
                child: const Center(
                  child: ColoredBox(
                    color: Palette.tabBarDivider,
                    child: SizedBox(width: 1, height: 28),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _labelFor(SignicaDocumentTab tab) => switch (tab) {
    SignicaDocumentTab.all => 'main.tabs.all',
    SignicaDocumentTab.signed => 'main.tabs.signed',
    SignicaDocumentTab.unsigned => 'main.tabs.unsigned',
  };
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final labelWidget = Text(
      label,
      textAlign: TextAlign.center,
      style: AppTextStyles.tabBarLabel.copyWith(
        color: Palette.menuTextColor,
      ),
    );

    if (onTap == null) {
      return Center(child: labelWidget);
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Center(child: labelWidget),
    );
  }
}
