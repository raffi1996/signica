part of 'signica_document_actions_overlay.dart';

class _DocumentActionsMenu extends StatelessWidget {
  const _DocumentActionsMenu({
    required this.width,
    required this.borderRadius,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.topActionHeight,
    required this.deleteRowHeight,
    required this.dividerInset,
    required this.iconSize,
    required this.glassSettings,
    required this.actionLabelStyle,
    required this.deleteLabelStyle,
    this.onPrintTap,
    this.onShareTap,
    this.onDeleteTap,
  });

  final double width;
  final double borderRadius;
  final double horizontalPadding;
  final double verticalPadding;
  final double topActionHeight;
  final double deleteRowHeight;
  final double dividerInset;
  final double iconSize;
  final LiquidGlassSettings glassSettings;
  final TextStyle actionLabelStyle;
  final TextStyle deleteLabelStyle;
  final VoidCallback? onPrintTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      width: width,
      useOwnLayer: true,
      allowElevation: true,
      settings: glassSettings,
      shape: LiquidRoundedRectangle(borderRadius: borderRadius),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: topActionHeight,
            child: Row(
              children: [
                Expanded(
                  child: _TopAction(
                    icon: Assets.printIcon.svg(
                      width: iconSize,
                      height: iconSize,
                      color: Palette.menuTextColor,
                    ),
                    label: 'main.document_actions.print'.tr(),
                    labelStyle: actionLabelStyle,
                    onTap: onPrintTap,
                  ),
                ),
                Expanded(
                  child: _TopAction(
                    icon: Assets.shareIcon.svg(
                      width: iconSize,
                      height: iconSize,
                      color: Palette.menuTextColor,
                    ),
                    label: 'main.document_actions.share'.tr(),
                    labelStyle: actionLabelStyle,
                    onTap: onShareTap,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: dividerInset),
            child: const ColoredBox(
              color: Color(0x33000000),
              child: SizedBox(height: 1, width: double.infinity),
            ),
          ),
          SizedBox(
            height: deleteRowHeight,
            width: double.infinity,
            child: _DeleteAction(
              icon: Assets.deleteIcon.svg(
                width: iconSize,
                height: iconSize,
                color: Palette.coral,
              ),
              label: 'main.document_actions.delete'.tr(),
              labelStyle: deleteLabelStyle,
              onTap: onDeleteTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _TopAction extends StatelessWidget {
  const _TopAction({
    required this.icon,
    required this.label,
    required this.labelStyle,
    this.onTap,
  });

  final Widget icon;
  final String label;
  final TextStyle labelStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 4),
          Text(label, style: labelStyle),
        ],
      ),
    );
  }
}

class _DeleteAction extends StatelessWidget {
  const _DeleteAction({
    required this.icon,
    required this.label,
    required this.labelStyle,
    this.onTap,
  });

  final Widget icon;
  final String label;
  final TextStyle labelStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 8),
            Text(label, style: labelStyle),
          ],
        ),
      ),
    );
  }
}
