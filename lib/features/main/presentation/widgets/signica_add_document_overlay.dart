import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/theme/themes.dart';
import 'package:signica/features/main/presentation/widgets/signica_add_document_source_button.dart';

class SignicaAddDocumentOverlay extends StatefulWidget {
  const SignicaAddDocumentOverlay({
    required this.visible,
    required this.onDismissed,
    this.onFilesTap,
    this.onPhotosTap,
    this.onScannerTap,
    super.key,
  });

  final bool visible;
  final VoidCallback onDismissed;
  final VoidCallback? onFilesTap;
  final VoidCallback? onPhotosTap;
  final VoidCallback? onScannerTap;

  @override
  State<SignicaAddDocumentOverlay> createState() =>
      _SignicaAddDocumentOverlayState();
}

class _SignicaAddDocumentOverlayState extends State<SignicaAddDocumentOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final OverlayPortalController _portalController;

  double get blurSigma => 5;

  double get closeFabSize => searchFabSize;

  Duration get animationDuration => const Duration(milliseconds: 420);

  LiquidGlassSettings get closeFabGlassSettings => const LiquidGlassSettings(
    blur: 4,
    glassColor: Color(0x00000000),
    lightIntensity: 1.1,
    fresnelStrength: 0,
  );

  TextStyle get titleStyle => AppTextStyles.emptyStateTitle.copyWith(
    color: Palette.menuTextColor,
    decoration: TextDecoration.none,
    fontSize: 16,
  );

  @override
  void initState() {
    super.initState();
    _portalController = OverlayPortalController();
    _controller = AnimationController(
      vsync: this,
      duration: animationDuration,
    );
    if (widget.visible) {
      _scheduleOpen();
    }
  }

  @override
  void didUpdateWidget(covariant SignicaAddDocumentOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible && !oldWidget.visible) {
      _scheduleOpen();
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
      _controller.forward(from: 0);
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

  Animation<double> _interval(double begin, double end) {
    return CurvedAnimation(
      parent: _controller,
      curve: Interval(begin, end, curve: Curves.easeOutCubic),
    );
  }

  Color _overlayTint(double progress) {
    return Palette.addDocumentOverlayTint.withValues(
      alpha: Palette.addDocumentOverlayTint.a * progress,
    );
  }

  Widget _animatedEntry({
    required Animation<double> animation,
    required Widget child,
    double slideOffset = 28,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, slideOffset * (1 - animation.value)),
          child: Opacity(
            opacity: animation.value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    final bottomInset = mainFabBottomInset(context);
    final title = 'main.add_document_overlay.title'.tr();
    final backdropAnimation = _interval(0, 0.55);
    final titleAnimation = _interval(0.2, 0.75);
    final closeAnimation = _interval(0.15, 0.65);
    final scannerAnimation = _interval(0.08, 0.62);
    final photosAnimation = _interval(0.16, 0.7);
    final filesAnimation = _interval(0.24, 0.78);

    return Material(
      type: MaterialType.transparency,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedBuilder(
            animation: backdropAnimation,
            builder: (context, _) {
              final blur = blurSigma * backdropAnimation.value;
              return ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: blur,
                    sigmaY: blur,
                  ),
                  child: ColoredBox(
                    color: _overlayTint(backdropAnimation.value),
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            onTap: _dismiss,
            behavior: HitTestBehavior.opaque,
            child: const SizedBox.expand(),
          ),
          SafeArea(
            child: Stack(
              children: [
                Positioned(
                  right: marginSizeMedium,
                  bottom: bottomInset + closeFabSize + marginSizeNormal,
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _animatedEntry(
                          animation: filesAnimation,
                          child: SignicaAddDocumentSourceButton(
                            icon: Assets.filesIcon.png(width: 24, height: 24),
                            label: 'main.empty_state.files'.tr(),
                            onTap: () async {
                              final callback = widget.onFilesTap;
                              await _dismiss().then((_) => callback?.call());
                            },
                          ),
                        ),
                        const SizedBox(height: marginSizeNormal),
                        _animatedEntry(
                          animation: photosAnimation,
                          child: SignicaAddDocumentSourceButton(
                            icon: Assets.photosIcon.png(width: 24, height: 24),
                            label: 'main.empty_state.photos'.tr(),
                            onTap: () async {
                              final callback = widget.onPhotosTap;
                              await _dismiss().then((_) => callback?.call());
                            },
                          ),
                        ),
                        const SizedBox(height: marginSizeNormal),
                        _animatedEntry(
                          animation: scannerAnimation,
                          child: SignicaAddDocumentSourceButton(
                            icon: Assets.scannerIcon.png(width: 24, height: 24),
                            label: 'main.empty_state.scanner'.tr(),
                            onTap: () async {
                              final callback = widget.onScannerTap;
                              await _dismiss().then((_) => callback?.call());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: marginSizeMedium,
                  right: marginSizeMedium,
                  bottom: bottomInset,
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: _animatedEntry(
                            animation: titleAnimation,
                            slideOffset: 16,
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: titleStyle,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12,),
                        AnimatedBuilder(
                          animation: closeAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: 0.82 + (0.18 * closeAnimation.value),
                              child: Opacity(
                                opacity: closeAnimation.value,
                                child: child,
                              ),
                            );
                          },
                          child: GlassButton.custom(
                            width: closeFabSize,
                            height: closeFabSize,
                            useOwnLayer: true,
                            settings: closeFabGlassSettings,
                            stretch: 0.15,
                            label: 'Close',
                            onTap: _dismiss,
                            child: const DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: Palette.closeIconGradient,
                              ),
                              child: Icon(
                                Icons.close,
                                size: 24,
                                color: Palette.menuTextColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
