import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signica/core/theme/themes.dart';
import 'package:signica/features/main/presentation/widgets/document_selection_overlay.dart';

void main() {
  testWidgets('unselected overlay uses translucent fill without check', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: DocumentSelectionOverlay(isSelected: false),
          ),
        ),
      ),
    );

    final decorated = tester.widget<DecoratedBox>(
      find.byType(DecoratedBox),
    );
    final decoration = decorated.decoration as BoxDecoration;
    expect(decoration.color, Palette.documentSelectionUnselectedFill);
    expect(decoration.border, isNotNull);
    expect(find.byType(SvgPicture), findsNothing);
  });

  testWidgets('selected overlay uses green fill and check icon', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: DocumentSelectionOverlay(isSelected: true),
          ),
        ),
      ),
    );

    final decorated = tester.widget<DecoratedBox>(
      find.byType(DecoratedBox),
    );
    final decoration = decorated.decoration as BoxDecoration;
    expect(decoration.color, Palette.documentSelectionSelected);
    expect(find.byType(SvgPicture), findsOneWidget);
  });
}
