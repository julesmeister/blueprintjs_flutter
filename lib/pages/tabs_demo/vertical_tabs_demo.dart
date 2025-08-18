import 'package:flutter/material.dart';
import '../../theme/blueprint_colors.dart';
import '../../components/blueprint_card.dart';
import '../../components/blueprint_tabs.dart';
import 'tab_content.dart';

class VerticalTabsDemo extends StatelessWidget {
  const VerticalTabsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlueprintCard(
      elevation: BlueprintElevation.one,
      padding: EdgeInsets.zero,
      child: BlueprintTabs(
        vertical: true,
        tabs: [
          BlueprintTab(
            id: 'overview',
            title: 'Overview',
            icon: Icons.visibility,
            content: TabContent(
              title: 'Overview',
              description: 'Get a high-level view of your project status.',
              icon: Icons.visibility,
              color: BlueprintColors.intentPrimary,
            ),
          ),
          BlueprintTab(
            id: 'details',
            title: 'Details',
            icon: Icons.info,
            content: TabContent(
              title: 'Details',
              description: 'Dive deep into the specifics and detailed information.',
              icon: Icons.info,
              color: BlueprintColors.intentSuccess,
            ),
          ),
          BlueprintTab(
            id: 'reports',
            title: 'Reports',
            icon: Icons.assessment,
            content: TabContent(
              title: 'Reports',
              description: 'View comprehensive reports and analysis.',
              icon: Icons.assessment,
              color: BlueprintColors.intentWarning,
            ),
          ),
        ],
      ),
    );
  }
}