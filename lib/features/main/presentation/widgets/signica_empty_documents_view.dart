import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/core/theme/themes.dart';
import 'package:signica/features/main/presentation/widgets/signica_add_document_source_button.dart';

class SignicaEmptyDocumentsView extends StatelessWidget {
  const SignicaEmptyDocumentsView({
    this.onFilesTap,
    this.onPhotosTap,
    this.onScannerTap,
    super.key,
  });

  final VoidCallback? onFilesTap;
  final VoidCallback? onPhotosTap;
  final VoidCallback? onScannerTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final buttonWidth =
            (constraints.maxWidth - marginSizeMedium) / 2;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: marginSizeMedium),
          child: Column(
            children: [
              const SizedBox(height: emptyStateImageTopSpacing),
              Assets.emptyStateDocument.png(
                width: 220,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: marginSizeLarge),
              Text(
                'main.empty_state.title'.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.emptyStateTitle.copyWith(
                  color: Palette.menuTextColor,
                ),
              ),
              const SizedBox(height: marginSizeSmall),
              Text(
                'main.empty_state.subtitle'.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.emptyStateSubtitle.copyWith(
                  color: Palette.darkGray3,
                ),
              ),
              const Spacer(flex: 3),
              Row(
                children: [
                  Expanded(
                    child: SignicaAddDocumentSourceButton(
                      icon: Assets.filesIcon.png(width: 24, height: 24),
                      label: 'main.empty_state.files'.tr(),
                      onTap: onFilesTap,
                    ),
                  ),
                  const SizedBox(width: marginSizeMedium),
                  Expanded(
                    child: SignicaAddDocumentSourceButton(
                      icon: Assets.photosIcon.png(width: 24, height: 24),
                      label: 'main.empty_state.photos'.tr(),
                      onTap: onPhotosTap,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: marginSizeMedium),
              Align(
                child: SizedBox(
                  width: buttonWidth,
                  child: SignicaAddDocumentSourceButton(
                    icon: Assets.scannerIcon.png(width: 24, height: 24),
                    label: 'main.empty_state.scanner'.tr(),
                    onTap: onScannerTap,
                  ),
                ),
              ),
              const SizedBox(height: marginSizeLarge),
            ],
          ),
        );
      },
    );
  }
}
