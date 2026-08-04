import 'package:flutter_test/flutter_test.dart';
import 'package:signica/features/main/domain/utils/unique_document_name.dart';

void main() {
  group('uniqueDocumentName', () {
    test('returns desired name when no collisions', () {
      expect(
        uniqueDocumentName(
          desiredName: 'New Document',
          existingNames: const [],
        ),
        'New Document',
      );
    });

    test('appends 2 when base name exists', () {
      expect(
        uniqueDocumentName(
          desiredName: 'New Document',
          existingNames: const ['New Document'],
        ),
        'New Document 2',
      );
    });

    test('increments sequentially', () {
      expect(
        uniqueDocumentName(
          desiredName: 'Document',
          existingNames: const ['Document', 'Document 2'],
        ),
        'Document 3',
      );
    });

    test('fills gaps in numbering', () {
      expect(
        uniqueDocumentName(
          desiredName: 'Document',
          existingNames: const ['Document', 'Document 2', 'Document 4'],
        ),
        'Document 3',
      );
    });

    test('inserts suffix before extension', () {
      expect(
        uniqueDocumentName(
          desiredName: 'Document.pdf',
          existingNames: const ['Document.pdf'],
        ),
        'Document 2.pdf',
      );
    });

    test('fills gaps with extension', () {
      expect(
        uniqueDocumentName(
          desiredName: 'Document.pdf',
          existingNames: const [
            'Document.pdf',
            'Document 2.pdf',
            'Document 4.pdf',
          ],
        ),
        'Document 3.pdf',
      );
    });

    test('trims desired name', () {
      expect(
        uniqueDocumentName(
          desiredName: '  Report  ',
          existingNames: const ['Report'],
        ),
        'Report 2',
      );
    });

    test('does not match longer unrelated names', () {
      expect(
        uniqueDocumentName(
          desiredName: 'Document',
          existingNames: const ['Document Notes', 'Document-backup'],
        ),
        'Document',
      );
    });
  });
}
