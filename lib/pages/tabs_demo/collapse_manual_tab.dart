import 'package:flutter/material.dart';
import '../../theme/blueprint_theme.dart';
import '../../theme/blueprint_colors.dart';
import '../../components/blueprint_collapse.dart';
import '../../components/blueprint_button.dart';

class CollapseManualTab extends StatefulWidget {
  const CollapseManualTab({Key? key}) : super(key: key);

  @override
  State<CollapseManualTab> createState() => _CollapseManualTabState();
}

class _CollapseManualTabState extends State<CollapseManualTab> {
  bool _manualCollapse1 = false;
  bool _manualCollapse2 = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Manual Control Examples',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSizeLarge,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          
          const Text(
            'These collapse panels are controlled manually via state:',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: BlueprintColors.textColorMuted,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          
          // Manual control buttons
          Row(
            children: [
              BlueprintButton(
                text: 'Toggle Panel 1',
                variant: BlueprintButtonVariant.minimal,
                onPressed: () => setState(() => _manualCollapse1 = !_manualCollapse1),
              ),
              const SizedBox(width: BlueprintTheme.gridSize),
              BlueprintButton(
                text: 'Toggle Panel 2',
                variant: BlueprintButtonVariant.minimal,
                onPressed: () => setState(() => _manualCollapse2 = !_manualCollapse2),
              ),
            ],
          ),
          
          const SizedBox(height: BlueprintTheme.gridSize),
          
          // Manually controlled panels
          _buildManualPanel(
            'Manually Controlled Panel 1',
            Icons.control_camera,
            _manualCollapse1,
            'This panel is controlled by external state. Use the buttons above to toggle it.',
          ),
          
          const SizedBox(height: BlueprintTheme.gridSize * 0.5),
          
          _buildManualPanel(
            'Manually Controlled Panel 2',
            Icons.settings_remote,
            _manualCollapse2,
            'This panel starts open and can be controlled externally.',
          ),
        ],
      ),
    );
  }

  Widget _buildManualPanel(String title, IconData icon, bool isOpen, String content) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => setState(() {
              if (title.contains('Panel 1')) {
                _manualCollapse1 = !_manualCollapse1;
              } else {
                _manualCollapse2 = !_manualCollapse2;
              }
            }),
            child: Container(
              padding: const EdgeInsets.all(BlueprintTheme.gridSize),
              child: Row(
                children: [
                  AnimatedRotation(
                    turns: isOpen ? 0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.chevron_right, size: 16),
                  ),
                  const SizedBox(width: BlueprintTheme.gridSize),
                  Icon(icon, size: 16),
                  const SizedBox(width: BlueprintTheme.gridSize),
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
        ),
        BlueprintCollapse(
          isOpen: isOpen,
          child: Container(
            padding: const EdgeInsets.all(BlueprintTheme.gridSize),
            child: Text(content),
          ),
        ),
      ],
    );
  }
}