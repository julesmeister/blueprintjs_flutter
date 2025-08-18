import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_callout.dart';
import '../components/blueprint_switch.dart';
import '../components/blueprint_button.dart';
import '../components/blueprint_card.dart';

class CalloutDemoPage extends StatefulWidget {
  const CalloutDemoPage({Key? key}) : super(key: key);

  @override
  State<CalloutDemoPage> createState() => _CalloutDemoPageState();
}

class _CalloutDemoPageState extends State<CalloutDemoPage> {
  bool _showDismissibleCallout = true;
  bool _showMinimalCallouts = false;
  bool _showCompactCallouts = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blueprint Callouts'),
        backgroundColor: BlueprintColors.intentPrimary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Intent Colors', _buildIntentCallouts()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('With Icons', _buildIconCallouts()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Dismissible Callouts', _buildDismissibleCallouts()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Compact vs Normal', _buildSizeVariants()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Minimal Style', _buildMinimalCallouts()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Rich Content', _buildRichContentCallouts()),
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

  Widget _buildIntentCallouts() {
    return Column(
      children: [
        BlueprintCallouts.basic(
          title: 'Default Callout',
          content: 'This is a basic callout with no specific intent. It provides general information to the user.',
        ),
        BlueprintCallouts.info(
          title: 'Information',
          content: 'This callout provides helpful information or tips to guide the user.',
        ),
        BlueprintCallouts.success(
          title: 'Success',
          content: 'This callout indicates that an operation completed successfully.',
        ),
        BlueprintCallouts.warning(
          title: 'Warning',
          content: 'This callout warns the user about potential issues or important considerations.',
        ),
        BlueprintCallouts.danger(
          title: 'Danger',
          content: 'This callout alerts the user to critical errors or dangerous actions.',
        ),
      ],
    );
  }

  Widget _buildIconCallouts() {
    return Column(
      children: [
        BlueprintCallout(
          title: 'Custom Icon',
          content: 'You can specify custom icons for callouts to better represent the content.',
          icon: Icons.lightbulb_outline,
          intent: BlueprintIntent.primary,
        ),
        BlueprintCallout(
          title: 'Document Status',
          content: 'Your document has been saved and is ready for review.',
          icon: Icons.description,
          intent: BlueprintIntent.success,
        ),
        BlueprintCallout(
          title: 'Security Notice',
          content: 'Please review your security settings to ensure your account is protected.',
          icon: Icons.security,
          intent: BlueprintIntent.warning,
        ),
      ],
    );
  }

  Widget _buildDismissibleCallouts() {
    return Column(
      children: [
        if (_showDismissibleCallout)
          BlueprintCallouts.info(
            title: 'Dismissible Callout',
            content: 'This callout can be dismissed by clicking the close button.',
            onDismiss: () {
              setState(() {
                _showDismissibleCallout = false;
              });
            },
          ),
        if (!_showDismissibleCallout)
          BlueprintCard(
            child: Column(
              children: [
                const Text(
                  'The callout has been dismissed.',
                  style: TextStyle(color: BlueprintColors.textColorMuted),
                ),
                const SizedBox(height: BlueprintTheme.gridSize),
                BlueprintButton(
                  text: 'Show Again',
                  intent: BlueprintIntent.primary,
                  size: BlueprintButtonSize.small,
                  onPressed: () {
                    setState(() {
                      _showDismissibleCallout = true;
                    });
                  },
                ),
              ],
            ),
          ),
        BlueprintCallouts.warning(
          title: 'Important Update',
          content: 'A new version of the application is available. Please update to continue receiving security fixes.',
          onDismiss: () => _showSnackBar('Update reminder dismissed'),
        ),
      ],
    );
  }

