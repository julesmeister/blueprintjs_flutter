import 'package:flutter/material.dart';
import '../components/blueprint_switch.dart';
import '../components/demo_page_scaffold.dart';
import '../components/blueprint_common.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import 'popover/popover_basic_demos.dart';
import 'popover/popover_hover_demos.dart';
import 'popover/popover_positioning_demos.dart';
import 'popover/popover_menu_demos.dart';
import 'popover/popover_other_demos.dart';

class PopoverDemoPage extends StatefulWidget {
  const PopoverDemoPage({super.key});

  @override
  State<PopoverDemoPage> createState() => _PopoverDemoPageState();
}

class _PopoverDemoPageState extends State<PopoverDemoPage> {
  int _clickCount = 0;
  bool _popoversEnabled = true;

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      title: 'Blueprint Popovers',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('Basic Popovers', PopoverBasicDemos.buildBasicPopovers(_popoversEnabled, _showSnackBar)),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Hover Popovers', PopoverHoverDemos.buildHoverPopovers(_popoversEnabled)),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Popover Positioning', PopoverPositioningDemos.buildPositioningDemo(_popoversEnabled)),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Menu Popovers', PopoverMenuDemos.buildMenuPopovers(_showSnackBar)),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Confirmation Popovers', PopoverOtherDemos.buildConfirmationPopovers(_showSnackBar)),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Intent Colors', PopoverOtherDemos.buildIntentPopovers(_popoversEnabled)),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Interactive Content', PopoverOtherDemos.buildInteractiveContentDemo(_popoversEnabled, _clickCount, _updateClickCount, _showSnackBar)),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Real-world Examples', PopoverOtherDemos.buildRealWorldExamples(_popoversEnabled, _showSnackBar)),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Controls', _buildControls()),
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

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(BlueprintTheme.gridSize),
      decoration: BoxDecoration(
        color: BlueprintColors.lightGray5,
        borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
        border: Border.all(color: BlueprintColors.gray5),
      ),
      child: Row(
        children: [
          const Icon(Icons.settings, size: 20, color: BlueprintColors.textColorMuted),
          const SizedBox(width: BlueprintTheme.gridSize),
          const Text(
            'Popover Controls:',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: BlueprintTheme.gridSize * 2),
          BlueprintSwitch(
            label: 'Enable Popovers',
            value: _popoversEnabled,
            onChanged: (value) => setState(() => _popoversEnabled = value),
          ),
        ],
      ),
    );
  }

  void _updateClickCount(int newCount) {
    setState(() => _clickCount = newCount);
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