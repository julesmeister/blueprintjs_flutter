import 'package:flutter/material.dart';
import '../../theme/blueprint_theme.dart';
import '../../components/blueprint_collapse.dart';

class CollapseBasicTab extends StatelessWidget {
  const CollapseBasicTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Basic Collapse Panels',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSizeLarge,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          
          BlueprintCollapseExample(
            buttonText: 'Basic Information',
            initiallyOpen: true,
            child: const Padding(
              padding: EdgeInsets.all(BlueprintTheme.gridSize),
              child: Text('This is a basic collapsible panel. Click the button to toggle visibility.'),
            ),
          ),
          
          const SizedBox(height: BlueprintTheme.gridSize),
          
          BlueprintCollapseExample(
            buttonText: 'Initially Collapsed',
            initiallyOpen: false,
            child: const Padding(
              padding: EdgeInsets.all(BlueprintTheme.gridSize),
              child: Text('This panel starts collapsed. The component maintains its own state.'),
            ),
          ),
        ],
      ),
    );
  }
}