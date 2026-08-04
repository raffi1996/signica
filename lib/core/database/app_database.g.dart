// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, DocumentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pdfPathMeta = const VerificationMeta(
    'pdfPath',
  );
  @override
  late final GeneratedColumn<String> pdfPath = GeneratedColumn<String>(
    'pdf_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstPagePreviewPathMeta =
      const VerificationMeta('firstPagePreviewPath');
  @override
  late final GeneratedColumn<String> firstPagePreviewPath =
      GeneratedColumn<String>(
        'first_page_preview_path',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _lastPagePreviewPathMeta =
      const VerificationMeta('lastPagePreviewPath');
  @override
  late final GeneratedColumn<String> lastPagePreviewPath =
      GeneratedColumn<String>(
        'last_page_preview_path',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _pageCountMeta = const VerificationMeta(
    'pageCount',
  );
  @override
  late final GeneratedColumn<int> pageCount = GeneratedColumn<int>(
    'page_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSignedMeta = const VerificationMeta(
    'isSigned',
  );
  @override
  late final GeneratedColumn<bool> isSigned = GeneratedColumn<bool>(
    'is_signed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_signed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    pdfPath,
    firstPagePreviewPath,
    lastPagePreviewPath,
    pageCount,
    isSigned,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('pdf_path')) {
      context.handle(
        _pdfPathMeta,
        pdfPath.isAcceptableOrUnknown(data['pdf_path']!, _pdfPathMeta),
      );
    } else if (isInserting) {
      context.missing(_pdfPathMeta);
    }
    if (data.containsKey('first_page_preview_path')) {
      context.handle(
        _firstPagePreviewPathMeta,
        firstPagePreviewPath.isAcceptableOrUnknown(
          data['first_page_preview_path']!,
          _firstPagePreviewPathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstPagePreviewPathMeta);
    }
    if (data.containsKey('last_page_preview_path')) {
      context.handle(
        _lastPagePreviewPathMeta,
        lastPagePreviewPath.isAcceptableOrUnknown(
          data['last_page_preview_path']!,
          _lastPagePreviewPathMeta,
        ),
      );
    }
    if (data.containsKey('page_count')) {
      context.handle(
        _pageCountMeta,
        pageCount.isAcceptableOrUnknown(data['page_count']!, _pageCountMeta),
      );
    } else if (isInserting) {
      context.missing(_pageCountMeta);
    }
    if (data.containsKey('is_signed')) {
      context.handle(
        _isSignedMeta,
        isSigned.isAcceptableOrUnknown(data['is_signed']!, _isSignedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      pdfPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pdf_path'],
      )!,
      firstPagePreviewPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_page_preview_path'],
      )!,
      lastPagePreviewPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_page_preview_path'],
      ),
      pageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_count'],
      )!,
      isSigned: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_signed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }
}

class DocumentRow extends DataClass implements Insertable<DocumentRow> {
  final String id;
  final String name;
  final String pdfPath;
  final String firstPagePreviewPath;
  final String? lastPagePreviewPath;
  final int pageCount;
  final bool isSigned;
  final DateTime createdAt;
  const DocumentRow({
    required this.id,
    required this.name,
    required this.pdfPath,
    required this.firstPagePreviewPath,
    this.lastPagePreviewPath,
    required this.pageCount,
    required this.isSigned,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['pdf_path'] = Variable<String>(pdfPath);
    map['first_page_preview_path'] = Variable<String>(firstPagePreviewPath);
    if (!nullToAbsent || lastPagePreviewPath != null) {
      map['last_page_preview_path'] = Variable<String>(lastPagePreviewPath);
    }
    map['page_count'] = Variable<int>(pageCount);
    map['is_signed'] = Variable<bool>(isSigned);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      name: Value(name),
      pdfPath: Value(pdfPath),
      firstPagePreviewPath: Value(firstPagePreviewPath),
      lastPagePreviewPath: lastPagePreviewPath == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPagePreviewPath),
      pageCount: Value(pageCount),
      isSigned: Value(isSigned),
      createdAt: Value(createdAt),
    );
  }

  factory DocumentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      pdfPath: serializer.fromJson<String>(json['pdfPath']),
      firstPagePreviewPath: serializer.fromJson<String>(
        json['firstPagePreviewPath'],
      ),
      lastPagePreviewPath: serializer.fromJson<String?>(
        json['lastPagePreviewPath'],
      ),
      pageCount: serializer.fromJson<int>(json['pageCount']),
      isSigned: serializer.fromJson<bool>(json['isSigned']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'pdfPath': serializer.toJson<String>(pdfPath),
      'firstPagePreviewPath': serializer.toJson<String>(firstPagePreviewPath),
      'lastPagePreviewPath': serializer.toJson<String?>(lastPagePreviewPath),
      'pageCount': serializer.toJson<int>(pageCount),
      'isSigned': serializer.toJson<bool>(isSigned),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DocumentRow copyWith({
    String? id,
    String? name,
    String? pdfPath,
    String? firstPagePreviewPath,
    Value<String?> lastPagePreviewPath = const Value.absent(),
    int? pageCount,
    bool? isSigned,
    DateTime? createdAt,
  }) => DocumentRow(
    id: id ?? this.id,
    name: name ?? this.name,
    pdfPath: pdfPath ?? this.pdfPath,
    firstPagePreviewPath: firstPagePreviewPath ?? this.firstPagePreviewPath,
    lastPagePreviewPath: lastPagePreviewPath.present
        ? lastPagePreviewPath.value
        : this.lastPagePreviewPath,
    pageCount: pageCount ?? this.pageCount,
    isSigned: isSigned ?? this.isSigned,
    createdAt: createdAt ?? this.createdAt,
  );
  DocumentRow copyWithCompanion(DocumentsCompanion data) {
    return DocumentRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      pdfPath: data.pdfPath.present ? data.pdfPath.value : this.pdfPath,
      firstPagePreviewPath: data.firstPagePreviewPath.present
          ? data.firstPagePreviewPath.value
          : this.firstPagePreviewPath,
      lastPagePreviewPath: data.lastPagePreviewPath.present
          ? data.lastPagePreviewPath.value
          : this.lastPagePreviewPath,
      pageCount: data.pageCount.present ? data.pageCount.value : this.pageCount,
      isSigned: data.isSigned.present ? data.isSigned.value : this.isSigned,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('pdfPath: $pdfPath, ')
          ..write('firstPagePreviewPath: $firstPagePreviewPath, ')
          ..write('lastPagePreviewPath: $lastPagePreviewPath, ')
          ..write('pageCount: $pageCount, ')
          ..write('isSigned: $isSigned, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    pdfPath,
    firstPagePreviewPath,
    lastPagePreviewPath,
    pageCount,
    isSigned,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.pdfPath == this.pdfPath &&
          other.firstPagePreviewPath == this.firstPagePreviewPath &&
          other.lastPagePreviewPath == this.lastPagePreviewPath &&
          other.pageCount == this.pageCount &&
          other.isSigned == this.isSigned &&
          other.createdAt == this.createdAt);
}

class DocumentsCompanion extends UpdateCompanion<DocumentRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> pdfPath;
  final Value<String> firstPagePreviewPath;
  final Value<String?> lastPagePreviewPath;
  final Value<int> pageCount;
  final Value<bool> isSigned;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.pdfPath = const Value.absent(),
    this.firstPagePreviewPath = const Value.absent(),
    this.lastPagePreviewPath = const Value.absent(),
    this.pageCount = const Value.absent(),
    this.isSigned = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentsCompanion.insert({
    required String id,
    required String name,
    required String pdfPath,
    required String firstPagePreviewPath,
    this.lastPagePreviewPath = const Value.absent(),
    required int pageCount,
    this.isSigned = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       pdfPath = Value(pdfPath),
       firstPagePreviewPath = Value(firstPagePreviewPath),
       pageCount = Value(pageCount),
       createdAt = Value(createdAt);
  static Insertable<DocumentRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? pdfPath,
    Expression<String>? firstPagePreviewPath,
    Expression<String>? lastPagePreviewPath,
    Expression<int>? pageCount,
    Expression<bool>? isSigned,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (pdfPath != null) 'pdf_path': pdfPath,
      if (firstPagePreviewPath != null)
        'first_page_preview_path': firstPagePreviewPath,
      if (lastPagePreviewPath != null)
        'last_page_preview_path': lastPagePreviewPath,
      if (pageCount != null) 'page_count': pageCount,
      if (isSigned != null) 'is_signed': isSigned,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? pdfPath,
    Value<String>? firstPagePreviewPath,
    Value<String?>? lastPagePreviewPath,
    Value<int>? pageCount,
    Value<bool>? isSigned,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return DocumentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      pdfPath: pdfPath ?? this.pdfPath,
      firstPagePreviewPath: firstPagePreviewPath ?? this.firstPagePreviewPath,
      lastPagePreviewPath: lastPagePreviewPath ?? this.lastPagePreviewPath,
      pageCount: pageCount ?? this.pageCount,
      isSigned: isSigned ?? this.isSigned,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (pdfPath.present) {
      map['pdf_path'] = Variable<String>(pdfPath.value);
    }
    if (firstPagePreviewPath.present) {
      map['first_page_preview_path'] = Variable<String>(
        firstPagePreviewPath.value,
      );
    }
    if (lastPagePreviewPath.present) {
      map['last_page_preview_path'] = Variable<String>(
        lastPagePreviewPath.value,
      );
    }
    if (pageCount.present) {
      map['page_count'] = Variable<int>(pageCount.value);
    }
    if (isSigned.present) {
      map['is_signed'] = Variable<bool>(isSigned.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('pdfPath: $pdfPath, ')
          ..write('firstPagePreviewPath: $firstPagePreviewPath, ')
          ..write('lastPagePreviewPath: $lastPagePreviewPath, ')
          ..write('pageCount: $pageCount, ')
          ..write('isSigned: $isSigned, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [documents];
}

typedef $$DocumentsTableCreateCompanionBuilder =
    DocumentsCompanion Function({
      required String id,
      required String name,
      required String pdfPath,
      required String firstPagePreviewPath,
      Value<String?> lastPagePreviewPath,
      required int pageCount,
      Value<bool> isSigned,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$DocumentsTableUpdateCompanionBuilder =
    DocumentsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> pdfPath,
      Value<String> firstPagePreviewPath,
      Value<String?> lastPagePreviewPath,
      Value<int> pageCount,
      Value<bool> isSigned,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$DocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pdfPath => $composableBuilder(
    column: $table.pdfPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstPagePreviewPath => $composableBuilder(
    column: $table.firstPagePreviewPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastPagePreviewPath => $composableBuilder(
    column: $table.lastPagePreviewPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageCount => $composableBuilder(
    column: $table.pageCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSigned => $composableBuilder(
    column: $table.isSigned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pdfPath => $composableBuilder(
    column: $table.pdfPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstPagePreviewPath => $composableBuilder(
    column: $table.firstPagePreviewPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastPagePreviewPath => $composableBuilder(
    column: $table.lastPagePreviewPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageCount => $composableBuilder(
    column: $table.pageCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSigned => $composableBuilder(
    column: $table.isSigned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get pdfPath =>
      $composableBuilder(column: $table.pdfPath, builder: (column) => column);

  GeneratedColumn<String> get firstPagePreviewPath => $composableBuilder(
    column: $table.firstPagePreviewPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastPagePreviewPath => $composableBuilder(
    column: $table.lastPagePreviewPath,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pageCount =>
      $composableBuilder(column: $table.pageCount, builder: (column) => column);

  GeneratedColumn<bool> get isSigned =>
      $composableBuilder(column: $table.isSigned, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentsTable,
          DocumentRow,
          $$DocumentsTableFilterComposer,
          $$DocumentsTableOrderingComposer,
          $$DocumentsTableAnnotationComposer,
          $$DocumentsTableCreateCompanionBuilder,
          $$DocumentsTableUpdateCompanionBuilder,
          (
            DocumentRow,
            BaseReferences<_$AppDatabase, $DocumentsTable, DocumentRow>,
          ),
          DocumentRow,
          PrefetchHooks Function()
        > {
  $$DocumentsTableTableManager(_$AppDatabase db, $DocumentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> pdfPath = const Value.absent(),
                Value<String> firstPagePreviewPath = const Value.absent(),
                Value<String?> lastPagePreviewPath = const Value.absent(),
                Value<int> pageCount = const Value.absent(),
                Value<bool> isSigned = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion(
                id: id,
                name: name,
                pdfPath: pdfPath,
                firstPagePreviewPath: firstPagePreviewPath,
                lastPagePreviewPath: lastPagePreviewPath,
                pageCount: pageCount,
                isSigned: isSigned,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String pdfPath,
                required String firstPagePreviewPath,
                Value<String?> lastPagePreviewPath = const Value.absent(),
                required int pageCount,
                Value<bool> isSigned = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion.insert(
                id: id,
                name: name,
                pdfPath: pdfPath,
                firstPagePreviewPath: firstPagePreviewPath,
                lastPagePreviewPath: lastPagePreviewPath,
                pageCount: pageCount,
                isSigned: isSigned,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentsTable,
      DocumentRow,
      $$DocumentsTableFilterComposer,
      $$DocumentsTableOrderingComposer,
      $$DocumentsTableAnnotationComposer,
      $$DocumentsTableCreateCompanionBuilder,
      $$DocumentsTableUpdateCompanionBuilder,
      (
        DocumentRow,
        BaseReferences<_$AppDatabase, $DocumentsTable, DocumentRow>,
      ),
      DocumentRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
}
