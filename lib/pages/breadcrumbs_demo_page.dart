import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_breadcrumbs.dart';

class BreadcrumbsDemoPage extends StatefulWidget {
  const BreadcrumbsDemoPage({Key? key}) : super(key: key);

  @override
  State<BreadcrumbsDemoPage> createState() => _BreadcrumbsDemoPageState();
}

class _BreadcrumbsDemoPageState extends State<BreadcrumbsDemoPage> {
  String currentPath = 'Home > Projects > Design System > Components';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blueprint Breadcrumbs'),
        backgroundColor: BlueprintColors.intentPrimary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Basic Breadcrumbs', _buildBasicBreadcrumbs()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('With Icons', _buildIconBreadcrumbs()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Interactive Navigation', _buildInteractiveBreadcrumbs()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Custom Separators', _buildCustomSeparatorBreadcrumbs()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Minimal Style', _buildMinimalBreadcrumbs()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Current Path', _buildCurrentPathDisplay()),
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

  Widget _buildBasicBreadcrumbs() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlueprintBreadcrumbsFactory.simple(
              items: [
                const BlueprintBreadcrumbItem(text: 'Home'),
                const BlueprintBreadcrumbItem(text: 'Users'),
                const BlueprintBreadcrumbItem(text: 'John Doe', isCurrent: true),
              ],
            ),
            const SizedBox(height: 16),
            BlueprintBreadcrumbsFactory.simple(
              items: [
                const BlueprintBreadcrumbItem(text: 'Root'),
                const BlueprintBreadcrumbItem(text: 'Documents'),
                const BlueprintBreadcrumbItem(text: 'Projects'),
                const BlueprintBreadcrumbItem(text: 'Flutter App', isCurrent: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconBreadcrumbs() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlueprintBreadcrumbsFactory.simple(
              items: [
                const BlueprintBreadcrumbItem(
                  text: 'Home',
                  icon: Icons.home,
                ),
                const BlueprintBreadcrumbItem(
                  text: 'Settings',
                  icon: Icons.settings,
                ),
                const BlueprintBreadcrumbItem(
                  text: 'Profile',
                  icon: Icons.person,
                  isCurrent: true,
                ),
              ],
            ),
            const SizedBox(height: 16),
            BlueprintBreadcrumbsFactory.simple(
              items: [
                const BlueprintBreadcrumbItem(
                  text: 'Dashboard',
                  icon: Icons.dashboard,
                ),
                const BlueprintBreadcrumbItem(
                  text: 'Analytics',
                  icon: Icons.analytics,
                ),
                const BlueprintBreadcrumbItem(
                  text: 'Reports',
                  icon: Icons.assessment,
                  isCurrent: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveBreadcrumbs() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlueprintBreadcrumbsFactory.simple(
              items: [
                BlueprintBreadcrumbItem(
                  text: 'Home',
                  icon: Icons.home,
                  onTap: () => _navigateTo('Home'),
                ),
                BlueprintBreadcrumbItem(
                  text: 'Projects',
                  icon: Icons.folder,
                  onTap: () => _navigateTo('Home > Projects'),
                ),
                BlueprintBreadcrumbItem(
                  text: 'Design System',
                  onTap: () => _navigateTo('Home > Projects > Design System'),
                ),
                const BlueprintBreadcrumbItem(
                  text: 'Components',
                  isCurrent: true,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Click on breadcrumbs to navigate',
              style: TextStyle(
                color: BlueprintColors.gray2,
                fontSize: BlueprintTheme.fontSizeSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomSeparatorBreadcrumbs() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlueprintBreadcrumbsFactory.withSeparator(
              items: [
                const BlueprintBreadcrumbItem(text: 'Root'),
                const BlueprintBreadcrumbItem(text: 'usr'),
                const BlueprintBreadcrumbItem(text: 'local'),
                const BlueprintBreadcrumbItem(text: 'bin', isCurrent: true),
              ],
              separator: const Text(' / ', style: TextStyle(color: BlueprintColors.gray3)),
            ),
            const SizedBox(height: 16),
            BlueprintBreadcrumbsFactory.withSeparator(
              items: [
                const BlueprintBreadcrumbItem(text: 'Company'),
                const BlueprintBreadcrumbItem(text: 'Engineering'),
                const BlueprintBreadcrumbItem(text: 'Frontend'),
                const BlueprintBreadcrumbItem(text: 'Team', isCurrent: true),
              ],
              separator: const Icon(Icons.arrow_forward_ios, size: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMinimalBreadcrumbs() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlueprintBreadcrumbsFactory.minimal(
              items: [
                const BlueprintBreadcrumbItem(text: 'Dashboard'),
                const BlueprintBreadcrumbItem(text: 'Users'),
                const BlueprintBreadcrumbItem(text: 'Profile', isCurrent: true),
              ],
            ),
            const SizedBox(height: 16),
            BlueprintBreadcrumbsFactory.minimal(
              items: [
                const BlueprintBreadcrumbItem(text: 'Workspace'),
                const BlueprintBreadcrumbItem(text: 'Project Alpha'),
                const BlueprintBreadcrumbItem(text: 'Tasks'),
                const BlueprintBreadcrumbItem(text: 'Task Details', isCurrent: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPathDisplay() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Path: $currentPath',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: BlueprintTheme.fontSize,
              ),
            ),
            const SizedBox(height: 16),
            BlueprintBreadcrumbsFactory.simple(
              items: _parseCurrentPath(),
            ),
          ],
        ),
      ),
    );
  }

  List<BlueprintBreadcrumbItem> _parseCurrentPath() {
    final parts = currentPath.split(' > ');
    return List.generate(parts.length, (index) {
      final isLast = index == parts.length - 1;
      return BlueprintBreadcrumbItem(
        text: parts[index],
        isCurrent: isLast,
        onTap: isLast ? null : () => _navigateToIndex(index),
      );
    });
  }

  void _navigateTo(String path) {
    setState(() {
      currentPath = path;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigated to: $path'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _navigateToIndex(int index) {
    final parts = currentPath.split(' > ');
    final newPath = parts.take(index + 1).join(' > ');
    _navigateTo(newPath);
  }
}