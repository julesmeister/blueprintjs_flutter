import 'package:flutter/material.dart';
import '../../theme/blueprint_colors.dart';
import '../../components/blueprint_card.dart';
import '../../components/blueprint_tabs.dart';
import 'tab_content.dart';

class LargeTabsDemo extends StatelessWidget {
  const LargeTabsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlueprintCard(
      elevation: BlueprintElevation.one,
      padding: EdgeInsets.zero,
      child: BlueprintTabs(
        size: BlueprintTabSize.large,
        tabs: [
          BlueprintTab(
            id: 'dashboard',
            title: 'Dashboard',
            icon: Icons.dashboard,
            content: TabContent(
              title: 'Dashboard',
              description: 'Overview of your key metrics and performance indicators.',
              icon: Icons.dashboard,
              color: BlueprintColors.intentPrimary,
            ),
          ),
          BlueprintTab(
            id: 'analytics',
            title: 'Analytics',
            icon: Icons.analytics,
            content: TabContent(
              title: 'Analytics',
              description: 'Detailed analytics and reporting for your data.',
              icon: Icons.analytics,
              color: BlueprintColors.intentSuccess,
            ),
          ),
        ],
      ),
    );
  }
}