  Widget _buildSizeVariants() {
    return Column(
      children: [
        const Text(
          'Normal Size:',
          style: TextStyle(
            fontSize: BlueprintTheme.fontSize,
            fontWeight: FontWeight.w600,
            color: BlueprintColors.headingColor,
          ),
        ),
        const SizedBox(height: BlueprintTheme.gridSize),
        BlueprintCallouts.info(
          title: 'Standard Callout',
          content: 'This is a callout with normal spacing and padding.',
          compact: _showCompactCallouts,
        ),
        const SizedBox(height: BlueprintTheme.gridSize * 2),
        const Text(
          'Compact Size:',
          style: TextStyle(
            fontSize: BlueprintTheme.fontSize,
            fontWeight: FontWeight.w600,
            color: BlueprintColors.headingColor,
          ),
        ),
        const SizedBox(height: BlueprintTheme.gridSize),
        BlueprintCallouts.success(
          title: 'Compact Callout',
          content: 'This callout uses compact spacing to save vertical space.',
          compact: true,
        ),
      ],
    );
  }

  Widget _buildMinimalCallouts() {
    return Column(
      children: [
        BlueprintCallouts.info(
          title: 'Minimal Style',
          content: 'Minimal callouts have no background color and use borders instead.',
          minimal: _showMinimalCallouts,
        ),
        BlueprintCallouts.warning(
          title: 'Border Only',
          content: 'This style is useful when you want less visual weight.',
          minimal: _showMinimalCallouts,
        ),
      ],
    );
  }

  Widget _buildRichContentCallouts() {
    return Column(
      children: [
        BlueprintCallout(
          title: 'Rich Content Example',
          intent: BlueprintIntent.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Callouts can contain any widget content, not just text:',
                style: TextStyle(height: 1.4),
              ),
              const SizedBox(height: BlueprintTheme.gridSize),
              Row(
                children: [
                  BlueprintButton(
                    text: 'Action',
                    intent: BlueprintIntent.primary,
                    size: BlueprintButtonSize.small,
                    onPressed: () => _showSnackBar('Action button pressed'),
                  ),
                  const SizedBox(width: BlueprintTheme.gridSize),
                  BlueprintButton(
                    text: 'Cancel',
                    size: BlueprintButtonSize.small,
                    onPressed: () => _showSnackBar('Cancel button pressed'),
                  ),
                ],
              ),
            ],
          ),
        ),
        BlueprintCallout(
          title: 'Feature Announcement',
          intent: BlueprintIntent.success,
          icon: Icons.new_releases,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'We\'ve added new features to improve your experience:',
                style: TextStyle(height: 1.4),
              ),
              const SizedBox(height: BlueprintTheme.gridSize),
              const Text('• Enhanced search functionality'),
              const Text('• Improved performance'),
              const Text('• New keyboard shortcuts'),
              const SizedBox(height: BlueprintTheme.gridSize),
              BlueprintButton(
                text: 'Learn More',
                intent: BlueprintIntent.success,
                size: BlueprintButtonSize.small,
                onPressed: () => _showSnackBar('Learn more clicked'),
              ),
            ],
          ),
        ),
        BlueprintCallout(
          title: 'Data Visualization',
          intent: BlueprintIntent.none,
          icon: Icons.bar_chart,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  BlueprintColors.blue5.withOpacity(0.3),
                  BlueprintColors.blue3.withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
            ),
            child: const Center(
              child: Text(
                'Chart or visualization content would go here',
                style: TextStyle(color: BlueprintColors.textColorMuted),
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
            'Callout Options:',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          _buildControlRow(
            'Show Minimal Style',
            _showMinimalCallouts,
            (value) => setState(() => _showMinimalCallouts = value),
          ),
          _buildControlRow(
            'Use Compact Size',
            _showCompactCallouts,
            (value) => setState(() => _showCompactCallouts = value),
          ),
        ],
      ),
    );
  }

  Widget _buildControlRow(String label, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: BlueprintTheme.gridSize * 0.5),
      child: BlueprintSwitches.withLabel(
        value: value,
        label: label,
        onChanged: onChanged,
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