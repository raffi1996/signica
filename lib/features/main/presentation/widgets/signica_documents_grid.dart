import 'package:flutter/material.dart';
import 'package:signica/core/theme/themes.dart';
import 'package:signica/features/main/domain/entities/document.dart';
import 'package:signica/features/main/presentation/widgets/signica_document_card.dart';

typedef DocumentLongPressCallback = void Function(
  Document document,
  Rect cardRect,
);

class SignicaDocumentsGrid extends StatelessWidget {
  const SignicaDocumentsGrid({
    required this.documents,
    this.onDocumentTap,
    this.onDocumentLongPress,
    this.selectionMode = false,
    this.selectedIds = const {},
    super.key,
  });

  final List<Document> documents;
  final ValueChanged<Document>? onDocumentTap;
  final DocumentLongPressCallback? onDocumentLongPress;
  final bool selectionMode;
  final Set<String> selectedIds;

  @override
  Widget build(BuildContext context) {
    final bottomInset =
        mainFabBottomInset(context) + searchFabSize + marginSizeLarge;

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
        return _DocumentGridItem(
          document: document,
          selectionMode: selectionMode,
          isSelected: selectedIds.contains(document.id),
          onTap: () => onDocumentTap?.call(document),
          onLongPress: selectionMode || onDocumentLongPress == null
              ? null
              : onDocumentLongPress,
        );
      },
    );
  }
}

class _DocumentGridItem extends StatelessWidget {
  const _DocumentGridItem({
    required this.document,
    required this.selectionMode,
    required this.isSelected,
    this.onTap,
    this.onLongPress,
  });

  final Document document;
  final bool selectionMode;
  final bool isSelected;
  final VoidCallback? onTap;
  final DocumentLongPressCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return SignicaDocumentCard(
      document: document,
      selectionMode: selectionMode,
      isSelected: isSelected,
      onTap: onTap,
      onLongPress: onLongPress == null
          ? null
          : () {
              final box = context.findRenderObject() as RenderBox?;
              if (box == null || !box.hasSize) {
                return;
              }
              final rect = box.localToGlobal(Offset.zero) & box.size;
              onLongPress!(document, rect);
            },
    );
  }
}
