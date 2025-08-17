import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_tooltip.dart';
import '../components/blueprint_button.dart';
import '../components/blueprint_card.dart';

class TooltipDemoPage extends StatefulWidget {
  const TooltipDemoPage({Key? key}) : super(key: key);

  @override
  State<TooltipDemoPage> createState() => _TooltipDemoPageState();
}

class _TooltipDemoPageState extends State<TooltipDemoPage> {
  bool _tooltipsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blueprint Tooltips'),
        backgroundColor: BlueprintColors.intentPrimary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Basic Tooltips', _buildBasicTooltips()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Tooltip Positions', _buildPositionTooltips()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Intent Colors', _buildIntentTooltips()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Tooltip Variants', _buildVariantTooltips()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Interactive Examples', _buildInteractiveExamples()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Controls', _buildControls()),
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

  Widget _buildBasicTooltips() {
    return BlueprintCard(
      child: Wrap(
        spacing: BlueprintTheme.gridSize * 2,
        runSpacing: BlueprintTheme.gridSize * 2,
        children: [
          BlueprintTooltips.simple(
            content: 'This is a basic tooltip',
            disabled: !_tooltipsEnabled,
            child: const BlueprintButton(
              text: 'Hover for tooltip',
              intent: BlueprintIntent.primary,
            ),
          ),
          BlueprintTooltips.simple(
            content: 'Tooltips can contain longer text that wraps to multiple lines when needed',
            disabled: !_tooltipsEnabled,
            child: const BlueprintButton(
              text: 'Long content',
              intent: BlueprintIntent.success,
            ),
          ),
          BlueprintTooltip(
            content: 'Icon buttons work great with tooltips',
            disabled: !_tooltipsEnabled,
            child: IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () => _showSnackBar('Info button clicked'),
              color: BlueprintColors.intentPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPositionTooltips() {
    return BlueprintCard(
      child: Column(
        children: [
          // Top row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlueprintTooltips.simple(
                content: 'Top Left',
                position: BlueprintTooltipPosition.topLeft,
                disabled: !_tooltipsEnabled,
                child: const BlueprintButton(
                  text: 'Top Left',
                  size: BlueprintButtonSize.small,
                ),
              ),
              BlueprintTooltips.simple(
                content: 'Top Center',
                position: BlueprintTooltipPosition.top,
                disabled: !_tooltipsEnabled,
                child: const BlueprintButton(
                  text: 'Top',
                  size: BlueprintButtonSize.small,
                ),
              ),
              BlueprintTooltips.simple(
                content: 'Top Right',
                position: BlueprintTooltipPosition.topRight,
                disabled: !_tooltipsEnabled,
                child: const BlueprintButton(
                  text: 'Top Right',
                  size: BlueprintButtonSize.small,
                ),
              ),
            ],
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          // Middle row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlueprintTooltips.simple(
                content: 'Left Side',
                position: BlueprintTooltipPosition.left,
                disabled: !_tooltipsEnabled,
                child: const BlueprintButton(
                  text: 'Left',
                  size: BlueprintButtonSize.small,
                ),
              ),
              BlueprintTooltips.simple(
                content: 'Right Side',
                position: BlueprintTooltipPosition.right,
                disabled: !_tooltipsEnabled,
                child: const BlueprintButton(
                  text: 'Right',
                  size: BlueprintButtonSize.small,
                ),
              ),
            ],
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          // Bottom row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlueprintTooltips.simple(
                content: 'Bottom Left',
                position: BlueprintTooltipPosition.bottomLeft,
                disabled: !_tooltipsEnabled,
                child: const BlueprintButton(
                  text: 'Bottom Left',
                  size: BlueprintButtonSize.small,
                ),
              ),
              BlueprintTooltips.simple(
                content: 'Bottom Center',
                position: BlueprintTooltipPosition.bottom,
                disabled: !_tooltipsEnabled,
                child: const BlueprintButton(
                  text: 'Bottom',
                  size: BlueprintButtonSize.small,
                ),
              ),
              BlueprintTooltips.simple(
                content: 'Bottom Right',
                position: BlueprintTooltipPosition.bottomRight,
                disabled: !_tooltipsEnabled,
                child: const BlueprintButton(
                  text: 'Bottom Right',
                  size: BlueprintButtonSize.small,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIntentTooltips() {
    return BlueprintCard(
      child: Wrap(
        spacing: BlueprintTheme.gridSize * 2,
        runSpacing: BlueprintTheme.gridSize * 2,
        children: [
          BlueprintTooltips.intent(
            content: 'Primary intent tooltip',
            intent: BlueprintIntent.primary,
            disabled: !_tooltipsEnabled,
            child: const BlueprintButton(
              text: 'Primary',
              intent: BlueprintIntent.primary,
            ),
          ),
          BlueprintTooltips.intent(
            content: 'Success intent tooltip',
            intent: BlueprintIntent.success,
            disabled: !_tooltipsEnabled,
            child: const BlueprintButton(
              text: 'Success',
              intent: BlueprintIntent.success,
            ),
          ),
          BlueprintTooltips.intent(
            content: 'Warning intent tooltip',
            intent: BlueprintIntent.warning,
            disabled: !_tooltipsEnabled,
            child: const BlueprintButton(
              text: 'Warning',
              intent: BlueprintIntent.warning,
            ),
          ),
          BlueprintTooltips.intent(
            content: 'Danger intent tooltip',
            intent: BlueprintIntent.danger,
            disabled: !_tooltipsEnabled,
            child: const BlueprintButton(
              text: 'Danger',
              intent: BlueprintIntent.danger,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVariantTooltips() {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Compact vs Normal:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          Wrap(
            spacing: BlueprintTheme.gridSize * 2,
            children: [
              BlueprintTooltips.compact(
                content: 'Compact tooltip with less padding',
                disabled: !_tooltipsEnabled,
                child: const BlueprintButton(
                  text: 'Compact',
                  size: BlueprintButtonSize.small,
                ),
              ),
              BlueprintTooltips.simple(
                content: 'Normal tooltip with standard padding',
                disabled: !_tooltipsEnabled,
                child: const BlueprintButton(
                  text: 'Normal',
                  size: BlueprintButtonSize.small,
                ),
              ),
            ],
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          const Text(
            'Minimal (no arrow):',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          BlueprintTooltips.minimal(
            content: 'Minimal tooltip without arrow',
            disabled: !_tooltipsEnabled,
            child: const BlueprintButton(
              text: 'Minimal',
              size: BlueprintButtonSize.small,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveExamples() {
    return Column(
      children: [
        _buildIconRowExample(),
        const SizedBox(height: BlueprintTheme.gridSize * 2),
        _buildFormExample(),
        const SizedBox(height: BlueprintTheme.gridSize * 2),
        _buildCardExample(),
      ],
    );
  }

  Widget _buildIconRowExample() {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Toolbar with Tooltips:',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          Row(
            children: [
              BlueprintTooltips.simple(
                content: 'Save document',
                disabled: !_tooltipsEnabled,
                child: IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () => _showSnackBar('Save clicked'),
                ),
              ),
              BlueprintTooltips.simple(
                content: 'Open file',
                disabled: !_tooltipsEnabled,
                child: IconButton(
                  icon: const Icon(Icons.folder_open),
                  onPressed: () => _showSnackBar('Open clicked'),
                ),
              ),
              BlueprintTooltips.simple(
                content: 'Print document',
                disabled: !_tooltipsEnabled,
                child: IconButton(
                  icon: const Icon(Icons.print),
                  onPressed: () => _showSnackBar('Print clicked'),
                ),
              ),
              const VerticalDivider(),
              BlueprintTooltips.simple(
                content: 'Cut selection',
                disabled: !_tooltipsEnabled,
                child: IconButton(
                  icon: const Icon(Icons.content_cut),
                  onPressed: () => _showSnackBar('Cut clicked'),
                ),
              ),
              BlueprintTooltips.simple(
                content: 'Copy selection',
                disabled: !_tooltipsEnabled,
                child: IconButton(
                  icon: const Icon(Icons.content_copy),
                  onPressed: () => _showSnackBar('Copy clicked'),
                ),
              ),
              BlueprintTooltips.simple(
                content: 'Paste from clipboard',
                disabled: !_tooltipsEnabled,
                child: IconButton(
                  icon: const Icon(Icons.content_paste),
                  onPressed: () => _showSnackBar('Paste clicked'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormExample() {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Form with Help Tooltips:',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          _buildFormField(
            'Username',
            'Enter your unique username (3-20 characters)',
            Icons.help_outline,
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          _buildFormField(
            'Password',
            'Password must be at least 8 characters with uppercase, lowercase, and numbers',
            Icons.info_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, String helpText, IconData helpIcon) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: BlueprintTheme.gridSize),
        BlueprintTooltips.simple(
          content: helpText,
          position: BlueprintTooltipPosition.left,
          disabled: !_tooltipsEnabled,
          child: Icon(
            helpIcon,
            color: BlueprintColors.textColorMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildCardExample() {
    return Row(
      children: [
        Expanded(
          child: BlueprintTooltips.simple(
            content: 'Click to expand this card and view more details',
            position: BlueprintTooltipPosition.top,
            disabled: !_tooltipsEnabled,
            child: BlueprintCard(
              elevation: BlueprintElevation.one,
              interactive: true,
              onTap: () => _showSnackBar('Card clicked'),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.article, color: BlueprintColors.intentPrimary),
                      SizedBox(width: BlueprintTheme.gridSize),
                      Text(
                        'Interactive Card',
                        style: TextStyle(
                          fontSize: BlueprintTheme.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: BlueprintTheme.gridSize * 0.5),
                  Text(
                    'Hover over this card to see the tooltip',
                    style: TextStyle(color: BlueprintColors.textColorMuted),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControls() {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tooltip Controls:',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          Row(
            children: [
              Switch(
                value: _tooltipsEnabled,
                onChanged: (value) => setState(() => _tooltipsEnabled = value),
                activeColor: BlueprintColors.intentPrimary,
              ),
              const SizedBox(width: BlueprintTheme.gridSize),
              Text(
                _tooltipsEnabled ? 'Tooltips Enabled' : 'Tooltips Disabled',
                style: const TextStyle(fontSize: BlueprintTheme.fontSize),
              ),
            ],
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          const Text(
            'Use the toggle above to enable/disable all tooltips on this page.',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSizeSmall,
              color: BlueprintColors.textColorMuted,
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: BlueprintColors.intentPrimary,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}