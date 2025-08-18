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
            const Text('• Multiple styling variants (simple, panel, folder)'),
            const Text('• Icon support for visual hierarchy'),
            const Text('• Self-managed state or external control'),
            const Text('• Nestable for complex hierarchies'),
            
            const SizedBox(height: BlueprintTheme.gridSize),
            
            const Text(
              'Usage Patterns:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: BlueprintTheme.gridSize * 0.5),
            const Text('• Use simple style for basic collapsible content'),
            const Text('• Use panel style for sections with icons'),
            const Text('• Use folder style for file/folder hierarchies'),
            const Text('• Use manual control for coordinated state'),
            
            const SizedBox(height: BlueprintTheme.gridSize),
            
            const Text(
              'Factory Methods:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: BlueprintTheme.gridSize * 0.5),
            const Text('• BlueprintCollapses.simple() - Basic collapsible panel'),
            const Text('• BlueprintCollapses.panel() - Panel with icon and styling'),
            const Text('• BlueprintCollapses.folder() - Folder-style collapse'),
            const Text('• BlueprintCollapse() - Core collapse widget'),
          ],
        ),
      ),
    );
  }
}