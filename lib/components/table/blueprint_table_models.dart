import 'package:flutter/material.dart';
import 'blueprint_table_enums.dart';

class BlueprintTableColumn {
  final String key;
  final String title;
  final BlueprintColumnAlign align;
  final double? width;
  final double? minWidth;
  final double? maxWidth;
  final bool sortable;
  final bool resizable;
  final Widget Function(dynamic value, int rowIndex)? cellBuilder;
  final Widget Function(String title, BlueprintSortDirection? sortDirection, VoidCallback? onSort)? headerBuilder;

  const BlueprintTableColumn({
    required this.key,
    required this.title,
    this.align = BlueprintColumnAlign.left,
    this.width,
    this.minWidth,
    this.maxWidth,
    this.sortable = false,
    this.resizable = false,
    this.cellBuilder,
    this.headerBuilder,
  });
}

class BlueprintTableSort {
  final String columnKey;
  final BlueprintSortDirection direction;

  const BlueprintTableSort({
    required this.columnKey,
    required this.direction,
  });
}