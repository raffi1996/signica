import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signica/core/assets/assets.dart';
import 'package:signica/features/main/presentation/widgets/document_selection_overlay.dart';
import 'package:signica/features/main/presentation/widgets/unselected_checkbox.dart';

String? _assetName(SvgPicture svg) {
  final loader = svg.bytesLoader;
  if (loader is SvgAssetLoader) {
    return loader.assetName;
  }
  return null;
}

void main() {
  testWidgets('unselected overlay shows UnselectedCheckbox', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: DocumentSelectionOverlay(isSelected: false),
          ),
        ),
      ),
    );

    expect(find.byType(UnselectedCheckbox), findsOneWidget);
    expect(find.byType(SvgPicture), findsNothing);
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

    expect(find.byType(UnselectedCheckbox), findsNothing);
    final svg = tester.widget<SvgPicture>(find.byType(SvgPicture));
    expect(_assetName(svg), Assets.selectionSelectedIcon);
  });
}
