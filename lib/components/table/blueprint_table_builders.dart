import 'package:flutter/material.dart';
import '../../theme/blueprint_theme.dart';
import '../../theme/blueprint_colors.dart';
import '../blueprint_checkbox.dart';
import '../blueprint_button.dart';
import 'blueprint_table_enums.dart';
import 'blueprint_table_models.dart';

/// UI builders for BlueprintTable components
class BlueprintTableBuilders {
  
  static Map<int, TableColumnWidth> buildColumnWidths(
    List<BlueprintTableColumn> columns,
    bool selectable,
  ) {
    final Map<int, TableColumnWidth> columnWidths = {};
    
    for (int i = 0; i < columns.length; i++) {
      final column = columns[i];
      if (column.width != null) {
        columnWidths[i] = FixedColumnWidth(column.width!);
      } else {
        columnWidths[i] = const FlexColumnWidth();
      }
    }
    
    if (selectable) {
      columnWidths[-1] = const FixedColumnWidth(40.0);
    }
    
    return columnWidths;
  }

  static TableRow buildHeaderRow({
    required List<BlueprintTableColumn> columns,
    required bool selectable,
    required List<int> selectedRows,
    required List<Map<String, dynamic>> sortedData,
    required BlueprintTableSort? currentSort,
    required Function(bool?) onSelectAll,
    required Function(String) onSort,
    required BlueprintTableSize size,
  }) {
    List<Widget> headerCells = [];
    
    if (selectable) {
      headerCells.add(buildSelectAllCell(
        selectedRows: selectedRows,
        sortedData: sortedData,
        onSelectAll: onSelectAll,
        size: size,
      ));
    }
    
    for (final column in columns) {
      headerCells.add(buildHeaderCell(
        column: column,
        currentSort: currentSort,
        onSort: onSort,
        size: size,
      ));
    }
    
    return TableRow(
      decoration: BoxDecoration(
        color: BlueprintColors.lightGray5, // Blueprint: $table-background-color
        border: Border(
          bottom: BorderSide(
            color: BlueprintColors.lightGray2, // Blueprint: $pt-divider-black
            width: 1,
          ),
        ),
      ),
      children: headerCells,
    );
  }

