import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_button.dart';
import '../components/blueprint_tag.dart';
import '../components/demo_page_scaffold.dart';
import '../components/blueprint_common.dart';

class TagDemoPage extends StatefulWidget {
  const TagDemoPage({super.key});

  @override
  State<TagDemoPage> createState() => _TagDemoPageState();
}

class _TagDemoPageState extends State<TagDemoPage> {
  List<String> _removableTags = [
    'React', 'TypeScript', 'Flutter', 'Dart', 'JavaScript', 'Python'
  ];

  List<Map<String, String>> _compoundTags = [
    {'key': 'User', 'value': 'john.doe@example.com'},
    {'key': 'Region', 'value': 'US-East'},
    {'key': 'Status', 'value': 'Active'},
    {'key': 'Role', 'value': 'Administrator'},
  ];

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      title: 'Blueprint Tags',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            _buildSection('Basic Tags', _buildBasicTags()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Intent Tags', _buildIntentTags()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Tag Sizes', _buildSizeTags()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Tag Variants', _buildVariantTags()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Interactive Tags', _buildInteractiveTags()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Removable Tags', _buildRemovableTags()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Tags with Icons', _buildIconTags()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Compound Tags', _buildCompoundTags()),
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

  Widget _buildBasicTags() {
    return Wrap(
      spacing: BlueprintTheme.gridSize,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintTags.simple(text: 'Default'),
        BlueprintTags.simple(text: 'Another Tag'),
        BlueprintTags.simple(text: 'Long Tag Name'),
        BlueprintTags.minimal(text: 'Minimal'),
        BlueprintTags.minimal(text: 'Minimal Style'),
      ],
    );
  }

