import 'package:flutter/material.dart';
import 'package:signica/core/theme/themes.dart';
import 'package:signica/features/main/domain/entities/document.dart';
import 'package:signica/features/main/presentation/widgets/signica_document_card.dart';

class SignicaDocumentsGrid extends StatelessWidget {
  const SignicaDocumentsGrid({
    required this.documents,
    this.onDocumentTap,
    this.selectionMode = false,
    this.selectedIds = const {},
    super.key,
  });

  final List<Document> documents;
  final ValueChanged<Document>? onDocumentTap;
  final bool selectionMode;
  final Set<String> selectedIds;

  @override
  Widget build(BuildContext context) {
    final bottomInset = mainFabBottomInset(context) + searchFabSize + marginSizeLarge;

    return GridView.builder(
      padding: EdgeInsets.fromLTRB(
        marginSizeMedium,
        marginSizeMedium,
        marginSizeMedium,
        bottomInset,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: marginSizeXLarge,
        crossAxisSpacing: marginSizeMedium,
        // Cell width on 393pt: (393 - 16*2 - 16) / 2 = 172.5
        // Card height from Figma sheet + typography spacing.
        childAspectRatio: 172.5 / SignicaDocumentCard.cardContentHeight,
      ),
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final document = documents[index];
        return SignicaDocumentCard(
          document: document,
          selectionMode: selectionMode,
          isSelected: selectedIds.contains(document.id),
          onTap: () => onDocumentTap?.call(document),
        );
      },
    );
  }
}
