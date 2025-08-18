import 'package:flutter/material.dart';
import '../../theme/blueprint_theme.dart';
import '../../theme/blueprint_colors.dart';
import '../../components/blueprint_card.dart';
import '../../components/blueprint_tabs.dart';
import '../../components/blueprint_button.dart';
import 'tab_content.dart';

class ControlledTabsDemo extends StatelessWidget {
  final String selectedTab;
  final Function(String) onTabChanged;

  const ControlledTabsDemo({
    Key? key,
    required this.selectedTab,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            BlueprintButton(
              text: 'Select Tab 1',
              intent: selectedTab == 'tab1' ? BlueprintIntent.primary : BlueprintIntent.none,
              onPressed: () => onTabChanged('tab1'),
            ),
            const SizedBox(width: BlueprintTheme.gridSize),
            BlueprintButton(
              text: 'Select Tab 2',
              intent: selectedTab == 'tab2' ? BlueprintIntent.primary : BlueprintIntent.none,
              onPressed: () => onTabChanged('tab2'),
            ),
            const SizedBox(width: BlueprintTheme.gridSize),
            BlueprintButton(
              text: 'Select Tab 3',
              intent: selectedTab == 'tab3' ? BlueprintIntent.primary : BlueprintIntent.none,
              onPressed: () => onTabChanged('tab3'),
            ),
          ],
        ),
        const SizedBox(height: BlueprintTheme.gridSize),
        BlueprintCard(
          elevation: BlueprintElevation.one,
          padding: EdgeInsets.zero,
          child: BlueprintTabs(
            selectedTabId: selectedTab,
            onTabChanged: onTabChanged,
            tabs: [
              BlueprintTab(
                id: 'tab1',
                title: 'First Tab',
                content: TabContent(
                  title: 'First Tab',
                  description: 'This is the content of the first tab. The selection is controlled externally.',
                  icon: Icons.looks_one,
                  color: BlueprintColors.blue1,
                ),
              ),
              BlueprintTab(
                id: 'tab2',
                title: 'Second Tab',
                content: TabContent(
                  title: 'Second Tab',
                  description: 'This is the content of the second tab. Click the buttons above to change tabs.',
                  icon: Icons.looks_two,
                  color: BlueprintColors.blue2,
                ),
              ),
              BlueprintTab(
                id: 'tab3',
                title: 'Third Tab',
                content: TabContent(
                  title: 'Third Tab',
                  description: 'This is the content of the third tab. The state is managed by the parent widget.',
                  icon: Icons.looks_3,
                  color: BlueprintColors.blue3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}