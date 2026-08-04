import 'package:flutter/material.dart';
import 'package:signica/core/theme/themes.dart';
import 'package:signica/features/main/domain/entities/document.dart';
import 'package:signica/features/main/presentation/widgets/signica_document_card.dart';

class SignicaDocumentsGrid extends StatelessWidget {
  const SignicaDocumentsGrid({
    required this.documents,
    this.onDocumentTap,
    super.key,
  });

  final List<Document> documents;
  final ValueChanged<Document>? onDocumentTap;

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
        childAspectRatio: 0.78,
      ),
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final document = documents[index];
        return SignicaDocumentCard(
          document: document,
          onTap: () => onDocumentTap?.call(document),
        );
      },
    );
  }
}
