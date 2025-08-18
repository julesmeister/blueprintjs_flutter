import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_menu.dart';
import '../components/demo_page_scaffold.dart';

class MenuDemoPage extends StatefulWidget {
  const MenuDemoPage({Key? key}) : super(key: key);

  @override
  State<MenuDemoPage> createState() => _MenuDemoPageState();
}

class _MenuDemoPageState extends State<MenuDemoPage> {
  String selectedAction = 'No action selected';
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      title: 'Blueprint Menu',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            _buildSection('Basic Menu', _buildBasicMenu()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Menu with Intent Colors', _buildIntentMenu()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Menu with Dividers', _buildDividedMenu()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Interactive Menu', _buildInteractiveMenu()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Large Menu', _buildLargeMenu()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Menu with Icons', _buildIconMenu()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Selected Action', _buildActionDisplay()),
        ],
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

  Widget _buildBasicMenu() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlueprintMenus.simple(
          width: 200,
          items: [
            BlueprintMenuItem(
              text: 'New File',
              onTap: () => _selectAction('New File'),
            ),
            BlueprintMenuItem(
              text: 'Open File',
              onTap: () => _selectAction('Open File'),
            ),
            BlueprintMenuItem(
              text: 'Save',
              onTap: () => _selectAction('Save'),
            ),
            BlueprintMenuItem(
              text: 'Save As...',
              onTap: () => _selectAction('Save As...'),
            ),
          ],
        ),
        const SizedBox(width: 20),
        BlueprintMenus.simple(
          width: 200,
          items: [
            BlueprintMenuItem(
              text: 'Copy',
              onTap: () => _selectAction('Copy'),
            ),
            BlueprintMenuItem(
              text: 'Paste',
              onTap: () => _selectAction('Paste'),
            ),
            const BlueprintMenuItem(
              text: 'Cut',
              disabled: true,
            ),
            BlueprintMenuItem(
              text: 'Select All',
              onTap: () => _selectAction('Select All'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIntentMenu() {
    return BlueprintMenus.simple(
      width: 250,
      items: [
        BlueprintMenuItem(
          text: 'Primary Action',
          intent: BlueprintIntent.primary,
          onTap: () => _selectAction('Primary Action'),
        ),
        BlueprintMenuItem(
          text: 'Success Action',
          intent: BlueprintIntent.success,
          onTap: () => _selectAction('Success Action'),
        ),
        BlueprintMenuItem(
          text: 'Warning Action',
          intent: BlueprintIntent.warning,
          onTap: () => _selectAction('Warning Action'),
        ),
        BlueprintMenuItem(
          text: 'Danger Action',
          intent: BlueprintIntent.danger,
          onTap: () => _selectAction('Danger Action'),
        ),
      ],
    );
  }

  Widget _buildDividedMenu() {
    return BlueprintMenus.withDividers(
      width: 220,
      items: [
        const BlueprintMenuDivider(title: 'FILE'),
        BlueprintMenuItem(
          text: 'New Document',
          onTap: () => _selectAction('New Document'),
        ),
        BlueprintMenuItem(
          text: 'Open Recent',
          onTap: () => _selectAction('Open Recent'),
        ),
        const BlueprintMenuDivider(),
        const BlueprintMenuDivider(title: 'EDIT'),
        BlueprintMenuItem(
          text: 'Undo',
          onTap: () => _selectAction('Undo'),
        ),
        BlueprintMenuItem(
          text: 'Redo',
          onTap: () => _selectAction('Redo'),
        ),
        const BlueprintMenuDivider(),
        BlueprintMenuItem(
          text: 'Preferences',
          onTap: () => _selectAction('Preferences'),
        ),
      ],
    );
  }

  Widget _buildInteractiveMenu() {
    return BlueprintMenus.simple(
      width: 250,
      items: List.generate(5, (index) {
        return BlueprintMenuItem(
          text: 'Option ${index + 1}',
          selected: selectedIndex == index,
          onTap: () => _selectOption(index),
        );
      }),
    );
  }

  Widget _buildLargeMenu() {
    return BlueprintMenus.large(
      width: 280,
      items: [
        BlueprintMenuItem(
          text: 'Large Menu Item 1',
          onTap: () => _selectAction('Large Menu Item 1'),
        ),
        BlueprintMenuItem(
          text: 'Large Menu Item 2',
          onTap: () => _selectAction('Large Menu Item 2'),
        ),
        BlueprintMenuItem(
          text: 'Large Menu Item 3',
          onTap: () => _selectAction('Large Menu Item 3'),
        ),
      ],
    );
  }

  Widget _buildIconMenu() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlueprintMenus.simple(
          width: 200,
          items: [
            BlueprintMenuItem(
              text: 'Home',
              icon: Icons.home,
              onTap: () => _selectAction('Home'),
            ),
            BlueprintMenuItem(
              text: 'Settings',
              icon: Icons.settings,
              onTap: () => _selectAction('Settings'),
            ),
            BlueprintMenuItem(
              text: 'Profile',
              icon: Icons.person,
              onTap: () => _selectAction('Profile'),
            ),
            BlueprintMenuItem(
              text: 'Logout',
              icon: Icons.logout,
              intent: BlueprintIntent.danger,
              onTap: () => _selectAction('Logout'),
            ),
          ],
        ),
        const SizedBox(width: 20),
        BlueprintMenus.simple(
          width: 220,
          items: [
            BlueprintMenuItem(
              text: 'Create',
              icon: Icons.add,
              endIcon: Icons.keyboard_arrow_right,
              onTap: () => _selectAction('Create'),
            ),
            BlueprintMenuItem(
              text: 'Edit',
              icon: Icons.edit,
              endIcon: Icons.keyboard_arrow_right,
              onTap: () => _selectAction('Edit'),
            ),
            BlueprintMenuItem(
              text: 'Delete',
              icon: Icons.delete,
              intent: BlueprintIntent.danger,
              onTap: () => _selectAction('Delete'),
            ),
            BlueprintMenuItem(
              text: 'Archive',
              icon: Icons.archive,
              trailing: const Icon(Icons.star, size: 16),
              onTap: () => _selectAction('Archive'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionDisplay() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last Selected Action:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: BlueprintTheme.fontSize,
                color: BlueprintColors.gray2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              selectedAction,
              style: const TextStyle(
                fontSize: BlueprintTheme.fontSizeLarge,
                fontWeight: FontWeight.w600,
                color: BlueprintColors.intentPrimary,
              ),
            ),
            if (selectedIndex >= 0) ...[
              const SizedBox(height: 8),
              Text(
                'Selected Option Index: $selectedIndex',
                style: TextStyle(
                  fontSize: BlueprintTheme.fontSizeSmall,
                  color: BlueprintColors.gray2,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _selectAction(String action) {
    setState(() {
      selectedAction = action;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected: $action'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _selectOption(int index) {
    setState(() {
      selectedIndex = index;
      selectedAction = 'Option ${index + 1}';
    });
  }
}