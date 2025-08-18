import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_table.dart';
import '../components/blueprint_button.dart';
import '../components/blueprint_icon.dart';
import '../components/blueprint_tag.dart';

class TableDemoPage extends StatefulWidget {
  const TableDemoPage({Key? key}) : super(key: key);

  @override
  State<TableDemoPage> createState() => _TableDemoPageState();
}

class _TableDemoPageState extends State<TableDemoPage> {
  List<int> _selectedRows = [];
  bool _isLoading = false;
  List<Map<String, dynamic>> _userData = [
    {
      'id': 1,
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'role': 'Developer',
      'status': 'Active',
      'joinDate': '2023-01-15',
      'salary': 75000,
      'department': 'Engineering',
    },
    {
      'id': 2,
      'name': 'Jane Smith',
      'email': 'jane.smith@example.com',
      'role': 'Designer',
      'status': 'Active',
      'joinDate': '2023-02-20',
      'salary': 70000,
      'department': 'Design',
    },
    {
      'id': 3,
      'name': 'Bob Johnson',
      'email': 'bob.johnson@example.com',
      'role': 'Manager',
      'status': 'Inactive',
      'joinDate': '2022-11-10',
      'salary': 85000,
      'department': 'Engineering',
    },
    {
      'id': 4,
      'name': 'Alice Brown',
      'email': 'alice.brown@example.com',
      'role': 'Developer',
      'status': 'Active',
      'joinDate': '2023-03-05',
      'salary': 72000,
      'department': 'Engineering',
    },
    {
      'id': 5,
      'name': 'Charlie Wilson',
      'email': 'charlie.wilson@example.com',
      'role': 'Designer',
      'status': 'Active',
      'joinDate': '2023-01-30',
      'salary': 68000,
      'department': 'Design',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blueprint Tables'),
        backgroundColor: BlueprintColors.intentPrimary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Basic Table', _buildBasicTable()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Sortable Table', _buildSortableTable()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Selectable Table', _buildSelectableTable()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Custom Cells', _buildCustomCellsTable()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Different Sizes', _buildSizesDemo()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Loading State', _buildLoadingDemo()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Empty State', _buildEmptyStateDemo()),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: BlueprintTheme.fontSizeLarge,
            fontWeight: FontWeight.w600,
            color: BlueprintColors.headingColor,
          ),
        ),
        const SizedBox(height: BlueprintTheme.gridSize),
        content,
      ],
    );
  }

  Widget _buildBasicTable() {
    return BlueprintTables.simple(
      columns: [
        const BlueprintTableColumn(
          key: 'name',
          title: 'Name',
          width: 150,
        ),
        const BlueprintTableColumn(
          key: 'email',
          title: 'Email',
          width: 200,
        ),
        const BlueprintTableColumn(
          key: 'role',
          title: 'Role',
          width: 120,
        ),
        const BlueprintTableColumn(
          key: 'department',
          title: 'Department',
          width: 120,
        ),
      ],
      data: _userData.take(3).toList(),
      striped: true,
      bordered: true,
      onRowTap: (index) => _showSnackBar('Clicked row $index'),
    );
  }

  Widget _buildSortableTable() {
    return BlueprintTables.sortable(
      columns: [
        const BlueprintTableColumn(
          key: 'name',
          title: 'Name',
        ),
        const BlueprintTableColumn(
          key: 'email',
          title: 'Email',
        ),
        const BlueprintTableColumn(
          key: 'salary',
          title: 'Salary',
          align: BlueprintColumnAlign.right,
        ),
        const BlueprintTableColumn(
          key: 'joinDate',
          title: 'Join Date',
          align: BlueprintColumnAlign.center,
        ),
      ],
      data: _userData,
      defaultSort: const BlueprintTableSort(
        columnKey: 'name',
        direction: BlueprintSortDirection.ascending,
      ),
      bordered: true,
    );
  }

  Widget _buildSelectableTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_selectedRows.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: BlueprintTheme.gridSize),
            child: Row(
              children: [
                Text('${_selectedRows.length} row(s) selected'),
                const SizedBox(width: BlueprintTheme.gridSize),
                BlueprintButton(
                  text: 'Clear Selection',
                  variant: BlueprintButtonVariant.minimal,
                  onPressed: () => setState(() => _selectedRows.clear()),
                ),
              ],
            ),
          ),
        BlueprintTables.selectable(
          columns: [
            const BlueprintTableColumn(
              key: 'name',
              title: 'Name',
            ),
            const BlueprintTableColumn(
              key: 'role',
              title: 'Role',
            ),
            const BlueprintTableColumn(
              key: 'status',
              title: 'Status',
            ),
            const BlueprintTableColumn(
              key: 'department',
              title: 'Department',
            ),
          ],
          data: _userData,
          selectedRows: _selectedRows,
          onSelectionChanged: (selectedRows) {
            setState(() => _selectedRows = selectedRows);
          },
          bordered: true,
        ),
      ],
    );
  }

  Widget _buildCustomCellsTable() {
    return BlueprintTables.simple(
      columns: [
        const BlueprintTableColumn(
          key: 'name',
          title: 'Name',
          width: 150,
        ),
        BlueprintTableColumn(
          key: 'status',
          title: 'Status',
          width: 100,
          cellBuilder: (value, rowIndex) {
            final isActive = value == 'Active';
            return BlueprintTags.simple(
              text: value.toString(),
              intent: isActive ? BlueprintIntent.success : BlueprintIntent.warning,
              size: BlueprintTagSize.small,
            );
          },
        ),
        BlueprintTableColumn(
          key: 'salary',
          title: 'Salary',
          width: 120,
          align: BlueprintColumnAlign.right,
          cellBuilder: (value, rowIndex) {
            return Text(
              '\$${(value as num).toStringAsFixed(0)}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: BlueprintColors.intentSuccess,
              ),
            );
          },
        ),
        BlueprintTableColumn(
          key: 'actions',
          title: 'Actions',
          width: 120,
          cellBuilder: (value, rowIndex) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: BlueprintIcons.edit(),
                  onPressed: () => _showSnackBar('Edit row $rowIndex'),
                  iconSize: 16,
                ),
                IconButton(
                  icon: BlueprintIcons.delete(),
                  onPressed: () => _showSnackBar('Delete row $rowIndex'),
                  iconSize: 16,
                ),
              ],
            );
          },
        ),
      ],
      data: _userData,
      bordered: true,
    );
  }

  Widget _buildSizesDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Compact Size:', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        BlueprintTables.simple(
          columns: [
            const BlueprintTableColumn(key: 'name', title: 'Name'),
            const BlueprintTableColumn(key: 'role', title: 'Role'),
            const BlueprintTableColumn(key: 'status', title: 'Status'),
          ],
          data: _userData.take(2).toList(),
          size: BlueprintTableSize.compact,
          bordered: true,
        ),
        const SizedBox(height: BlueprintTheme.gridSize * 2),
        const Text('Large Size:', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        BlueprintTables.simple(
          columns: [
            const BlueprintTableColumn(key: 'name', title: 'Name'),
            const BlueprintTableColumn(key: 'role', title: 'Role'),
            const BlueprintTableColumn(key: 'status', title: 'Status'),
          ],
          data: _userData.take(2).toList(),
          size: BlueprintTableSize.large,
          bordered: true,
        ),
      ],
    );
  }

  Widget _buildLoadingDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            BlueprintButton(
              text: _isLoading ? 'Stop Loading' : 'Show Loading',
              variant: BlueprintButtonVariant.outlined,
              icon: _isLoading ? Icons.stop : Icons.refresh,
              onPressed: () => setState(() => _isLoading = !_isLoading),
            ),
          ],
        ),
        const SizedBox(height: BlueprintTheme.gridSize),
        _isLoading
            ? BlueprintTables.loading(
                columns: [
                  const BlueprintTableColumn(key: 'name', title: 'Name'),
                  const BlueprintTableColumn(key: 'email', title: 'Email'),
                  const BlueprintTableColumn(key: 'role', title: 'Role'),
                  const BlueprintTableColumn(key: 'status', title: 'Status'),
                ],
                numLoadingRows: 3,
                bordered: true,
              )
            : BlueprintTables.simple(
                columns: [
                  const BlueprintTableColumn(key: 'name', title: 'Name'),
                  const BlueprintTableColumn(key: 'email', title: 'Email'),
                  const BlueprintTableColumn(key: 'role', title: 'Role'),
                  const BlueprintTableColumn(key: 'status', title: 'Status'),
                ],
                data: _userData.take(3).toList(),
                bordered: true,
              ),
      ],
    );
  }

  Widget _buildEmptyStateDemo() {
    return BlueprintTables.withEmptyState(
      columns: [
        const BlueprintTableColumn(key: 'name', title: 'Name'),
        const BlueprintTableColumn(key: 'email', title: 'Email'),
        const BlueprintTableColumn(key: 'role', title: 'Role'),
      ],
      data: const [], // Empty data
      bordered: true,
      emptyState: Container(
        padding: const EdgeInsets.all(BlueprintTheme.gridSize * 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlueprintIcons.large(
              icon: Icons.table_rows,
              color: BlueprintColors.textColorMuted,
            ),
            const SizedBox(height: BlueprintTheme.gridSize),
            const Text(
              'No Data Available',
              style: TextStyle(
                fontSize: BlueprintTheme.fontSizeLarge,
                fontWeight: FontWeight.w600,
                color: BlueprintColors.textColorMuted,
              ),
            ),
            const SizedBox(height: BlueprintTheme.gridSize * 0.5),
            const Text(
              'There are no items to display in this table.',
              style: TextStyle(
                color: BlueprintColors.textColorMuted,
              ),
            ),
            const SizedBox(height: BlueprintTheme.gridSize * 2),
            BlueprintButton(
              text: 'Add Item',
              intent: BlueprintIntent.primary,
              icon: Icons.add,
              onPressed: () => _showSnackBar('Add item clicked'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: BlueprintColors.intentPrimary,
      ),
    );
  }
}