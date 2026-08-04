// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:signica/features/main/presentation/document_viewer_screen.dart'
    as _i1;
import 'package:signica/features/main/presentation/main_screen.dart' as _i2;

/// generated route for
/// [_i1.DocumentViewerScreen]
class DocumentViewerRoute extends _i3.PageRouteInfo<DocumentViewerRouteArgs> {
  DocumentViewerRoute({
    required String pdfPath,
    required String title,
    _i4.Key? key,
    List<_i3.PageRouteInfo>? children,
  }) : super(
         DocumentViewerRoute.name,
         args: DocumentViewerRouteArgs(
           pdfPath: pdfPath,
           title: title,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'DocumentViewerRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DocumentViewerRouteArgs>();
      return _i1.DocumentViewerScreen(
        pdfPath: args.pdfPath,
        title: args.title,
        key: args.key,
      );
    },
  );
}

class DocumentViewerRouteArgs {
  const DocumentViewerRouteArgs({
    required this.pdfPath,
    required this.title,
    this.key,
  });

  final String pdfPath;

  final String title;

  final _i4.Key? key;

  @override
  String toString() {
    return 'DocumentViewerRouteArgs{pdfPath: $pdfPath, title: $title, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DocumentViewerRouteArgs) return false;
    return pdfPath == other.pdfPath && title == other.title && key == other.key;
  }

  @override
  int get hashCode => pdfPath.hashCode ^ title.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i2.MainScreen]
class MainRoute extends _i3.PageRouteInfo<void> {
  const MainRoute({List<_i3.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.MainScreen();
    },
  );
}
