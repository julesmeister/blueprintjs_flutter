import 'package:flutter/material.dart';
import 'blueprint_table_enums.dart';
import 'blueprint_table_models.dart';

// Forward declaration
abstract class BlueprintTable extends StatefulWidget {
  const BlueprintTable({
    Key? key,
    required List<BlueprintTableColumn> columns,
    required List<Map<String, dynamic>> data,
    BlueprintTableSize size = BlueprintTableSize.standard,
    bool striped = true,
    bool bordered = false,
    bool interactive = false,
    bool condensed = false,
    bool enableColumnReordering = false,
    BlueprintTableSort? defaultSort,
    Function(int rowIndex)? onRowTap,
    Function(List<int> selectedRows)? onSelectionChanged,
    bool selectable = false,
    List<int>? selectedRows,
    Widget? emptyState,
    bool loading = false,
    int? numLoadingRows = 5,
  }) : super(key: key);
}

// Factory methods for common table patterns
class BlueprintTables {
  static Widget simple({
    required List<BlueprintTableColumn> columns,
    required List<Map<String, dynamic>> data,
    BlueprintTableSize size = BlueprintTableSize.standard,
    bool striped = true,
    bool bordered = false,
    Function(int rowIndex)? onRowTap,
  }) {
    return BlueprintTable(
      columns: columns,
      data: data,
      size: size,
      striped: striped,
      bordered: bordered,
      interactive: onRowTap != null,
      onRowTap: onRowTap,
    );
  }

  static Widget sortable({
    required List<BlueprintTableColumn> columns,
    required List<Map<String, dynamic>> data,
    BlueprintTableSort? defaultSort,
    BlueprintTableSize size = BlueprintTableSize.standard,
    bool striped = true,
    bool bordered = false,
  }) {
    final sortableColumns = columns.map((col) => BlueprintTableColumn(
      key: col.key,
      title: col.title,
      align: col.align,
      width: col.width,
      minWidth: col.minWidth,
      maxWidth: col.maxWidth,
      sortable: true,
      resizable: col.resizable,
      cellBuilder: col.cellBuilder,
      headerBuilder: col.headerBuilder,
    )).toList();

    return BlueprintTable(
      columns: sortableColumns,
      data: data,
      defaultSort: defaultSort,
      size: size,
      striped: striped,
      bordered: bordered,
    );
  }

  static Widget selectable({
    required List<BlueprintTableColumn> columns,
    required List<Map<String, dynamic>> data,
    required Function(List<int> selectedRows) onSelectionChanged,
    List<int>? selectedRows,
    BlueprintTableSize size = BlueprintTableSize.standard,
    bool striped = true,
    bool bordered = false,
  }) {
    return BlueprintTable(
      columns: columns,
      data: data,
      selectable: true,
      selectedRows: selectedRows,
      onSelectionChanged: onSelectionChanged,
      size: size,
      striped: striped,
      bordered: bordered,
    );
  }

  static Widget loading({
    required List<BlueprintTableColumn> columns,
    int numLoadingRows = 5,
    BlueprintTableSize size = BlueprintTableSize.standard,
    bool striped = true,
    bool bordered = false,
  }) {
    return BlueprintTable(
      columns: columns,
      data: const [],
      loading: true,
      numLoadingRows: numLoadingRows,
      size: size,
      striped: striped,
      bordered: bordered,
    );
  }

  static Widget withEmptyState({
    required List<BlueprintTableColumn> columns,
    required List<Map<String, dynamic>> data,
    required Widget emptyState,
    BlueprintTableSize size = BlueprintTableSize.standard,
    bool striped = true,
    bool bordered = false,
  }) {
    return BlueprintTable(
      columns: columns,
      data: data,
      emptyState: emptyState,
      size: size,
      striped: striped,
      bordered: bordered,
    );
  }
}