  static Widget buildSelectAllCell({
    required List<int> selectedRows,
    required List<Map<String, dynamic>> sortedData,
    required Function(bool?) onSelectAll,
    required BlueprintTableSize size,
  }) {
    final isAllSelected = selectedRows.length == sortedData.length && sortedData.isNotEmpty;
    final isIndeterminate = selectedRows.isNotEmpty && selectedRows.length < sortedData.length;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _getCellPadding(),
        vertical: 0,
      ),
      height: _getHeaderHeight(),
      alignment: Alignment.center,
      child: BlueprintCheckbox(
        checked: isIndeterminate ? null : isAllSelected,
        indeterminate: isIndeterminate,
        onChanged: onSelectAll,
        intent: BlueprintIntent.primary,
      ),
    );
  }

  static Widget buildHeaderCell({
    required BlueprintTableColumn column,
    required BlueprintTableSort? currentSort,
    required Function(String) onSort,
    required BlueprintTableSize size,
  }) {
    final sortDirection = currentSort?.columnKey == column.key ? currentSort!.direction : null;
    
    if (column.headerBuilder != null) {
      return column.headerBuilder!(
        column.title,
        sortDirection,
        column.sortable ? () => onSort(column.key) : null,
      );
    }
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _getCellPadding(),
        vertical: 0,
      ),
      height: _getHeaderHeight(),
      alignment: _getAlignment(column.align),
      child: column.sortable
          ? InkWell(
              onTap: () => onSort(column.key),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    column.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: _getHeaderFontSize(),
                      color: BlueprintColors.textColor,
                      height: 1.28581, // Blueprint: $pt-line-height
                    ),
                    textAlign: _getTextAlign(column.align),
                  ),
                  const SizedBox(width: 4),
                  if (sortDirection != null)
                    Icon(
                      sortDirection == BlueprintSortDirection.ascending
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 16, // Blueprint: standard icon size
                      color: BlueprintColors.intentPrimary,
                    )
                  else
                    Icon(
                      Icons.unfold_more,
                      size: 16, // Blueprint: standard icon size
                      color: BlueprintColors.textColorMuted,
                    ),
                ],
              ),
            )
          : Text(
              column.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: _getHeaderFontSize(),
                color: BlueprintColors.textColor,
                height: 1.28581, // Blueprint: $pt-line-height
              ),
              textAlign: _getTextAlign(column.align),
            ),
    );
  }

  static List<TableRow> buildDataRows({
    required List<Map<String, dynamic>> sortedData,
    required List<BlueprintTableColumn> columns,
    required bool selectable,
    required List<int> selectedRows,
    required bool striped,
    required bool interactive,
    required Function(int, bool) onRowSelection,
    required Function(int)? onRowTap,
    required BlueprintTableSize size,
  }) {
    return sortedData.asMap().entries.map((entry) {
      final index = entry.key;
      final row = entry.value;
      final isSelected = selectedRows.contains(index);
      final isEven = index % 2 == 0;
      
      List<Widget> cells = [];
      
      if (selectable) {
        cells.add(buildSelectCell(
          rowIndex: index,
          isSelected: isSelected,
          onRowSelection: onRowSelection,
          size: size,
        ));
      }
      
      for (final column in columns) {
        cells.add(buildDataCell(
          column: column,
          row: row,
          rowIndex: index,
          interactive: interactive,
          onRowTap: onRowTap,
          size: size,
        ));
      }
      
      return TableRow(
        decoration: BoxDecoration(
          color: isSelected
              ? BlueprintColors.intentPrimary.withOpacity(0.1) // Blueprint: selected state
              : (striped && !isEven)
                  ? BlueprintColors.lightGray5 // Blueprint: $table-background-color
                  : Colors.white, // Blueprint: $cell-background-color
          border: Border(
            bottom: BorderSide(
              color: BlueprintColors.lightGray2, // Blueprint: $cell-border-color
              width: 1,
            ),
          ),
        ),
        children: cells,
      );
    }).toList();
  }

  static Widget buildSelectCell({
    required int rowIndex,
    required bool isSelected,
    required Function(int, bool) onRowSelection,
    required BlueprintTableSize size,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _getCellPadding(),
        vertical: 2.0, // Add small vertical padding for better text positioning
      ),
      height: _getCellHeight(size),
      alignment: Alignment.center,
      child: BlueprintCheckbox(
        checked: isSelected,
        onChanged: (selected) => onRowSelection(rowIndex, selected ?? false),
        intent: BlueprintIntent.primary,
      ),
    );
  }

  static Widget buildDataCell({
    required BlueprintTableColumn column,
    required Map<String, dynamic> row,
    required int rowIndex,
    required bool interactive,
    required Function(int)? onRowTap,
    required BlueprintTableSize size,
  }) {
    final value = row[column.key];
    
    Widget cellContent;
    if (column.cellBuilder != null) {
      cellContent = column.cellBuilder!(value, rowIndex);
    } else {
      cellContent = Text(
        value?.toString() ?? '',
        style: TextStyle(
          fontSize: _getFontSize(size),
          color: BlueprintColors.textColor,
          height: 1.28581, // Blueprint: $pt-line-height for proper vertical centering
        ),
        textAlign: _getTextAlign(column.align),
      );
    }
    
    return InkWell(
      onTap: interactive && onRowTap != null
          ? () => onRowTap(rowIndex)
          : null,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _getCellPadding(),
          vertical: 2.0, // Add small vertical padding for better text positioning
        ),
        height: _getCellHeight(size),
        alignment: _getAlignment(column.align),
        child: cellContent,
      ),
    );
  }

  // Helper methods
  static double _getCellPadding() {
    // Blueprint.js uses $pt-grid-size (10px) for horizontal padding
    return BlueprintTheme.gridSize.toDouble();
  }

  static double _getCellHeight(BlueprintTableSize size) {
    switch (size) {
      case BlueprintTableSize.compact:
        return BlueprintTheme.gridSize * 2.0; // Blueprint: $cell-height: $pt-grid-size * 2 (20px)
      case BlueprintTableSize.standard:
        return BlueprintTheme.gridSize * 2.0; // Blueprint: $cell-height: $pt-grid-size * 2 (20px)
      case BlueprintTableSize.large:
        return BlueprintTheme.gridSize * 3.0; // Blueprint: $large-cell-height: $pt-grid-size * 3 (30px)
    }
  }

  static double _getHeaderHeight() {
    return BlueprintTheme.gridSize * 3.0; // Blueprint: $column-header-min-height: $pt-grid-size * 3
  }

  static double _getFontSize(BlueprintTableSize size) {
    switch (size) {
      case BlueprintTableSize.compact:
        return BlueprintTheme.fontSizeSmall; // Blueprint: $pt-font-size-small (12px)
      case BlueprintTableSize.standard:
        return BlueprintTheme.fontSizeSmall; // Blueprint: $pt-font-size-small (12px) for cells
      case BlueprintTableSize.large:
        return BlueprintTheme.fontSize; // Blueprint: $pt-font-size (14px) for large cells
    }
  }

  static double _getHeaderFontSize() {
    // Blueprint headers use standard font size
    return BlueprintTheme.fontSize; // Blueprint: $pt-font-size (14px)
  }

  static Alignment _getAlignment(BlueprintColumnAlign align) {
    switch (align) {
      case BlueprintColumnAlign.left:
        return Alignment.centerLeft;
      case BlueprintColumnAlign.center:
        return Alignment.center;
      case BlueprintColumnAlign.right:
        return Alignment.centerRight;
    }
  }

  static TextAlign _getTextAlign(BlueprintColumnAlign align) {
    switch (align) {
      case BlueprintColumnAlign.left:
        return TextAlign.left;
      case BlueprintColumnAlign.center:
        return TextAlign.center;
      case BlueprintColumnAlign.right:
        return TextAlign.right;
    }
  }
}