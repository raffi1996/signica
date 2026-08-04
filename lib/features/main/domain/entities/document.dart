import 'package:equatable/equatable.dart';

class Document extends Equatable {
  const Document({
    required this.id,
    required this.name,
    required this.pdfPath,
    required this.firstPagePreviewPath,
    required this.pageCount,
    required this.isSigned,
    required this.createdAt,
    this.lastPagePreviewPath,
  });

  final String id;
  final String name;
  final String pdfPath;
  final String firstPagePreviewPath;
  final String? lastPagePreviewPath;
  final int pageCount;
  final bool isSigned;
  final DateTime createdAt;

  bool get isMultiPage => pageCount > 1;

  Document copyWith({
    String? id,
    String? name,
    String? pdfPath,
    String? firstPagePreviewPath,
    String? lastPagePreviewPath,
    int? pageCount,
    bool? isSigned,
    DateTime? createdAt,
  }) {
    return Document(
      id: id ?? this.id,
      name: name ?? this.name,
      pdfPath: pdfPath ?? this.pdfPath,
      firstPagePreviewPath: firstPagePreviewPath ?? this.firstPagePreviewPath,
      lastPagePreviewPath: lastPagePreviewPath ?? this.lastPagePreviewPath,
      pageCount: pageCount ?? this.pageCount,
      isSigned: isSigned ?? this.isSigned,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    pdfPath,
    firstPagePreviewPath,
    lastPagePreviewPath,
    pageCount,
    isSigned,
    createdAt,
  ];
}
