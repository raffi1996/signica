import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

@DataClassName('DocumentRow')
class Documents extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get pdfPath => text()();

  TextColumn get firstPagePreviewPath => text()();

  TextColumn get lastPagePreviewPath => text().nullable()();

  IntColumn get pageCount => integer()();

  BoolColumn get isSigned => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [Documents])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'signica');
  }

  @override
  int get schemaVersion => 1;
}
