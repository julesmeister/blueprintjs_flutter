import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_button.dart';
import '../components/blueprint_tag.dart';
import '../components/blueprint_icon.dart';
import '../components/blueprint_collapse.dart';
import '../components/blueprint_card.dart';
import '../components/blueprint_tooltip.dart';
import '../components/blueprint_switch.dart';
import '../components/demo_page_scaffold.dart';

class ComponentsDemoPage extends StatefulWidget {
  const ComponentsDemoPage({Key? key}) : super(key: key);

  @override
  State<ComponentsDemoPage> createState() => _ComponentsDemoPageState();
}

class _ComponentsDemoPageState extends State<ComponentsDemoPage> {
  bool _isAdvancedOpen = false;
  List<String> _tags = ['Design', 'Development', 'Testing'];

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      title: 'New Components',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            _buildSection('Icons', _buildIconsDemo()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Tags', _buildTagsDemo()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Collapse Panels', _buildCollapseDemo()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Tooltips', _buildTooltipsDemo()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Combined Examples', _buildCombinedDemo()),
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

  Widget _buildIconsDemo() {
    return Wrap(
      spacing: BlueprintTheme.gridSize * 2,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        _buildIconExample('Home', BlueprintIcons.home()),
        _buildIconExample('Settings', BlueprintIcons.settings()),
        _buildIconExample('Info', BlueprintIcons.info()),
        _buildIconExample('Warning', BlueprintIcons.warning_triangle()),
        _buildIconExample('Success', BlueprintIcons.success_check()),
        _buildIconExample('Error', BlueprintIcons.error()),
        _buildIconExample('Save', BlueprintIcons.save()),
        _buildIconExample('Delete', BlueprintIcons.delete()),
        _buildIconExample('Small', BlueprintIcons.small(icon: Icons.star, intent: BlueprintIntent.warning)),
        _buildIconExample('Large', BlueprintIcons.large(icon: Icons.star, intent: BlueprintIntent.success)),
      ],
    );
  }

  Widget _buildIconExample(String label, Widget icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(BlueprintTheme.gridSize),
          decoration: BoxDecoration(
            color: BlueprintColors.lightGray4,
            borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
          ),
          child: icon,
        ),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        Text(
          label,
          style: const TextStyle(
            fontSize: BlueprintTheme.fontSizeSmall,
            color: BlueprintColors.textColorMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildTagsDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Intent Tags:', style: TextStyle(fontWeight: FontWeight.w500)),
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
        const Text('Interactive Tags:', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        Wrap(
          spacing: BlueprintTheme.gridSize,
          runSpacing: BlueprintTheme.gridSize,
          children: _tags
              .map((tag) => BlueprintTags.removable(
                    text: tag,
                    intent: _getTagIntent(tag),
                    icon: _getTagIcon(tag),
                    onRemove: () => _removeTag(tag),
                  ))
              .toList()
            ..add(
              BlueprintTags.interactive(
                text: '+ Add Tag',
                intent: BlueprintIntent.primary,
                onTap: _addTag,
              ),
            ),
        ),
      ],
    );
  }

  Widget _buildCollapseDemo() {
    return Column(
      children: [
        BlueprintCollapseExample(
          buttonText: 'Basic Information',
          initiallyOpen: true,
          child: Padding(
            padding: const EdgeInsets.all(BlueprintTheme.gridSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('This is a collapsible panel with basic information.'),
                const SizedBox(height: BlueprintTheme.gridSize),
                BlueprintButton(
                  text: 'Action Button',
                  variant: BlueprintButtonVariant.minimal,
                  icon: Icons.play_arrow,
                  onPressed: () => _showSnackBar('Action executed'),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: BlueprintTheme.gridSize),
        
        BlueprintCollapseExample(
          buttonText: 'Project Files',
          initiallyOpen: false,
          child: Padding(
            padding: const EdgeInsets.all(BlueprintTheme.gridSize),
            child: Column(
              children: [
                _buildFileItem('README.md', Icons.description),
                _buildFileItem('package.json', Icons.settings),
                _buildFileItem('src/', Icons.folder),
                _buildFileItem('tests/', Icons.bug_report),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: BlueprintTheme.gridSize),
        
        BlueprintCollapseExample(
          buttonText: 'Advanced Settings',
          initiallyOpen: _isAdvancedOpen,
          child: Padding(
            padding: const EdgeInsets.all(BlueprintTheme.gridSize),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Advanced configuration options would go here.'),
                Text('• Enable debug mode'),
                Text('• Configure cache settings'), 
                Text('• Adjust performance parameters'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCombinedDemo() {
    return BlueprintCard(
      elevation: BlueprintElevation.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and tags
          Row(
            children: [
              BlueprintIcons.large(
                icon: Icons.dashboard,
                intent: BlueprintIntent.primary,
              ),
              const SizedBox(width: BlueprintTheme.gridSize),
              const Expanded(
                child: Text(
                  'Project Dashboard',
                  style: TextStyle(
                    fontSize: BlueprintTheme.fontSizeLarge,
                    fontWeight: FontWeight.w600,
                    color: BlueprintColors.headingColor,
                  ),
                ),
              ),
              BlueprintTags.simple(
                text: 'Active',
                intent: BlueprintIntent.success,
                size: BlueprintTagSize.small,
              ),
            ],
          ),
          
          const SizedBox(height: BlueprintTheme.gridSize),
          
          // Content with collapse
          BlueprintCollapseExample(
            buttonText: 'Project Details',
            initiallyOpen: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: BlueprintTheme.gridSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Project technologies:'),
                  const SizedBox(height: BlueprintTheme.gridSize * 0.5),
                  Wrap(
                    spacing: BlueprintTheme.gridSize * 0.5,
                    children: [
                      BlueprintTags.simple(text: 'Flutter', size: BlueprintTagSize.small),
                      BlueprintTags.simple(text: 'Dart', size: BlueprintTagSize.small),
                      BlueprintTags.simple(text: 'Material', size: BlueprintTagSize.small),
                    ],
                  ),
                  const SizedBox(height: BlueprintTheme.gridSize),
                  Row(
                    children: [
                      BlueprintIcons.success_check(size: BlueprintIconSize.small),
                      const SizedBox(width: BlueprintTheme.gridSize * 0.5),
                      const Text('All tests passing'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: BlueprintTheme.gridSize),
          
          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlueprintButton(
                text: 'View Details',
                variant: BlueprintButtonVariant.minimal,
                icon: Icons.visibility,
                onPressed: () => _showSnackBar('Viewing details'),
              ),
              const SizedBox(width: BlueprintTheme.gridSize),
              BlueprintButton(
                text: 'Deploy',
                intent: BlueprintIntent.primary,
                icon: Icons.rocket_launch,
                onPressed: () => _showSnackBar('Deploying project'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFileItem(String name, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 16, color: BlueprintColors.textColorMuted),
          const SizedBox(width: BlueprintTheme.gridSize),
          Text(name),
        ],
      ),
    );
  }

  BlueprintIntent _getTagIntent(String tag) {
    switch (tag.toLowerCase()) {
      case 'design':
        return BlueprintIntent.primary;
      case 'development':
        return BlueprintIntent.success;
      case 'testing':
        return BlueprintIntent.warning;
      default:
        return BlueprintIntent.none;
    }
  }

  IconData _getTagIcon(String tag) {
    switch (tag.toLowerCase()) {
      case 'design':
        return Icons.palette;
      case 'development':
        return Icons.code;
      case 'testing':
        return Icons.bug_report;
      default:
        return Icons.label;
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
    _showSnackBar('Removed: $tag');
  }

  void _addTag() {
    final newTags = ['Research', 'Documentation', 'Review', 'Planning'];
    final availableTags = newTags.where((tag) => !_tags.contains(tag)).toList();
    
    if (availableTags.isNotEmpty) {
      setState(() {
        _tags.add(availableTags.first);
      });
      _showSnackBar('Added: ${availableTags.first}');
    }
  }

  Widget _buildTooltipsDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Basic Tooltips:', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        Wrap(
          spacing: BlueprintTheme.gridSize * 2,
          runSpacing: BlueprintTheme.gridSize,
          children: [
            BlueprintTooltips.simple(
              content: 'This is a basic tooltip',
              child: BlueprintButton(
                text: 'Hover me',
                variant: BlueprintButtonVariant.minimal,
              ),
            ),
            BlueprintTooltips.forButton(
              content: 'Save your work',
              button: BlueprintButton(
                text: 'Save',
                intent: BlueprintIntent.primary,
                icon: Icons.save,
                onPressed: () => _showSnackBar('Saved!'),
              ),
            ),
            BlueprintTooltips.simple(
              content: 'Enable or disable the feature',
              child: BlueprintSwitches.simple(
                value: _isAdvancedOpen,
                onChanged: (value) => setState(() => _isAdvancedOpen = value),
              ),
            ),
            BlueprintTooltips.forIcon(
              content: 'Settings',
              icon: BlueprintIcons.settings(),
            ),
          ],
        ),
        const SizedBox(height: BlueprintTheme.gridSize * 1.5),
        const Text('Intent Tooltips:', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        Wrap(
          spacing: BlueprintTheme.gridSize * 2,
          runSpacing: BlueprintTheme.gridSize,
          children: [
            BlueprintTooltips.intent(
              content: 'Primary action',
              intent: BlueprintIntent.primary,
              child: BlueprintIcons.primary(icon: Icons.star),
            ),
            BlueprintTooltips.intent(
              content: 'Success state',
              intent: BlueprintIntent.success,
              child: BlueprintIcons.success_check(),
            ),
            BlueprintTooltips.intent(
              content: 'Warning message',
              intent: BlueprintIntent.warning,
              child: BlueprintIcons.warning_triangle(),
            ),
            BlueprintTooltips.intent(
              content: 'Danger zone',
              intent: BlueprintIntent.danger,
              child: BlueprintIcons.error(),
            ),
          ],
        ),
        const SizedBox(height: BlueprintTheme.gridSize * 1.5),
        const Text('Positioning & Variants:', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        Center(
          child: Container(
            padding: const EdgeInsets.all(BlueprintTheme.gridSize * 4),
            child: Column(
              children: [
                BlueprintTooltips.simple(
                  content: 'Top tooltip',
                  position: BlueprintTooltipPosition.top,
                  child: BlueprintTags.simple(text: 'Top', intent: BlueprintIntent.primary),
                ),
                const SizedBox(height: BlueprintTheme.gridSize * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BlueprintTooltips.simple(
                      content: 'Left tooltip',
                      position: BlueprintTooltipPosition.left,
                      child: BlueprintTags.simple(text: 'Left', intent: BlueprintIntent.success),
                    ),
                    BlueprintTooltips.compact(
                      content: 'Compact tooltip',
                      child: BlueprintTags.simple(text: 'Compact', intent: BlueprintIntent.warning),
                    ),
                    BlueprintTooltips.simple(
                      content: 'Right tooltip',
                      position: BlueprintTooltipPosition.right,
                      child: BlueprintTags.simple(text: 'Right', intent: BlueprintIntent.danger),
                    ),
                  ],
                ),
                const SizedBox(height: BlueprintTheme.gridSize * 2),
                BlueprintTooltips.minimal(
                  content: 'Minimal bottom tooltip',
                  position: BlueprintTooltipPosition.bottom,
                  child: BlueprintTags.minimal(text: 'Bottom & Minimal'),
                ),
              ],
            ),
          ),
        ),
      ],
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