import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/features/main/presentation/widgets/document_selection_overlay.dart';

String? _assetName(SvgPicture svg) {
  final loader = svg.bytesLoader;
  if (loader is SvgAssetLoader) {
    return loader.assetName;
  }
  return null;
}

void main() {
  testWidgets('unselected overlay shows empty circle icon', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: DocumentSelectionOverlay(isSelected: false),
          ),
        ),
      ),
    );

    final svg = tester.widget<SvgPicture>(find.byType(SvgPicture));
    expect(_assetName(svg), Assets.selectionUnselectedIcon);
  });

  testWidgets('selected overlay shows green check icon', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: DocumentSelectionOverlay(isSelected: true),
          ),
        ),
      ),
    );

    final svg = tester.widget<SvgPicture>(find.byType(SvgPicture));
    expect(_assetName(svg), Assets.selectionSelectedIcon);
  });
}
