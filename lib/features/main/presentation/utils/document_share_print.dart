import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:signica/features/main/domain/entities/document.dart';

Future<void> shareSelectedDocuments({
  required BuildContext context,
  required List<Document> documents,
  required Set<String> selectedIds,
}) async {
  if (selectedIds.isEmpty) {
    return;
  }

  final selected = documents
      .where((doc) => selectedIds.contains(doc.id))
      .toList(growable: false);

  final files = <XFile>[];
  for (final document in selected) {
    final file = File(document.pdfPath);
    if (await file.exists()) {
      files.add(XFile(document.pdfPath, name: '${document.name}.pdf'));
    }
  }

  if (!context.mounted) {
    return;
  }

  if (files.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('main.multi_select.share_unavailable'.tr())),
    );
    return;
  }

  final box = context.findRenderObject() as RenderBox?;
  final origin = box == null ? null : box.localToGlobal(Offset.zero) & box.size;

  await SharePlus.instance.share(
    ShareParams(
      files: files,
      sharePositionOrigin: origin,
    ),
  );
}

Future<void> printDocument({
  required BuildContext context,
  required Document document,
}) async {
  final file = File(document.pdfPath);
  if (!await file.exists()) {
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('main.document_actions.print_unavailable'.tr())),
    );
    return;
  }

  final bytes = await file.readAsBytes();
  await Printing.layoutPdf(
    onLayout: (_) async => bytes,
    name: document.name,
  );
}

Future<void> shareDocument({
  required BuildContext context,
  required Document document,
}) async {
  final file = File(document.pdfPath);
  if (!await file.exists()) {
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('main.document_actions.share_unavailable'.tr())),
    );
    return;
  }

  if (!context.mounted) {
    return;
  }

  final box = context.findRenderObject() as RenderBox?;
  final origin = box == null ? null : box.localToGlobal(Offset.zero) & box.size;

  await SharePlus.instance.share(
    ShareParams(
      files: [XFile(document.pdfPath, name: '${document.name}.pdf')],
      sharePositionOrigin: origin,
    ),
  );
}
