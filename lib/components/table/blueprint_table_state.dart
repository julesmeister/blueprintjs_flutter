import 'package:flutter/material.dart';
import 'blueprint_table_enums.dart';
import 'blueprint_table_models.dart';

/// State management logic for BlueprintTable
mixin BlueprintTableStateMixin<T extends StatefulWidget> on State<T> {
  BlueprintTableSort? currentSort;
  List<Map<String, dynamic>> sortedData = [];
  List<int> selectedRows = [];

  // Abstract getters that must be implemented by the widget
  List<Map<String, dynamic>> get data;
  BlueprintTableSort? get defaultSort;
  List<int>? get initialSelectedRows;
  Function(List<int> selectedRows)? get onSelectionChanged;

  void initializeTableState() {
    currentSort = defaultSort;
    selectedRows = initialSelectedRows ?? [];
    updateSortedData();
  }

  void updateTableState({
    List<Map<String, dynamic>>? newData,
    BlueprintTableSort? newDefaultSort,
    List<int>? newSelectedRows,
  }) {
    bool needsUpdate = false;
    
    if (newData != null && newData != data) {
      needsUpdate = true;
    }
    if (newDefaultSort != defaultSort) {
      needsUpdate = true;
    }
    if (newSelectedRows != initialSelectedRows) {
      selectedRows = newSelectedRows ?? [];
    }
    
    if (needsUpdate) {
      updateSortedData();
    }
  }

  void updateSortedData() {
    sortedData = List.from(data);
    if (currentSort != null) {
      sortedData.sort((a, b) {
        final aValue = a[currentSort!.columnKey];
        final bValue = b[currentSort!.columnKey];
        
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
        
        return currentSort!.direction == BlueprintSortDirection.ascending
            ? comparison
            : -comparison;
      });
    }
  }

  void onSort(String columnKey) {
    setState(() {
      if (currentSort?.columnKey == columnKey) {
        // Toggle direction
        currentSort = BlueprintTableSort(
          columnKey: columnKey,
          direction: currentSort!.direction == BlueprintSortDirection.ascending
              ? BlueprintSortDirection.descending
              : BlueprintSortDirection.ascending,
        );
      } else {
        // New column sort
        currentSort = BlueprintTableSort(
          columnKey: columnKey,
          direction: BlueprintSortDirection.ascending,
        );
      }
      updateSortedData();
    });
  }

  void onRowSelection(int rowIndex, bool selected) {
    setState(() {
      if (selected) {
        if (!selectedRows.contains(rowIndex)) {
          selectedRows.add(rowIndex);
        }
      } else {
        selectedRows.remove(rowIndex);
      }
    });
    onSelectionChanged?.call(selectedRows);
  }

  void onSelectAll(bool? selectAll) {
    setState(() {
      if (selectAll == true) {
        selectedRows = List.generate(sortedData.length, (index) => index);
      } else {
        selectedRows.clear();
      }
    });
    onSelectionChanged?.call(selectedRows);
  }
}