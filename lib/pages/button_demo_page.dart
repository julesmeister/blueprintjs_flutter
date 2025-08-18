import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_button.dart';

class ButtonDemoPage extends StatelessWidget {
  const ButtonDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blueprint Buttons'),
        backgroundColor: BlueprintColors.intentPrimary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Intent Colors', _buildIntentButtons(context)),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Button Variants', _buildVariantButtons(context)),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Button Sizes', _buildSizeButtons(context)),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('With Icons', _buildIconButtons(context)),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Button States', _buildStateButtons(context)),
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

  Widget _buildIntentButtons(BuildContext context) {
    return Wrap(
      spacing: BlueprintTheme.gridSize,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintButton(
          text: 'Default',
          onPressed: () => _showSnackBar(context, 'Default button pressed'),
        ),
        BlueprintButtons.primary(
          text: 'Primary',
          onPressed: () => _showSnackBar(context, 'Primary button pressed'),
        ),
        BlueprintButton(
          text: 'Success',
          intent: BlueprintIntent.success,
          onPressed: () => _showSnackBar(context, 'Success button pressed'),
        ),
        BlueprintButton(
          text: 'Warning',
          intent: BlueprintIntent.warning,
          onPressed: () => _showSnackBar(context, 'Warning button pressed'),
        ),
        BlueprintButton(
          text: 'Danger',
          intent: BlueprintIntent.danger,
          onPressed: () => _showSnackBar(context, 'Danger button pressed'),
        ),
      ],
    );
  }

  Widget _buildVariantButtons(BuildContext context) {
    return Wrap(
      spacing: BlueprintTheme.gridSize,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintButton(
          text: 'Solid',
          intent: BlueprintIntent.primary,
          onPressed: () => _showSnackBar(context, 'Solid button pressed'),
        ),
        BlueprintButtons.minimal(
          text: 'Minimal',
          intent: BlueprintIntent.primary,
          onPressed: () => _showSnackBar(context, 'Minimal button pressed'),
        ),
        BlueprintButtons.outlined(
          text: 'Outlined',
          intent: BlueprintIntent.primary,
          onPressed: () => _showSnackBar(context, 'Outlined button pressed'),
        ),
      ],
    );
  }

  Widget _buildSizeButtons(BuildContext context) {
    return Wrap(
      spacing: BlueprintTheme.gridSize,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintButton(
          text: 'Small',
          intent: BlueprintIntent.primary,
          size: BlueprintButtonSize.small,
          onPressed: () => _showSnackBar(context, 'Small button pressed'),
        ),
        BlueprintButton(
          text: 'Medium',
          intent: BlueprintIntent.primary,
          size: BlueprintButtonSize.medium,
          onPressed: () => _showSnackBar(context, 'Medium button pressed'),
        ),
        BlueprintButton(
          text: 'Large',
          intent: BlueprintIntent.primary,
          size: BlueprintButtonSize.large,
          onPressed: () => _showSnackBar(context, 'Large button pressed'),
        ),
      ],
    );
  }

  Widget _buildIconButtons(BuildContext context) {
    return Wrap(
      spacing: BlueprintTheme.gridSize,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintButton(
          text: 'Download',
          icon: Icons.download,
          intent: BlueprintIntent.primary,
          onPressed: () => _showSnackBar(context, 'Download button pressed'),
        ),
        BlueprintButton(
          text: 'Upload',
          icon: Icons.upload,
          intent: BlueprintIntent.success,
          onPressed: () => _showSnackBar(context, 'Upload button pressed'),
        ),
        BlueprintButton(
          text: 'Settings',
          endIcon: Icons.settings,
          intent: BlueprintIntent.none,
          onPressed: () => _showSnackBar(context, 'Settings button pressed'),
        ),
        BlueprintButton(
          text: 'Save',
          icon: Icons.save,
          endIcon: Icons.keyboard_arrow_down,
          intent: BlueprintIntent.primary,
          onPressed: () => _showSnackBar(context, 'Save button pressed'),
        ),
      ],
    );
  }

  Widget _buildStateButtons(BuildContext context) {
    return Wrap(
      spacing: BlueprintTheme.gridSize,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintButton(
          text: 'Loading',
          intent: BlueprintIntent.primary,
          loading: true,
          onPressed: () {},
        ),
        BlueprintButton(
          text: 'Disabled',
          intent: BlueprintIntent.primary,
          disabled: true,
          onPressed: () {},
        ),
        BlueprintButton(
          text: 'Primary Button',
          intent: BlueprintIntent.primary,
          onPressed: () => _showSnackBar(context, 'Primary button pressed'),
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: BlueprintColors.intentPrimary,
      ),
    );
  }
}