import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/theme/themes.dart';

class SignicaSearchOverlay extends StatefulWidget {
  const SignicaSearchOverlay({
    required this.visible,
    required this.onDismissed,
    this.onQueryChanged,
    super.key,
  });

  final bool visible;
  final VoidCallback onDismissed;
  final ValueChanged<String>? onQueryChanged;

  @override
  State<SignicaSearchOverlay> createState() => _SignicaSearchOverlayState();
}

class _SignicaSearchOverlayState extends State<SignicaSearchOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late final FocusNode _focusNode;
  late final TextEditingController _textController;

  bool _isClosing = false;
  bool _hadFocus = false;

  double get panelHeight => 56;

  double get closeButtonSize => panelHeight;

  double get searchIconSize => 26;

  double get closeIconSize => 24;

  Duration get animationDuration => const Duration(milliseconds: 280);

  LiquidGlassSettings get glassSettings => const LiquidGlassSettings(
    blur: 8,
    thickness: 28,
    glassColor: Color(0xB3FFFFFF),
    lightIntensity: 1.1,
    fresnelStrength: 0,
    glowIntensity: 1,
    shadowElevation: 1.4,
  );

  TextStyle get placeholderStyle => AppTextStyles.searchFieldText.copyWith(
    color: Palette.darkGray3,
  );

  TextStyle get inputStyle => AppTextStyles.searchFieldText.copyWith(
    color: Palette.menuTextColor,
  );

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChanged);
    _textController = TextEditingController();
    _textController.addListener(_onQueryChanged);
    _controller = AnimationController(
      vsync: this,
      duration: animationDuration,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    if (widget.visible) {
      _open();
    }
  }

  @override
  void didUpdateWidget(covariant SignicaSearchOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible && !oldWidget.visible) {
      _open();
    } else if (!widget.visible && oldWidget.visible) {
      unawaited(_close());
    }
  }

  void _open() {
    _isClosing = false;
    _hadFocus = false;
    unawaited(_controller.forward(from: 0));
    _requestFocus();
  }

  void _requestFocus() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && widget.visible && !_isClosing) {
        _focusNode.requestFocus();
      }
    });
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      _hadFocus = true;
      return;
    }
    if (_hadFocus && widget.visible && !_isClosing) {
      unawaited(_close());
    }
  }

  void _onQueryChanged() {
    widget.onQueryChanged?.call(_textController.text);
  }

  Future<void> _close() async {
    if (_isClosing ||
        _controller.status == AnimationStatus.reverse ||
        _controller.value == 0) {
      return;
    }
    _isClosing = true;
    _hadFocus = false;
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
    _textController.clear();
    widget.onQueryChanged?.call('');
    await _controller.reverse();
    if (mounted) {
      widget.onDismissed();
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _textController.removeListener(_onQueryChanged);
    _controller.dispose();
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  Widget _buildSearchField() {
    return GlassTextField.search(
      controller: _textController,
      focusNode: _focusNode,
      placeholder: 'main.search_overlay.placeholder'.tr(),
      prefixIcon: Assets.searchIcon.png(
        width: searchIconSize,
        height: searchIconSize,
      ),
      textStyle: inputStyle,
      placeholderStyle: placeholderStyle,
      height: panelHeight,
      useOwnLayer: true,
      settings: glassSettings,
      shape: LiquidRoundedRectangle(
        borderRadius: panelHeight / 2,
      ),
      glowColor: Palette.white.withValues(alpha: 0.55),
      glowRadius: 2.2,
      onTapOutside: (_) {
        unawaited(_close());
      },
    );
  }

  Widget _buildCloseButton() {
    return GlassButton.custom(
      width: closeButtonSize,
      height: closeButtonSize,
      useOwnLayer: true,
      settings: glassSettings,
      stretch: 0.15,
      label: 'Close',
      onTap: _close,
      child: Center(
        child: Assets.closeIcon.png(
          width: closeIconSize,
          height: closeIconSize,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isHidden =
        !widget.visible && !_controller.isAnimating && _controller.value == 0;
    if (isHidden) {
      return const SizedBox.shrink();
    }

    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

    return Positioned(
      left: 0,
      right: 0,
      bottom: keyboardInset,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Opacity(
            opacity: _animation.value,
            child: Transform.translate(
              offset: Offset(0, 16 * (1 - _animation.value)),
              child: child,
            ),
          );
        },
        child: SafeArea(
          top: false,
          bottom: keyboardInset == 0,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              marginSizeMedium,
              0,
              marginSizeMedium,
              keyboardInset > 0 ? marginSizeSmall : marginSizeMedium,
            ),
            child: SizedBox(
              height: panelHeight,
              child: Row(
                children: [
                  Expanded(child: _buildSearchField()),
                  const SizedBox(width: marginSizeSmall),
                  _buildCloseButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
