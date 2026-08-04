import 'dart:io';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:signica/core/base/repositories/base_repository.dart';
import 'package:signica/core/database/app_database.dart';
import 'package:signica/core/exceptions/result.dart';
import 'package:signica/features/main/domain/entities/document.dart';
import 'package:signica/features/main/domain/repositories/main_repository.dart';

@LazySingleton(as: MainRepository)
class MainRepositoryImpl extends BaseRepository implements MainRepository {
  MainRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Stream<List<Document>> watchDocuments() {
    return (_db.select(_db.documents)..orderBy([
          (t) => OrderingTerm.desc(t.createdAt),
        ]))
        .watch()
        .map((rows) => rows.map(_mapRow).toList());
  }

  @override
  Future<Result<List<Document>>> getDocuments() {
    return asyncExecute(() async {
      final rows =
          await (_db.select(_db.documents)..orderBy([
                (t) => OrderingTerm.desc(t.createdAt),
              ]))
              .get();
      return rows.map(_mapRow).toList();
    });
  }

  @override
  Future<Result<Document>> addDocument(Document document) {
    return asyncExecute(() async {
      await _db
          .into(_db.documents)
          .insert(
            DocumentsCompanion.insert(
              id: document.id,
              name: document.name,
              pdfPath: document.pdfPath,
              firstPagePreviewPath: document.firstPagePreviewPath,
              lastPagePreviewPath: Value(document.lastPagePreviewPath),
              pageCount: document.pageCount,
              isSigned: Value(document.isSigned),
              createdAt: document.createdAt,
            ),
          );
      return document;
    });
  }

  @override
  Future<Result<Document>> toggleSigned(String id) {
    return asyncExecute(() async {
      final row = await (_db.select(
        _db.documents,
      )..where((t) => t.id.equals(id))).getSingle();
      final updated = row.copyWith(isSigned: !row.isSigned);
      await _db.update(_db.documents).replace(updated);
      return _mapRow(updated);
    });
  }

  @override
  Future<Result<void>> deleteDocuments(List<String> ids) {
    return asyncExecute(() async {
      if (ids.isEmpty) {
        return;
      }

      final rows = await (_db.select(
        _db.documents,
      )..where((t) => t.id.isIn(ids))).get();

      await (_db.delete(
        _db.documents,
      )..where((t) => t.id.isIn(ids))).go();

      for (final row in rows) {
        await _deleteDocumentFiles(row);
      }
    });
  }

  Future<void> _deleteDocumentFiles(DocumentRow row) async {
    Future<void> deletePath(String? path) async {
      if (path == null || path.isEmpty) {
        return;
      }
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    }

    await deletePath(row.pdfPath);
    await deletePath(row.firstPagePreviewPath);
    await deletePath(row.lastPagePreviewPath);

    final dir = Directory(p.dirname(row.pdfPath));
    if (await dir.exists()) {
      try {
        await dir.delete(recursive: true);
      } on FileSystemException {
        // Directory may already be partially cleaned; ignore.
      }
    }
  }

  Document _mapRow(DocumentRow row) {
    return Document(
      id: row.id,
      name: row.name,
      pdfPath: row.pdfPath,
      firstPagePreviewPath: row.firstPagePreviewPath,
      lastPagePreviewPath: row.lastPagePreviewPath,
      pageCount: row.pageCount,
      isSigned: row.isSigned,
      createdAt: row.createdAt,
    );
  }
}
