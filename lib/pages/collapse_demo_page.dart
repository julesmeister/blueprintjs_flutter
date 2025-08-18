import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_switch.dart';
import '../components/blueprint_tabs.dart';
import '../components/demo_page_scaffold.dart';
import 'tabs_demo/collapse_basic_tab.dart';
import 'tabs_demo/collapse_styles_tab.dart';
import 'tabs_demo/collapse_interactive_tab.dart';
import 'tabs_demo/collapse_manual_tab.dart';
import 'tabs_demo/collapse_features_tab.dart';

class CollapseDemoPage extends StatefulWidget {
  const CollapseDemoPage({Key? key}) : super(key: key);

  @override
  State<CollapseDemoPage> createState() => _CollapseDemoPageState();
}

class _CollapseDemoPageState extends State<CollapseDemoPage> {
  bool _showAnimations = true;

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      title: 'Collapse Components',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildControls(),
          const SizedBox(height: BlueprintTheme.gridSize),
          SizedBox(
            height: 500, // Fixed height for the tabs
            child: BlueprintTabs(
              tabs: [
                BlueprintTab(
                  id: 'basic',
                  title: 'Basic',
                  content: const CollapseBasicTab(),
                ),
                BlueprintTab(
                  id: 'styles',
                  title: 'Styles',
                  content: const CollapseStylesTab(),
                ),
                BlueprintTab(
                  id: 'interactive',
                  title: 'Interactive',
                  content: const CollapseInteractiveTab(),
                ),
                BlueprintTab(
                  id: 'manual',
                  title: 'Manual Control',
                  content: const CollapseManualTab(),
                ),
                BlueprintTab(
                  id: 'features',
                  title: 'Features',
                  content: const CollapseFeaturesTab(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      margin: const EdgeInsets.all(BlueprintTheme.gridSize),
      padding: const EdgeInsets.all(BlueprintTheme.gridSize),
      decoration: BoxDecoration(
        color: BlueprintColors.lightGray5,
        borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
      ),
      child: Row(
        children: [
          BlueprintSwitches.withLabel(
            label: 'Show Animations',
            value: _showAnimations,
            onChanged: (value) => setState(() => _showAnimations = value),
          ),
        ],
      ),
    );
  }
}