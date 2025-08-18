import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_button.dart';
import '../components/blueprint_tag.dart';

class TagDemoPage extends StatefulWidget {
  const TagDemoPage({Key? key}) : super(key: key);

  @override
  State<TagDemoPage> createState() => _TagDemoPageState();
}

class _TagDemoPageState extends State<TagDemoPage> {
  List<String> _removableTags = [
    'React', 'TypeScript', 'Flutter', 'Dart', 'JavaScript', 'Python'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blueprint Tags'),
        backgroundColor: BlueprintColors.intentPrimary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: BlueprintColors.intentPrimary,
      ),
    );
  }
}