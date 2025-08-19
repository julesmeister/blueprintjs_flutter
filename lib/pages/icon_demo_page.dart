import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_icon.dart';
import '../components/blueprint_button.dart';
import '../components/blueprint_switch.dart';
import '../components/blueprint_section.dart';
import '../components/blueprint_select.dart';
import '../components/demo_page_scaffold.dart';
import '../components/blueprint_common.dart';

class IconDemoPage extends StatefulWidget {
  const IconDemoPage({Key? key}) : super(key: key);

  @override
  State<IconDemoPage> createState() => _IconDemoPageState();
}

class _IconDemoPageState extends State<IconDemoPage> {
  BlueprintIconSize _selectedSize = BlueprintIconSize.standard;
  BlueprintIntent _selectedIntent = BlueprintIntent.none;
  bool _showLabels = true;

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      title: 'Icon Components',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            _buildControls(),
            const SizedBox(height: BlueprintTheme.gridSize * 2),
            _buildSection('Standard Icons', _buildStandardIcons()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Intent-based Icons', _buildIntentIcons()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Size Variations', _buildSizeVariations()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Semantic Icons', _buildSemanticIcons()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Action Icons', _buildActionIcons()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Icon Usage Examples', _buildUsageExamples()),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(BlueprintTheme.gridSize),
      decoration: BoxDecoration(
        color: BlueprintColors.lightGray5,
        borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Icon Settings:',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: BlueprintColors.headingColor,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          
          Row(
            children: [
              // Size Selection
              const Text('Size:', style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(width: BlueprintTheme.gridSize),
              SizedBox(
                width: 120,
                child: BlueprintSelect<BlueprintIconSize>(
                  options: BlueprintIconSize.values.map((size) {
                    return BlueprintSelectOption(
                      value: size,
                      label: _sizeToString(size),
                    );
                  }).toList(),
                  value: _selectedSize,
                  onChanged: (size) => setState(() => _selectedSize = size!),
                  placeholder: 'Select size',
                ),
              ),
              
              const SizedBox(width: BlueprintTheme.gridSize * 2),
              
              // Intent Selection
              const Text('Intent:', style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(width: BlueprintTheme.gridSize),
              SizedBox(
                width: 140,
                child: BlueprintSelect<BlueprintIntent>(
                  options: BlueprintIntent.values.map((intent) {
                    return BlueprintSelectOption(
                      value: intent,
                      label: _intentToString(intent),
                    );
                  }).toList(),
                  value: _selectedIntent,
                  onChanged: (intent) => setState(() => _selectedIntent = intent!),
                  placeholder: 'Select intent',
                ),
              ),
              
              const SizedBox(width: BlueprintTheme.gridSize * 2),
              
              // Show Labels Toggle
              BlueprintSwitches.withLabel(
                label: 'Show Labels',
                value: _showLabels,
                onChanged: (value) => setState(() => _showLabels = value),
              ),
            ],
          ),
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

  Widget _buildStandardIcons() {
    final standardIcons = [
      {'icon': Icons.home, 'name': 'Home'},
      {'icon': Icons.settings, 'name': 'Settings'},
      {'icon': Icons.search, 'name': 'Search'},
      {'icon': Icons.person, 'name': 'Person'},
      {'icon': Icons.email, 'name': 'Email'},
      {'icon': Icons.phone, 'name': 'Phone'},
      {'icon': Icons.location_on, 'name': 'Location'},
      {'icon': Icons.calendar_month, 'name': 'Calendar'},
      {'icon': Icons.folder, 'name': 'Folder'},
      {'icon': Icons.description, 'name': 'Document'},
      {'icon': Icons.image, 'name': 'Image'},
      {'icon': Icons.music_note, 'name': 'Music'},
      {'icon': Icons.videocam, 'name': 'Video'},
      {'icon': Icons.attach_file, 'name': 'Attachment'},
      {'icon': Icons.link, 'name': 'Link'},
      {'icon': Icons.share, 'name': 'Share'},
    ];

    return _buildIconGrid(standardIcons);
  }

  Widget _buildIntentIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildIntentColumn('Primary', BlueprintIntent.primary, [
          {'icon': Icons.info, 'name': 'Info'},
          {'icon': Icons.star, 'name': 'Star'},
          {'icon': Icons.bookmark, 'name': 'Bookmark'},
        ]),
        _buildIntentColumn('Success', BlueprintIntent.success, [
          {'icon': Icons.check_circle, 'name': 'Success'},
          {'icon': Icons.verified, 'name': 'Verified'},
          {'icon': Icons.done, 'name': 'Done'},
        ]),
        _buildIntentColumn('Warning', BlueprintIntent.warning, [
          {'icon': Icons.warning, 'name': 'Warning'},
          {'icon': Icons.help, 'name': 'Help'},
          {'icon': Icons.report, 'name': 'Report'},
        ]),
        _buildIntentColumn('Danger', BlueprintIntent.danger, [
          {'icon': Icons.error, 'name': 'Error'},
          {'icon': Icons.delete, 'name': 'Delete'},
          {'icon': Icons.block, 'name': 'Block'},
        ]),
      ],
    );
  }

  Widget _buildIntentColumn(String title, BlueprintIntent intent, List<Map<String, dynamic>> icons) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: BlueprintTheme.fontSizeSmall,
          ),
        ),
        const SizedBox(height: BlueprintTheme.gridSize),
        Column(
          children: icons.map((iconData) => 
            _buildIconExample(
              iconData['icon'] as IconData, 
              iconData['name'] as String,
              intent: intent,
            )
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildSizeVariations() {
    const testIcon = Icons.star;
    const iconName = 'Star';
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            BlueprintIcons.small(
              icon: testIcon,
              intent: _selectedIntent,
            ),
            if (_showLabels) const SizedBox(height: BlueprintTheme.gridSize * 0.5),
            if (_showLabels) Text(
              'Small (12px)',
              style: const TextStyle(fontSize: BlueprintTheme.fontSizeSmall),
            ),
          ],
        ),
        Column(
          children: [
            BlueprintIcons.standard(
              icon: testIcon,
              intent: _selectedIntent,
            ),
            if (_showLabels) const SizedBox(height: BlueprintTheme.gridSize * 0.5),
            if (_showLabels) Text(
              'Standard (16px)',
              style: const TextStyle(fontSize: BlueprintTheme.fontSizeSmall),
            ),
          ],
        ),
        Column(
          children: [
            BlueprintIcons.large(
              icon: testIcon,
              intent: _selectedIntent,
            ),
            if (_showLabels) const SizedBox(height: BlueprintTheme.gridSize * 0.5),
            if (_showLabels) Text(
              'Large (20px)',
              style: const TextStyle(fontSize: BlueprintTheme.fontSizeSmall),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSemanticIcons() {
    final semanticIcons = [
      {'icon': Icons.check_circle, 'name': 'Success', 'method': 'success_check'},
      {'icon': Icons.warning_amber, 'name': 'Warning', 'method': 'warning_triangle'},
      {'icon': Icons.error, 'name': 'Error', 'method': 'error'},
      {'icon': Icons.info, 'name': 'Info', 'method': 'info'},
      {'icon': Icons.help, 'name': 'Help', 'method': 'help'},
      {'icon': Icons.settings, 'name': 'Settings', 'method': 'settings'},
      {'icon': Icons.home, 'name': 'Home', 'method': 'home'},
      {'icon': Icons.save, 'name': 'Save', 'method': 'save'},
      {'icon': Icons.delete, 'name': 'Delete', 'method': 'delete'},
      {'icon': Icons.edit, 'name': 'Edit', 'method': 'edit'},
      {'icon': Icons.add, 'name': 'Add', 'method': 'add'},
      {'icon': Icons.remove, 'name': 'Remove', 'method': 'remove'},
    ];

    return Column(
      children: [
        const Text(
          'These icons have dedicated factory methods in BlueprintIcons class:',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: BlueprintColors.textColorMuted,
          ),
        ),
        const SizedBox(height: BlueprintTheme.gridSize),
        _buildIconGrid(semanticIcons),
      ],
    );
  }

  Widget _buildActionIcons() {
    final actionIcons = [
      {'icon': Icons.play_arrow, 'name': 'Play'},
      {'icon': Icons.pause, 'name': 'Pause'},
      {'icon': Icons.stop, 'name': 'Stop'},
      {'icon': Icons.skip_next, 'name': 'Next'},
      {'icon': Icons.skip_previous, 'name': 'Previous'},
      {'icon': Icons.refresh, 'name': 'Refresh'},
      {'icon': Icons.sync, 'name': 'Sync'},
      {'icon': Icons.download, 'name': 'Download'},
      {'icon': Icons.upload, 'name': 'Upload'},
      {'icon': Icons.print, 'name': 'Print'},
      {'icon': Icons.copy, 'name': 'Copy'},
      {'icon': Icons.content_cut, 'name': 'Cut'},
      {'icon': Icons.content_paste, 'name': 'Paste'},
      {'icon': Icons.undo, 'name': 'Undo'},
      {'icon': Icons.redo, 'name': 'Redo'},
      {'icon': Icons.zoom_in, 'name': 'Zoom In'},
    ];

    return _buildIconGrid(actionIcons);
  }

  Widget _buildUsageExamples() {
    return BlueprintSections.simple(
      title: 'Usage Examples',
      children: [
        const Text(
          'Icons in Buttons:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        Wrap(
          spacing: BlueprintTheme.gridSize,
          children: [
            BlueprintButton(
              text: 'Save',
              icon: Icons.save,
              intent: BlueprintIntent.primary,
              onPressed: () => _showSnackBar('Save clicked'),
            ),
            BlueprintButton(
              text: 'Delete',
              icon: Icons.delete,
              intent: BlueprintIntent.danger,
              onPressed: () => _showSnackBar('Delete clicked'),
            ),
            BlueprintButton(
              icon: Icons.settings,
              variant: BlueprintButtonVariant.minimal,
              onPressed: () => _showSnackBar('Settings clicked'),
            ),
          ],
        ),
        
        const SizedBox(height: BlueprintTheme.gridSize * 1.5),
        
        const Text(
          'Standalone Icons:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        Row(
          children: [
            BlueprintIcons.primary(icon: Icons.star),
            const SizedBox(width: BlueprintTheme.gridSize),
            const Text('Primary star icon'),
          ],
        ),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        Row(
          children: [
            BlueprintIcons.success_check(),
            const SizedBox(width: BlueprintTheme.gridSize),
            const Text('Success check icon'),
          ],
        ),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        Row(
          children: [
            BlueprintIcons.large(icon: Icons.warning, intent: BlueprintIntent.warning),
            const SizedBox(width: BlueprintTheme.gridSize),
            const Text('Large warning icon'),
          ],
        ),
        
        const SizedBox(height: BlueprintTheme.gridSize * 1.5),
        
        const Text(
          'Icon Features:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        const Text('• Three sizes: Small (12px), Standard (16px), Large (20px)'),
        const Text('• Intent-based coloring (Primary, Success, Warning, Danger)'),
        const Text('• Factory methods for common icons (home, settings, success, etc.)'),
        const Text('• Semantic icon variants for consistent meaning'),
        const Text('• Integration with buttons and other components'),
        const Text('• Customizable size and intent parameters'),
      ],
    );
  }

  Widget _buildIconGrid(List<Map<String, dynamic>> icons) {
    return Wrap(
      spacing: BlueprintTheme.gridSize * 2,
      runSpacing: BlueprintTheme.gridSize * 1.5,
      children: icons.map((iconData) => 
        _buildIconExample(
          iconData['icon'] as IconData, 
          iconData['name'] as String,
        )
      ).toList(),
    );
  }

  Widget _buildIconExample(IconData iconData, String name, {BlueprintIntent? intent}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(BlueprintTheme.gridSize),
          decoration: BoxDecoration(
            color: BlueprintColors.lightGray4,
            borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
          ),
          child: BlueprintIcon(
            icon: iconData,
            size: _selectedSize,
            intent: intent ?? _selectedIntent,
          ),
        ),
        if (_showLabels) ...[
          const SizedBox(height: BlueprintTheme.gridSize * 0.5),
          SizedBox(
            width: 80,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: BlueprintTheme.fontSizeSmall,
                color: BlueprintColors.textColorMuted,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );
  }

  String _sizeToString(BlueprintIconSize size) {
    switch (size) {
      case BlueprintIconSize.small:
        return 'Small';
      case BlueprintIconSize.standard:
        return 'Standard';
      case BlueprintIconSize.large:
        return 'Large';
    }
  }

  String _intentToString(BlueprintIntent intent) {
    switch (intent) {
      case BlueprintIntent.none:
        return 'None';
      case BlueprintIntent.primary:
        return 'Primary';
      case BlueprintIntent.success:
        return 'Success';
      case BlueprintIntent.warning:
        return 'Warning';
      case BlueprintIntent.danger:
        return 'Danger';
    }
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