import 'package:flutter/material.dart';
import '../../theme/blueprint_theme.dart';
import '../../theme/blueprint_colors.dart';
import 'blueprint_table_enums.dart';
import 'blueprint_table_models.dart';
import 'blueprint_table_builders.dart';

/// Loading state builder for BlueprintTable
class BlueprintTableLoadingBuilder {
  
  static Widget buildLoadingTable({
    required List<BlueprintTableColumn> columns,
    required bool selectable,
    required bool striped,
    required bool bordered,
    required int numLoadingRows,
    required BlueprintTableSize size,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: bordered ? Border.all(
          color: BlueprintColors.lightGray2, // Blueprint: $cell-border-color
          width: 1,
        ) : null,
        borderRadius: bordered ? BorderRadius.circular(BlueprintTheme.borderRadius) : null,
      ),
      margin: const EdgeInsets.only(bottom: BlueprintTheme.gridSize), // Add bottom margin
      child: ClipRRect(
        borderRadius: bordered ? BorderRadius.circular(BlueprintTheme.borderRadius) : BorderRadius.zero,
        child: Table(
          columnWidths: BlueprintTableBuilders.buildColumnWidths(columns, selectable),
          children: [
            _buildLoadingHeaderRow(columns, selectable, size),
            ..._buildLoadingDataRows(columns, selectable, striped, numLoadingRows, size),
          ],
        ),
      ),
    );
  }

  static TableRow _buildLoadingHeaderRow(
    List<BlueprintTableColumn> columns,
    bool selectable,
    BlueprintTableSize size,
  ) {
    List<Widget> headerCells = [];
    
    if (selectable) {
      headerCells.add(Container(
        padding: EdgeInsets.symmetric(
          horizontal: _getCellPadding(),
          vertical: 0,
        ),
        height: _getHeaderHeight(),
        child: const SizedBox(width: 16, height: 16),
      ));
    }
    
    for (final column in columns) {
      headerCells.add(Container(
        padding: EdgeInsets.symmetric(
          horizontal: _getCellPadding(),
          vertical: 0,
        ),
        height: _getHeaderHeight(),
        alignment: _getAlignment(column.align),
        child: Text(
          column.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: _getHeaderFontSize(),
            color: BlueprintColors.textColor,
            height: 1.28581, // Blueprint: $pt-line-height
          ),
          textAlign: _getTextAlign(column.align),
        ),
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

  static List<TableRow> _buildLoadingDataRows(
    List<BlueprintTableColumn> columns,
    bool selectable,
    bool striped,
    int numLoadingRows,
    BlueprintTableSize size,
  ) {
    List<TableRow> loadingRows = [];
    
    for (int i = 0; i < numLoadingRows; i++) {
      List<Widget> cells = [];
      
      if (selectable) {
        cells.add(Container(
          padding: EdgeInsets.symmetric(
            horizontal: _getCellPadding(),
            vertical: 0,
          ),
          height: _getCellHeight(size),
          child: const SizedBox(width: 16, height: 16),
        ));
      }
      
      for (final column in columns) {
        cells.add(Container(
          padding: EdgeInsets.symmetric(
            horizontal: _getCellPadding(),
            vertical: 0,
          ),
          height: _getCellHeight(size),
          alignment: _getAlignment(column.align),
          child: Container(
            height: _getFontSize(size) + 2,
            width: double.infinity,
            decoration: BoxDecoration(
              color: BlueprintColors.lightGray3,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ));
      }
      
      loadingRows.add(TableRow(
        decoration: BoxDecoration(
          color: striped && i % 2 != 0
              ? BlueprintColors.lightGray5
              : Colors.white,
          border: Border(
            bottom: BorderSide(
              color: BlueprintColors.lightGray2, // Blueprint: $cell-border-color
              width: 1,
            ),
          ),
        ),
        children: cells,
      ));
    }
    
    return loadingRows;
  }

  // Helper methods
  static double _getCellPadding() {
    return BlueprintTheme.gridSize.toDouble();
  }

  static double _getCellHeight(BlueprintTableSize size) {
    switch (size) {
      case BlueprintTableSize.compact:
        return BlueprintTheme.gridSize * 2.0;
      case BlueprintTableSize.standard:
        return BlueprintTheme.gridSize * 2.0;
      case BlueprintTableSize.large:
        return BlueprintTheme.gridSize * 3.0;
    }
  }

  static double _getHeaderHeight() {
    return BlueprintTheme.gridSize * 3.0;
  }

  static double _getFontSize(BlueprintTableSize size) {
    switch (size) {
      case BlueprintTableSize.compact:
        return BlueprintTheme.fontSizeSmall;
      case BlueprintTableSize.standard:
        return BlueprintTheme.fontSizeSmall;
      case BlueprintTableSize.large:
        return BlueprintTheme.fontSize;
    }
  }

  static double _getHeaderFontSize() {
    return BlueprintTheme.fontSize;
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