  Widget _buildIntentTags() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Filled Intent Tags:', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        Wrap(
          spacing: BlueprintTheme.gridSize,
          runSpacing: BlueprintTheme.gridSize,
          children: [
            BlueprintTags.withIntent(text: 'Primary', intent: BlueprintIntent.primary),
            BlueprintTags.withIntent(text: 'Success', intent: BlueprintIntent.success),
            BlueprintTags.withIntent(text: 'Warning', intent: BlueprintIntent.warning),
            BlueprintTags.withIntent(text: 'Danger', intent: BlueprintIntent.danger),
          ],
        ),
        const SizedBox(height: BlueprintTheme.gridSize * 1.5),
        const Text('Minimal Intent Tags:', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        Wrap(
          spacing: BlueprintTheme.gridSize,
          runSpacing: BlueprintTheme.gridSize,
          children: [
            BlueprintTags.withIntent(text: 'Primary', intent: BlueprintIntent.primary, minimal: true),
            BlueprintTags.withIntent(text: 'Success', intent: BlueprintIntent.success, minimal: true),
            BlueprintTags.withIntent(text: 'Warning', intent: BlueprintIntent.warning, minimal: true),
            BlueprintTags.withIntent(text: 'Danger', intent: BlueprintIntent.danger, minimal: true),
          ],
        ),
      ],
    );
  }

  Widget _buildSizeTags() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: BlueprintTheme.gridSize,
          runSpacing: BlueprintTheme.gridSize,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            BlueprintTags.simple(text: 'Small', size: BlueprintTagSize.small),
            BlueprintTags.simple(text: 'Medium', size: BlueprintTagSize.medium),
            BlueprintTags.simple(text: 'Large', size: BlueprintTagSize.large),
          ],
        ),
        const SizedBox(height: BlueprintTheme.gridSize),
        const Text('With Intent Colors:', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        Wrap(
          spacing: BlueprintTheme.gridSize,
          runSpacing: BlueprintTheme.gridSize,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            BlueprintTags.withIntent(
              text: 'Small',
              intent: BlueprintIntent.primary,
              size: BlueprintTagSize.small,
            ),
            BlueprintTags.withIntent(
              text: 'Medium', 
              intent: BlueprintIntent.success,
              size: BlueprintTagSize.medium,
            ),
            BlueprintTags.withIntent(
              text: 'Large',
              intent: BlueprintIntent.warning,
              size: BlueprintTagSize.large,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVariantTags() {
    return Wrap(
      spacing: BlueprintTheme.gridSize,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintTags.simple(text: 'Default'),
        BlueprintTags.minimal(text: 'Minimal'),
        BlueprintTags.round(text: 'Round'),
        BlueprintTags.round(text: 'Round Primary', intent: BlueprintIntent.primary),
        BlueprintTags.round(text: 'Round Minimal', intent: BlueprintIntent.success),
      ],
    );
  }

  Widget _buildInteractiveTags() {
    return Wrap(
      spacing: BlueprintTheme.gridSize,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintTags.interactive(
          text: 'Clickable',
          onTap: () => _showSnackBar('Clicked: Clickable'),
        ),
        BlueprintTags.interactive(
          text: 'Primary Action',
          intent: BlueprintIntent.primary,
          onTap: () => _showSnackBar('Clicked: Primary Action'),
        ),
        BlueprintTags.interactive(
          text: 'Success Action',
          intent: BlueprintIntent.success,
          onTap: () => _showSnackBar('Clicked: Success Action'),
        ),
        BlueprintTag(
          text: 'Custom Interactive',
          intent: BlueprintIntent.warning,
          minimal: true,
          interactive: true,
          onTap: () => _showSnackBar('Clicked: Custom Interactive'),
        ),
      ],
    );
  }

  Widget _buildRemovableTags() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: BlueprintTheme.gridSize,
          runSpacing: BlueprintTheme.gridSize,
          children: _removableTags
              .map((tag) => BlueprintTags.removable(
                    text: tag,
                    onRemove: () => _removeTag(tag),
                    intent: _getTagIntent(tag),
                  ))
              .toList(),
        ),
        const SizedBox(height: BlueprintTheme.gridSize),
        BlueprintButton(
          text: 'Reset Tags',
          variant: BlueprintButtonVariant.minimal,
          icon: Icons.refresh,
          onPressed: _resetTags,
        ),
      ],
    );
  }

  Widget _buildIconTags() {
    return Wrap(
      spacing: BlueprintTheme.gridSize,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintTags.simple(
          text: 'Home',
          icon: Icons.home,
        ),
        BlueprintTags.simple(
          text: 'Settings',
          icon: Icons.settings,
          intent: BlueprintIntent.primary,
        ),
        BlueprintTags.minimal(
          text: 'Profile',
          icon: Icons.person,
          intent: BlueprintIntent.success,
        ),
        BlueprintTag(
          text: 'Download',
          icon: Icons.download,
          rightIcon: Icons.arrow_drop_down,
          intent: BlueprintIntent.warning,
          interactive: true,
          onTap: () => _showSnackBar('Clicked: Download'),
        ),
        BlueprintTags.removable(
          text: 'Tagged Item',
          icon: Icons.label,
          intent: BlueprintIntent.danger,
          onRemove: () => _showSnackBar('Removed: Tagged Item'),
        ),
        BlueprintTags.round(
          text: 'Online',
          icon: Icons.circle,
          intent: BlueprintIntent.success,
        ),
      ],
    );
  }

  Widget _buildCompoundTags() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Basic Compound Tags:', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        Wrap(
          spacing: BlueprintTheme.gridSize,
          runSpacing: BlueprintTheme.gridSize,
          children: [
            BlueprintTags.compoundKeyValue(
              key: 'City',
              value: 'New York',
              icon: Icons.location_on,
            ),
            BlueprintTags.compoundKeyValue(
              key: 'Country',
              value: 'United States',
              icon: Icons.flag,
              rightIcon: Icons.public,
            ),
            BlueprintTags.compound(
              leftContent: Text('Server'),
              rightContent: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, color: Colors.green, size: 8),
                  SizedBox(width: 4),
                  Text('Online'),
                ],
              ),
              intent: BlueprintIntent.success,
            ),
          ],
        ),
        
        const SizedBox(height: BlueprintTheme.gridSize * 1.5),
        const Text('Compound Tags with Intent:', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        Wrap(
          spacing: BlueprintTheme.gridSize,
          runSpacing: BlueprintTheme.gridSize,
          children: [
            BlueprintTags.compoundKeyValue(
              key: 'Priority',
              value: 'High',
              intent: BlueprintIntent.danger,
              icon: Icons.priority_high,
            ),
            BlueprintTags.compoundKeyValue(
              key: 'Status',
              value: 'Complete',
              intent: BlueprintIntent.success,
              icon: Icons.check_circle,
            ),
            BlueprintTags.compoundKeyValue(
              key: 'Warning',
              value: 'Attention',
              intent: BlueprintIntent.warning,
              icon: Icons.warning,
            ),
            BlueprintTags.compoundKeyValue(
              key: 'Info',
              value: 'Details',
              intent: BlueprintIntent.primary,
              icon: Icons.info,
            ),
          ],
        ),

        const SizedBox(height: BlueprintTheme.gridSize * 1.5),
        const Text('Minimal Compound Tags:', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        Wrap(
          spacing: BlueprintTheme.gridSize,
          runSpacing: BlueprintTheme.gridSize,
          children: [
            BlueprintTags.compoundKeyValue(
              key: 'Type',
              value: 'Document',
              intent: BlueprintIntent.primary,
              minimal: true,
              icon: Icons.description,
            ),
            BlueprintTags.compoundKeyValue(
              key: 'Size',
              value: '2.4 MB',
              intent: BlueprintIntent.success,
              minimal: true,
              icon: Icons.folder,
            ),
          ],
        ),

        const SizedBox(height: BlueprintTheme.gridSize * 1.5),
        const Text('Interactive Compound Tags:', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        Wrap(
          spacing: BlueprintTheme.gridSize,
          runSpacing: BlueprintTheme.gridSize,
          children: [
            BlueprintTags.compoundKeyValue(
              key: 'Download',
              value: 'report.pdf',
              icon: Icons.download,
              rightIcon: Icons.arrow_downward,
              intent: BlueprintIntent.primary,
              onTap: () => _showSnackBar('Downloading: report.pdf'),
            ),
            BlueprintCompoundTag(
              leftContent: Text('Edit'),
              rightContent: Text('Profile'),
              icon: Icons.edit,
              rightIcon: Icons.person,
              intent: BlueprintIntent.warning,
              interactive: true,
              onTap: () => _showSnackBar('Opening profile editor'),
            ),
          ],
        ),

        const SizedBox(height: BlueprintTheme.gridSize * 1.5),
        const Text('Removable Compound Tags:', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        Wrap(
          spacing: BlueprintTheme.gridSize,
          runSpacing: BlueprintTheme.gridSize,
          children: _compoundTags
              .map((tag) => BlueprintTags.compoundKeyValue(
                    key: tag['key']!,
                    value: tag['value']!,
                    icon: _getCompoundTagIcon(tag['key']!),
                    intent: _getCompoundTagIntent(tag['key']!),
                    removable: true,
                    onRemove: () => _removeCompoundTag(tag),
                    onTap: () => _showSnackBar('Clicked: ${tag['key']}: ${tag['value']}'),
                  ))
              .toList(),
        ),
        const SizedBox(height: BlueprintTheme.gridSize),
        BlueprintButton(
          text: 'Reset Compound Tags',
          variant: BlueprintButtonVariant.minimal,
          icon: Icons.refresh,
          onPressed: _resetCompoundTags,
        ),

        const SizedBox(height: BlueprintTheme.gridSize * 1.5),
        const Text('Size Variations:', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        Wrap(
          spacing: BlueprintTheme.gridSize,
          runSpacing: BlueprintTheme.gridSize,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            BlueprintTags.compoundKeyValue(
              key: 'Small',
              value: 'Tag',
              size: BlueprintTagSize.small,
              intent: BlueprintIntent.primary,
            ),
            BlueprintTags.compoundKeyValue(
              key: 'Medium',
              value: 'Tag',
              size: BlueprintTagSize.medium,
              intent: BlueprintIntent.success,
            ),
            BlueprintTags.compoundKeyValue(
              key: 'Large',
              value: 'Tag',
              size: BlueprintTagSize.large,
              intent: BlueprintIntent.warning,
            ),
          ],
        ),
      ],
    );
  }

  BlueprintIntent _getTagIntent(String tag) {
    switch (tag.toLowerCase()) {
      case 'react':
      case 'flutter':
        return BlueprintIntent.primary;
      case 'typescript':
      case 'dart':
        return BlueprintIntent.success;
      case 'javascript':
        return BlueprintIntent.warning;
      case 'python':
        return BlueprintIntent.danger;
      default:
        return BlueprintIntent.none;
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _removableTags.remove(tag);
    });
    _showSnackBar('Removed: $tag');
  }

  void _resetTags() {
    setState(() {
      _removableTags = [
        'React', 'TypeScript', 'Flutter', 'Dart', 'JavaScript', 'Python'
      ];
    });
    _showSnackBar('Tags reset');
  }

  IconData _getCompoundTagIcon(String key) {
    switch (key.toLowerCase()) {
      case 'user':
        return Icons.person;
      case 'region':
        return Icons.public;
      case 'status':
        return Icons.info;
      case 'role':
        return Icons.admin_panel_settings;
      default:
        return Icons.label;
    }
  }

  BlueprintIntent _getCompoundTagIntent(String key) {
    switch (key.toLowerCase()) {
      case 'user':
        return BlueprintIntent.primary;
      case 'region':
        return BlueprintIntent.success;
      case 'status':
        return BlueprintIntent.warning;
      case 'role':
        return BlueprintIntent.danger;
      default:
        return BlueprintIntent.none;
    }
  }

  void _removeCompoundTag(Map<String, String> tag) {
    setState(() {
      _compoundTags.remove(tag);
    });
    _showSnackBar('Removed: ${tag['key']}: ${tag['value']}');
  }

  void _resetCompoundTags() {
    setState(() {
      _compoundTags = [
        {'key': 'User', 'value': 'john.doe@example.com'},
        {'key': 'Region', 'value': 'US-East'},
        {'key': 'Status', 'value': 'Active'},
        {'key': 'Role', 'value': 'Administrator'},
      ];
    });
    _showSnackBar('Compound tags reset');
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