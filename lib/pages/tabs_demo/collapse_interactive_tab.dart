import 'package:flutter/material.dart';
import '../../theme/blueprint_theme.dart';
import '../../components/blueprint_collapse.dart';
import '../../components/blueprint_button.dart';
import '../../components/blueprint_tag.dart';

class CollapseInteractiveTab extends StatelessWidget {
  const CollapseInteractiveTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Interactive Content',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSizeLarge,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          
          BlueprintCollapseExample(
            buttonText: 'Interactive Content',
            initiallyOpen: true,
            child: Padding(
              padding: const EdgeInsets.all(BlueprintTheme.gridSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: BlueprintTheme.gridSize * 0.5,
                    children: [
                      BlueprintTags.withIntent(text: 'Interactive', intent: BlueprintIntent.primary),
                      BlueprintTags.withIntent(text: 'Demo', intent: BlueprintIntent.success),
                    ],
                  ),
                  const SizedBox(height: BlueprintTheme.gridSize),
                  BlueprintButton(
                    text: 'Action',
                    intent: BlueprintIntent.primary,
                    size: BlueprintButtonSize.small,
                    onPressed: () => _showSnackBar(context, 'Action clicked'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}