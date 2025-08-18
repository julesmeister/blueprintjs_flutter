import 'package:flutter/material.dart';
import '../../theme/blueprint_theme.dart';
import '../../components/blueprint_collapse.dart';

class CollapseStylesTab extends StatelessWidget {
  const CollapseStylesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Styled Collapse Variants',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSizeLarge,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          
          BlueprintCollapseExample(
            buttonText: 'Panel with Icon',
            initiallyOpen: true,
            child: const Padding(
              padding: EdgeInsets.all(BlueprintTheme.gridSize),
              child: Text('Panel style with an icon for visual emphasis.'),
            ),
          ),
          
          const SizedBox(height: BlueprintTheme.gridSize),
          
          BlueprintCollapseExample(
            buttonText: 'Folder Style',
            initiallyOpen: false,
            child: Padding(
              padding: const EdgeInsets.all(BlueprintTheme.gridSize),
              child: Column(
                children: [
                  _buildFileItem('document.pdf', Icons.picture_as_pdf),
                  _buildFileItem('image.jpg', Icons.image),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          
          const Text(
            'Nested Collapse Panels',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSizeLarge,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          
          BlueprintCollapseExample(
            buttonText: 'Parent Panel',
            initiallyOpen: true,
            child: Padding(
              padding: const EdgeInsets.all(BlueprintTheme.gridSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('This parent panel contains nested collapse panels:'),
                  const SizedBox(height: BlueprintTheme.gridSize),
                  
                  BlueprintCollapseExample(
                    buttonText: 'Nested Panel 1',
                    initiallyOpen: false,
                    child: const Padding(
                      padding: EdgeInsets.all(BlueprintTheme.gridSize),
                      child: Text('Content of the first nested panel.'),
                    ),
                  ),
                  
                  const SizedBox(height: BlueprintTheme.gridSize * 0.5),
                  
                  BlueprintCollapseExample(
                    buttonText: 'Nested Panel 2',
                    initiallyOpen: false,
                    child: const Padding(
                      padding: EdgeInsets.all(BlueprintTheme.gridSize),
                      child: Text('Content of the second nested panel.'),
                    ),
                  ),
                ],
              ),
            ),
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
          Icon(icon, size: 16),
          const SizedBox(width: BlueprintTheme.gridSize),
          Text(name),
        ],
      ),
    );
  }
}