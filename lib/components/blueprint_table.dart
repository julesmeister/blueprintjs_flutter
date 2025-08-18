import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import 'blueprint_button.dart';
import 'blueprint_icon.dart';
import 'blueprint_checkbox.dart';
import 'table/blueprint_table_enums.dart';
import 'table/blueprint_table_models.dart';
import 'table/blueprint_table_builders.dart';
import 'table/blueprint_table_loading.dart';

export 'table/blueprint_table_enums.dart';
export 'table/blueprint_table_models.dart';

class BlueprintTable extends StatefulWidget {
  final List<BlueprintTableColumn> columns;
  final List<Map<String, dynamic>> data;
  final BlueprintTableSize size;
  final bool striped;
  final bool bordered;
  final bool interactive;
  final bool condensed;
  final bool enableColumnReordering;
  final BlueprintTableSort? defaultSort;
  final Function(int rowIndex)? onRowTap;
  final Function(List<int> selectedRows)? onSelectionChanged;
  final bool selectable;
  final List<int>? selectedRows;
  final Widget? emptyState;
  final bool loading;
  final int? numLoadingRows;

  const BlueprintTable({
    Key? key,
    required this.columns,
    required this.data,
    this.size = BlueprintTableSize.standard,
    this.striped = true,
    this.bordered = false,
    this.interactive = false,
    this.condensed = false,
    this.enableColumnReordering = false,
    this.defaultSort,
    this.onRowTap,
    this.onSelectionChanged,
    this.selectable = false,
    this.selectedRows,
    this.emptyState,
    this.loading = false,
    this.numLoadingRows = 5,
  }) : super(key: key);

  @override
  State<BlueprintTable> createState() => _BlueprintTableState();
}

class _BlueprintTableState extends State<BlueprintTable> {
  BlueprintTableSort? _currentSort;
  List<Map<String, dynamic>> _sortedData = [];
  List<int> _selectedRows = [];

  @override
  void initState() {
    super.initState();
    _currentSort = widget.defaultSort;
    _selectedRows = widget.selectedRows ?? [];
    _updateSortedData();
  }

  @override
  void didUpdateWidget(BlueprintTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data ||
        widget.defaultSort != oldWidget.defaultSort) {
      _updateSortedData();
    }
    if (widget.selectedRows != oldWidget.selectedRows) {
      _selectedRows = widget.selectedRows ?? [];
    }
  }

  void _updateSortedData() {
    _sortedData = List.from(widget.data);
    if (_currentSort != null) {
      _sortedData.sort((a, b) {
        final aValue = a[_currentSort!.columnKey];
        final bValue = b[_currentSort!.columnKey];
        
        int comparison = 0;
        if (aValue == null && bValue == null) {
          comparison = 0;
        } else if (aValue == null) {
          comparison = -1;
        } else if (bValue == null) {
          comparison = 1;
        } else if (aValue is num && bValue is num) {
          comparison = aValue.compareTo(bValue);
        } else {
          comparison = aValue.toString().compareTo(bValue.toString());
        }
        
        return _currentSort!.direction == BlueprintSortDirection.ascending
            ? comparison
            : -comparison;
      });
    }
  }

  void _onSort(String columnKey) {
    setState(() {
      if (_currentSort?.columnKey == columnKey) {
        // Toggle direction
        _currentSort = BlueprintTableSort(
          columnKey: columnKey,
          direction: _currentSort!.direction == BlueprintSortDirection.ascending
              ? BlueprintSortDirection.descending
              : BlueprintSortDirection.ascending,
        );
      } else {
        // New column sort
        _currentSort = BlueprintTableSort(
          columnKey: columnKey,
          direction: BlueprintSortDirection.ascending,
        );
      }
      _updateSortedData();
    });
  }

  void _onRowSelection(int rowIndex, bool selected) {
    setState(() {
      if (selected) {
        if (!_selectedRows.contains(rowIndex)) {
          _selectedRows.add(rowIndex);
        }
      } else {
        _selectedRows.remove(rowIndex);
      }
    });
    widget.onSelectionChanged?.call(_selectedRows);
  }

  void _onSelectAll(bool? selectAll) {
    setState(() {
      if (selectAll == true) {
        _selectedRows = List.generate(_sortedData.length, (index) => index);
      } else {
        _selectedRows.clear();
      }
    });
    widget.onSelectionChanged?.call(_selectedRows);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.loading) {
      return BlueprintTableLoadingBuilder.buildLoadingTable(
        columns: widget.columns,
        selectable: widget.selectable,
        striped: widget.striped,
        bordered: widget.bordered,
        numLoadingRows: widget.numLoadingRows ?? 5,
        size: widget.size,
      );
    }

    if (_sortedData.isEmpty && widget.emptyState != null) {
      return widget.emptyState!;
    }

    return Container(
      decoration: BoxDecoration(
        border: widget.bordered ? Border.all(
          color: BlueprintColors.lightGray2, // Blueprint: $cell-border-color
          width: 1,
        ) : null,
        borderRadius: widget.bordered ? BorderRadius.circular(BlueprintTheme.borderRadius) : null,
      ),
      margin: const EdgeInsets.only(bottom: BlueprintTheme.gridSize), // Add bottom margin
      child: ClipRRect(
        borderRadius: widget.bordered ? BorderRadius.circular(BlueprintTheme.borderRadius) : BorderRadius.zero,
        child: Table(
          columnWidths: BlueprintTableBuilders.buildColumnWidths(widget.columns, widget.selectable),
          children: [
            BlueprintTableBuilders.buildHeaderRow(
              columns: widget.columns,
              selectable: widget.selectable,
              selectedRows: _selectedRows,
              sortedData: _sortedData,
              currentSort: _currentSort,
              onSelectAll: _onSelectAll,
              onSort: _onSort,
              size: widget.size,
            ),
            ...BlueprintTableBuilders.buildDataRows(
              sortedData: _sortedData,
              columns: widget.columns,
              selectable: widget.selectable,
              selectedRows: _selectedRows,
              striped: widget.striped,
              interactive: widget.interactive,
              onRowSelection: _onRowSelection,
              onRowTap: widget.onRowTap,
              size: widget.size,
            ),
          ],
        ),
      ),
    );
  }
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