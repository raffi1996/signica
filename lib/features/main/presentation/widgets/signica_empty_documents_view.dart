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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: marginSizeMedium),
      child: Column(
        children: [
          SizedBox(height: emptyStateImageTopSpacing),
          Assets.emptyStateDocument.png(
            width: 220,
            fit: BoxFit.contain,
          ),
          SizedBox(height: marginSizeLarge),
          Text(
            'main.empty_state.title'.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyles.emptyStateTitle.copyWith(
              color: Palette.menuTextColor,
            ),
          ),
          SizedBox(height: marginSizeSmall),
          Text(
            'main.empty_state.subtitle'.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyles.emptyStateSubtitle.copyWith(
              color: Palette.darkGray3,
            ),
          ),
          SizedBox(height: marginSizeMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SignicaAddDocumentSourceButton(
                icon: Assets.filesIcon.png(width: 24, height: 24),
                label: 'main.empty_state.files'.tr(),
                onTap: onFilesTap,
              ),
              SizedBox(width: marginSizeMedium),
              SignicaAddDocumentSourceButton(
                icon: Assets.photosIcon.png(width: 24, height: 24),
                label: 'main.empty_state.photos'.tr(),
                onTap: onPhotosTap,
              ),
            ],
          ),
          SizedBox(height: marginSizeMedium),
          SignicaAddDocumentSourceButton(
            icon: Assets.scannerIcon.png(width: 24, height: 24),
            label: 'main.empty_state.scanner'.tr(),
            onTap: onScannerTap,
          ),
          SizedBox(height: mainFabContentBottomSpacing),
        ],
      ),
    );
  }
}
