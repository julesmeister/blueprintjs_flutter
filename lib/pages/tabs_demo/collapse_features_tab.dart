import 'package:flutter/material.dart';
import '../../theme/blueprint_theme.dart';

class CollapseFeaturesTab extends StatelessWidget {
  const CollapseFeaturesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
      child: Container(
        padding: const EdgeInsets.all(BlueprintTheme.gridSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Features Overview',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: BlueprintTheme.fontSizeLarge,
              ),
            ),
            const SizedBox(height: BlueprintTheme.gridSize),
            
            const Text(
              'Collapse Features:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: BlueprintTheme.gridSize * 0.5),
            const Text('• Smooth expand/collapse animations'),
            const Text('• Button-based triggers matching Blueprint.js design'),
            const Text('• Self-managed state or external control'),
            const Text('• Nestable for complex hierarchies'),
            
            const SizedBox(height: BlueprintTheme.gridSize),
            
            const Text(
              'Usage Patterns:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: BlueprintTheme.gridSize * 0.5),
            const Text('• Use BlueprintCollapse for animation-only wrapper'),
            const Text('• Use BlueprintButton as separate trigger component'),
            const Text('• Use BlueprintCollapseExample for common button+collapse pattern'),
            const Text('• Combine with other components for rich interactions'),
            
            const SizedBox(height: BlueprintTheme.gridSize),
            
            const Text(
              'Component Architecture:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: BlueprintTheme.gridSize * 0.5),
            const Text('• BlueprintCollapse - Core animation wrapper'),
            const Text('• BlueprintButton - Separate trigger component'),
            const Text('• BlueprintCollapseExample - Combined example widget'),
            const Text('• Follows Blueprint.js separation of concerns'),
          ],
        ),
      ),
    );
  }
}