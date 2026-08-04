import 'dart:async';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/theme/themes.dart';
import 'package:signica/features/main/domain/entities/document.dart';
import 'package:signica/features/main/presentation/widgets/signica_document_card.dart';

part 'signica_document_actions_menu.dart';

class SignicaDocumentActionsOverlay extends StatefulWidget {
  const SignicaDocumentActionsOverlay({
    required this.visible,
    required this.document,
    required this.cardRect,
    required this.onDismissed,
    this.onPrintTap,
    this.onShareTap,
    this.onDeleteTap,
    super.key,
  });

  final bool visible;
  final Document? document;
  final Rect? cardRect;
  final VoidCallback onDismissed;
  final ValueChanged<Document>? onPrintTap;
  final ValueChanged<Document>? onShareTap;
  final ValueChanged<Document>? onDeleteTap;

  @override
  State<SignicaDocumentActionsOverlay> createState() =>
      _SignicaDocumentActionsOverlayState();
}

class _SignicaDocumentActionsOverlayState
    extends State<SignicaDocumentActionsOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final OverlayPortalController _portalController;

  Document? _document;
  Rect? _cardRect;

  static const double blurSigma = 8;
  static const Color overlayTint = Color(0x66FFFFFF);

  static const double menuWidth = 156;
  static const double menuBorderRadius = 24;
  static const double menuTopGap = 8;
  static const double menuHorizontalPadding = 8;
  static const double menuVerticalPadding = 10;
  static const double actionIconSize = 24;
  static const double topActionHeight = 56;
  static const double deleteRowHeight = 44;
  static const double dividerInset = 12;

  Duration get animationDuration => const Duration(milliseconds: 280);

  LiquidGlassSettings get menuGlassSettings => const LiquidGlassSettings(
    blur: 4,
    glassColor: Palette.menuGlassColor,
    lightIntensity: 1.1,
    fresnelStrength: 0,
  );

  TextStyle get actionLabelStyle => AppTextStyles.documentDate.copyWith(
    color: Palette.menuTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 13,
    decoration: TextDecoration.none,
  );

  TextStyle get deleteLabelStyle => actionLabelStyle.copyWith(
    color: Palette.coral,
    fontWeight: FontWeight.w600,
  );

  @override
  void initState() {
    super.initState();
    _portalController = OverlayPortalController();
    _controller = AnimationController(
      vsync: this,
      duration: animationDuration,
    );
    _document = widget.document;
    _cardRect = widget.cardRect;
    if (widget.visible) {
      _scheduleOpen();
    }
  }

  @override
  void didUpdateWidget(covariant SignicaDocumentActionsOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible && !oldWidget.visible) {
      _document = widget.document;
      _cardRect = widget.cardRect;
      _scheduleOpen();
    } else if (!widget.visible && oldWidget.visible) {
      unawaited(_dismissFromParent());
    } else if (widget.visible) {
      _document = widget.document ?? _document;
      _cardRect = widget.cardRect ?? _cardRect;
    }
  }

  Future<void> _dismissFromParent() async {
    if (_controller.status == AnimationStatus.reverse ||
        _controller.value == 0) {
      _scheduleHide();
      return;
    }
    await _controller.reverse();
    if (mounted) {
      _scheduleHide();
    }
  }

  void _scheduleOpen() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !widget.visible) {
        return;
      }
      if (!_portalController.isShowing) {
        _portalController.show();
      }
      unawaited(_controller.forward(from: 0));
    });
  }

  void _scheduleHide() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      if (_portalController.isShowing) {
        _portalController.hide();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _dismiss() async {
    if (_controller.status == AnimationStatus.reverse ||
        _controller.value == 0) {
      return;
    }
    await _controller.reverse();
    if (mounted) {
      _scheduleHide();
      widget.onDismissed();
    }
  }

  Future<void> _runAction(ValueChanged<Document>? action) async {
    final document = _document;
    final callback = action;
    if (document == null || callback == null) {
      return;
    }
    await _dismiss();
    callback(document);
  }

  Offset _menuPosition(Size screenSize, Rect cardRect, EdgeInsets padding) {
    const menuHeight =
        menuVerticalPadding * 2 + topActionHeight + 1 + deleteRowHeight;
    var left = cardRect.center.dx - menuWidth / 2;
    var top = cardRect.top + SignicaDocumentCard.stackHeight + menuTopGap;

    final minLeft = padding.left + marginSizeSmall;
    final maxLeft =
        screenSize.width - padding.right - menuWidth - marginSizeSmall;
    left = left.clamp(minLeft, maxLeft);

    final maxTop =
        screenSize.height - padding.bottom - menuHeight - marginSizeMedium;
    if (top > maxTop) {
      top = (cardRect.top - menuHeight - menuTopGap).clamp(
        padding.top + marginSizeSmall,
        maxTop,
      );
    }

    return Offset(left, top);
  }

  Widget _buildOverlayContent(BuildContext context) {
    final document = _document;
    final cardRect = _cardRect;
    if (document == null || cardRect == null) {
      return const SizedBox.shrink();
    }

    final media = MediaQuery.of(context);
    final menuOffset = _menuPosition(media.size, cardRect, media.padding);
    final progress = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    return Material(
      type: MaterialType.transparency,
      child: AnimatedBuilder(
        animation: progress,
        builder: (context, _) {
          final t = progress.value;
          return Stack(
            fit: StackFit.expand,
            children: [
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: blurSigma * t,
                    sigmaY: blurSigma * t,
                  ),
                  child: ColoredBox(
                    color: overlayTint.withValues(alpha: overlayTint.a * t),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => unawaited(_dismiss()),
                behavior: HitTestBehavior.opaque,
                child: const SizedBox.expand(),
              ),
              Positioned(
                left: cardRect.left,
                top: cardRect.top,
                width: cardRect.width,
                height: cardRect.height,
                child: IgnorePointer(
                  child: Opacity(
                    opacity: t,
                    child: SignicaDocumentCard(document: document),
                  ),
                ),
              ),
              Positioned(
                left: menuOffset.dx,
                top: menuOffset.dy,
                child: Opacity(
                  opacity: t,
                  child: Transform.scale(
                    scale: 0.92 + (0.08 * t),
                    alignment: Alignment.topCenter,
                    child: _DocumentActionsMenu(
                      width: menuWidth,
                      borderRadius: menuBorderRadius,
                      horizontalPadding: menuHorizontalPadding,
                      verticalPadding: menuVerticalPadding,
                      topActionHeight: topActionHeight,
                      deleteRowHeight: deleteRowHeight,
                      dividerInset: dividerInset,
                      iconSize: actionIconSize,
                      glassSettings: menuGlassSettings,
                      actionLabelStyle: actionLabelStyle,
                      deleteLabelStyle: deleteLabelStyle,
                      onPrintTap: () =>
                          unawaited(_runAction(widget.onPrintTap)),
                      onShareTap: () =>
                          unawaited(_runAction(widget.onShareTap)),
                      onDeleteTap: () =>
                          unawaited(_runAction(widget.onDeleteTap)),
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

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _portalController,
      overlayChildBuilder: (context) {
        return Positioned.fill(
          child: _buildOverlayContent(context),
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
